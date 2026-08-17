/*
 * MobileNetV2 features[8] fixed-point validation model.
 *
 * The program compares two signed INT8 paths against the folded float model:
 *   1) q34: float -> Q3.12 -> keep the upper 8 bits (signed Q3.4)
 *   2) calibrated: symmetric activation INT8 and per-output-channel weight INT8
 *
 * All three BatchNorm operations are folded into convolution weights/biases.
 * Bias and accumulation use INT32 semantics.  Expand/depthwise use ReLU6;
 * project is linear and is followed by the residual addition.
 */

#include <errno.h>
#include <inttypes.h>
#include <limits.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef _WIN32
#include <direct.h>
#define MKDIR(path) _mkdir(path)
#else
#include <sys/stat.h>
#include <sys/types.h>
#define MKDIR(path) mkdir(path, 0777)
#endif

#include "../mobilenetv2_parameters.h"

#define CIN 64
#define CEXP 384
#define H 14
#define W 14
#define HW (H * W)
#define K 3
#define EPS 1.0e-5f

#define INPUT_N ((size_t)CIN * HW)
#define EXP_N ((size_t)CEXP * HW)
#define W0_N ((size_t)CEXP * CIN)
#define W1_N ((size_t)CEXP * K * K)
#define W2_N ((size_t)CIN * CEXP)

typedef struct {
    double max_abs;
    double mean_abs;
    double rmse;
    double cosine;
    size_t worst_index;
} Metrics;

typedef struct {
    int64_t min_acc;
    int64_t max_acc;
    uint64_t saturation_count;
    uint64_t int32_overflow_count;
} StageDiag;

typedef struct {
    float *w0;
    float *b0;
    float *w1;
    float *b1;
    float *w2;
    float *b2;
} FoldedParams;

typedef struct {
    int8_t *input;
    int8_t *w0;
    int8_t *w1;
    int8_t *w2;
    int32_t *b0;
    int32_t *b1;
    int32_t *b2;
    int8_t *expand;
    int8_t *depthwise;
    int8_t *project;
    int8_t *final_out;
    float input_scale;
    float expand_scale;
    float depthwise_scale;
    float project_scale;
    float final_scale;
    float *w0_scales;
    float *w1_scales;
    float *w2_scales;
    StageDiag expand_diag;
    StageDiag depthwise_diag;
    StageDiag project_diag;
    StageDiag final_diag;
    uint64_t input_saturation_count;
    uint64_t weight_saturation_count;
} QuantResult;

typedef struct {
    int32_t multiplier;
    int exponent;
} QuantMultiplier;

typedef enum {
    MODE_BOTH,
    MODE_Q34,
    MODE_CALIBRATED
} RunMode;

static void *xcalloc(size_t count, size_t size)
{
    void *ptr = calloc(count, size);
    if (!ptr) {
        fprintf(stderr, "ERROR: allocation failed for %zu bytes\n", count * size);
        exit(2);
    }
    return ptr;
}

static int load_f32_bin(const char *path, float *data, size_t count)
{
    FILE *fp = fopen(path, "rb");
    if (!fp) {
        fprintf(stderr, "ERROR: cannot open %s: %s\n", path, strerror(errno));
        return -1;
    }
    size_t got = fread(data, sizeof(float), count, fp);
    int extra = fgetc(fp);
    fclose(fp);
    if (got != count || extra != EOF) {
        fprintf(stderr, "ERROR: %s has wrong size (read %zu floats, expected %zu)\n",
                path, got, count);
        return -1;
    }
    return 0;
}

static int write_bin(const char *path, const void *data, size_t elem_size, size_t count)
{
    FILE *fp = fopen(path, "wb");
    if (!fp) {
        fprintf(stderr, "ERROR: cannot write %s: %s\n", path, strerror(errno));
        return -1;
    }
    size_t put = fwrite(data, elem_size, count, fp);
    fclose(fp);
    if (put != count) {
        fprintf(stderr, "ERROR: short write to %s\n", path);
        return -1;
    }
    return 0;
}

static int make_dirs(const char *path)
{
    char tmp[1024];
    size_t len = strlen(path);
    if (len == 0 || len >= sizeof(tmp)) return -1;
    memcpy(tmp, path, len + 1);
    for (size_t i = 1; i < len; ++i) {
        if (tmp[i] == '/' || tmp[i] == '\\') {
            char saved = tmp[i];
            tmp[i] = '\0';
            if (strlen(tmp) > 2 && MKDIR(tmp) != 0 && errno != EEXIST) return -1;
            tmp[i] = saved;
        }
    }
    if (MKDIR(tmp) != 0 && errno != EEXIST) return -1;
    return 0;
}

static void join_path(char *dst, size_t size, const char *dir, const char *name)
{
    size_t len = strlen(dir);
    const char *sep = (len && (dir[len - 1] == '/' || dir[len - 1] == '\\')) ? "" : "/";
    if (snprintf(dst, size, "%s%s%s", dir, sep, name) >= (int)size) {
        fprintf(stderr, "ERROR: output path too long\n");
        exit(2);
    }
}

static int64_t round_away_from_zero(double value)
{
    return value >= 0.0 ? (int64_t)floor(value + 0.5) : (int64_t)ceil(value - 0.5);
}

static int64_t floor_div_pow2(int64_t value, unsigned shift)
{
    if (shift == 0) return value;
    if (value >= 0) return value >> shift;
    uint64_t magnitude = (uint64_t)(-(value + 1)) + 1u;
    uint64_t rounded = (magnitude + (((uint64_t)1 << shift) - 1u)) >> shift;
    return -(int64_t)rounded;
}

static int64_t round_div_pow2(int64_t value, unsigned shift)
{
    if (shift == 0) return value;
    uint64_t magnitude = value >= 0
        ? (uint64_t)value
        : (uint64_t)(-(value + 1)) + 1u;
    uint64_t rounded = (magnitude + ((uint64_t)1 << (shift - 1))) >> shift;
    return value >= 0 ? (int64_t)rounded : -(int64_t)rounded;
}

static int8_t clamp_i8(int64_t value, int lo, int hi, uint64_t *sat_count)
{
    if (value < lo) {
        if (sat_count) ++*sat_count;
        return (int8_t)lo;
    }
    if (value > hi) {
        if (sat_count) ++*sat_count;
        return (int8_t)hi;
    }
    return (int8_t)value;
}

static int32_t checked_i32(double value, const char *name, int index)
{
    int64_t rounded = round_away_from_zero(value);
    if (rounded < INT32_MIN || rounded > INT32_MAX) {
        fprintf(stderr, "ERROR: %s[%d] does not fit INT32\n", name, index);
        exit(2);
    }
    return (int32_t)rounded;
}

static void init_diag(StageDiag *diag)
{
    diag->min_acc = INT64_MAX;
    diag->max_acc = INT64_MIN;
    diag->saturation_count = 0;
    diag->int32_overflow_count = 0;
}

static void observe_acc(StageDiag *diag, int64_t acc)
{
    if (acc < diag->min_acc) diag->min_acc = acc;
    if (acc > diag->max_acc) diag->max_acc = acc;
    if (acc < INT32_MIN || acc > INT32_MAX) ++diag->int32_overflow_count;
}

static float max_abs_f32(const float *data, size_t count)
{
    float result = 0.0f;
    for (size_t i = 0; i < count; ++i) {
        float value = fabsf(data[i]);
        if (value > result) result = value;
    }
    return result;
}

static float nonzero_scale(float max_abs)
{
    return max_abs > 0.0f ? max_abs / 127.0f : 1.0f;
}

static Metrics metrics_f32(const float *actual, const float *reference, size_t count)
{
    Metrics result = {0};
    double sum_abs = 0.0, sum_sq = 0.0, dot = 0.0, aa = 0.0, rr = 0.0;
    for (size_t i = 0; i < count; ++i) {
        double a = actual[i];
        double r = reference[i];
        double error = fabs(a - r);
        if (error > result.max_abs) {
            result.max_abs = error;
            result.worst_index = i;
        }
        sum_abs += error;
        sum_sq += error * error;
        dot += a * r;
        aa += a * a;
        rr += r * r;
    }
    result.mean_abs = sum_abs / (double)count;
    result.rmse = sqrt(sum_sq / (double)count);
    result.cosine = (aa > 0.0 && rr > 0.0) ? dot / sqrt(aa * rr) : 1.0;
    return result;
}

static Metrics metrics_q8(const int8_t *actual, float scale,
                          const float *reference, size_t count)
{
    Metrics result = {0};
    double sum_abs = 0.0, sum_sq = 0.0, dot = 0.0, aa = 0.0, rr = 0.0;
    for (size_t i = 0; i < count; ++i) {
        double a = (double)actual[i] * scale;
        double r = reference[i];
        double error = fabs(a - r);
        if (error > result.max_abs) {
            result.max_abs = error;
            result.worst_index = i;
        }
        sum_abs += error;
        sum_sq += error * error;
        dot += a * r;
        aa += a * a;
        rr += r * r;
    }
    result.mean_abs = sum_abs / (double)count;
    result.rmse = sqrt(sum_sq / (double)count);
    result.cosine = (aa > 0.0 && rr > 0.0) ? dot / sqrt(aa * rr) : 1.0;
    return result;
}

static void allocate_folded(FoldedParams *p)
{
    p->w0 = xcalloc(W0_N, sizeof(float));
    p->b0 = xcalloc(CEXP, sizeof(float));
    p->w1 = xcalloc(W1_N, sizeof(float));
    p->b1 = xcalloc(CEXP, sizeof(float));
    p->w2 = xcalloc(W2_N, sizeof(float));
    p->b2 = xcalloc(CIN, sizeof(float));
}

static void free_folded(FoldedParams *p)
{
    free(p->w0); free(p->b0); free(p->w1);
    free(p->b1); free(p->w2); free(p->b2);
}

static void fold_one(const float *weight, int out_channels, int terms,
                     const float *gamma, const float *beta,
                     const float *mean, const float *variance,
                     float *folded_weight, float *folded_bias)
{
    for (int oc = 0; oc < out_channels; ++oc) {
        float bn_scale = gamma[oc] / sqrtf(variance[oc] + EPS);
        folded_bias[oc] = beta[oc] - mean[oc] * bn_scale;
        for (int i = 0; i < terms; ++i)
            folded_weight[(size_t)oc * terms + i] =
                weight[(size_t)oc * terms + i] * bn_scale;
    }
}

static void build_folded(FoldedParams *p)
{
    fold_one(features_8_conv_0_0_weight, CEXP, CIN,
             features_8_conv_0_1_weight, features_8_conv_0_1_bias,
             features_8_conv_0_1_running_mean, features_8_conv_0_1_running_var,
             p->w0, p->b0);
    fold_one(features_8_conv_1_0_weight, CEXP, K * K,
             features_8_conv_1_1_weight, features_8_conv_1_1_bias,
             features_8_conv_1_1_running_mean, features_8_conv_1_1_running_var,
             p->w1, p->b1);
    fold_one(features_8_conv_2_weight, CIN, CEXP,
             features_8_conv_3_weight, features_8_conv_3_bias,
             features_8_conv_3_running_mean, features_8_conv_3_running_var,
             p->w2, p->b2);
}

static float relu6f_local(float value)
{
    if (value < 0.0f) return 0.0f;
    if (value > 6.0f) return 6.0f;
    return value;
}

static void run_float_folded(const float *input, const FoldedParams *p,
                             float *expand, float *depthwise,
                             float *project, float *final_out)
{
    for (int oc = 0; oc < CEXP; ++oc) {
        const float *weight = p->w0 + (size_t)oc * CIN;
        for (int pos = 0; pos < HW; ++pos) {
            float acc = p->b0[oc];
            for (int ic = 0; ic < CIN; ++ic)
                acc += input[(size_t)ic * HW + pos] * weight[ic];
            expand[(size_t)oc * HW + pos] = relu6f_local(acc);
        }
    }

    for (int c = 0; c < CEXP; ++c) {
        const float *weight = p->w1 + (size_t)c * K * K;
        for (int oh = 0; oh < H; ++oh) {
            for (int ow = 0; ow < W; ++ow) {
                float acc = p->b1[c];
                for (int kh = 0; kh < K; ++kh) {
                    int ih = oh + kh - 1;
                    if (ih < 0 || ih >= H) continue;
                    for (int kw = 0; kw < K; ++kw) {
                        int iw = ow + kw - 1;
                        if (iw < 0 || iw >= W) continue;
                        acc += expand[(size_t)c * HW + ih * W + iw] * weight[kh * K + kw];
                    }
                }
                depthwise[(size_t)c * HW + oh * W + ow] = relu6f_local(acc);
            }
        }
    }

    for (int oc = 0; oc < CIN; ++oc) {
        const float *weight = p->w2 + (size_t)oc * CEXP;
        for (int pos = 0; pos < HW; ++pos) {
            float acc = p->b2[oc];
            for (int ic = 0; ic < CEXP; ++ic)
                acc += depthwise[(size_t)ic * HW + pos] * weight[ic];
            project[(size_t)oc * HW + pos] = acc;
            final_out[(size_t)oc * HW + pos] = acc + input[(size_t)oc * HW + pos];
        }
    }
}

static void apply_bn_relu(float *data, int channels,
                          const float *gamma, const float *beta,
                          const float *mean, const float *variance, int use_relu)
{
    for (int c = 0; c < channels; ++c) {
        float scale = gamma[c] / sqrtf(variance[c] + EPS);
        for (int pos = 0; pos < HW; ++pos) {
            float value = (data[(size_t)c * HW + pos] - mean[c]) * scale + beta[c];
            data[(size_t)c * HW + pos] = use_relu ? relu6f_local(value) : value;
        }
    }
}

static void run_float_bn(const float *input, float *final_out)
{
    float *expand = xcalloc(EXP_N, sizeof(float));
    float *depthwise = xcalloc(EXP_N, sizeof(float));

    for (int oc = 0; oc < CEXP; ++oc) {
        const float *weight = features_8_conv_0_0_weight + (size_t)oc * CIN;
        for (int pos = 0; pos < HW; ++pos) {
            float acc = 0.0f;
            for (int ic = 0; ic < CIN; ++ic)
                acc += input[(size_t)ic * HW + pos] * weight[ic];
            expand[(size_t)oc * HW + pos] = acc;
        }
    }
    apply_bn_relu(expand, CEXP,
                  features_8_conv_0_1_weight, features_8_conv_0_1_bias,
                  features_8_conv_0_1_running_mean, features_8_conv_0_1_running_var, 1);

    for (int c = 0; c < CEXP; ++c) {
        const float *weight = features_8_conv_1_0_weight + (size_t)c * K * K;
        for (int oh = 0; oh < H; ++oh) {
            for (int ow = 0; ow < W; ++ow) {
                float acc = 0.0f;
                for (int kh = 0; kh < K; ++kh) {
                    int ih = oh + kh - 1;
                    if (ih < 0 || ih >= H) continue;
                    for (int kw = 0; kw < K; ++kw) {
                        int iw = ow + kw - 1;
                        if (iw < 0 || iw >= W) continue;
                        acc += expand[(size_t)c * HW + ih * W + iw] * weight[kh * K + kw];
                    }
                }
                depthwise[(size_t)c * HW + oh * W + ow] = acc;
            }
        }
    }
    apply_bn_relu(depthwise, CEXP,
                  features_8_conv_1_1_weight, features_8_conv_1_1_bias,
                  features_8_conv_1_1_running_mean, features_8_conv_1_1_running_var, 1);

    for (int oc = 0; oc < CIN; ++oc) {
        const float *weight = features_8_conv_2_weight + (size_t)oc * CEXP;
        for (int pos = 0; pos < HW; ++pos) {
            float acc = 0.0f;
            for (int ic = 0; ic < CEXP; ++ic)
                acc += depthwise[(size_t)ic * HW + pos] * weight[ic];
            final_out[(size_t)oc * HW + pos] = acc;
        }
    }
    apply_bn_relu(final_out, CIN,
                  features_8_conv_3_weight, features_8_conv_3_bias,
                  features_8_conv_3_running_mean, features_8_conv_3_running_var, 0);
    for (size_t i = 0; i < INPUT_N; ++i) final_out[i] += input[i];

    free(expand);
    free(depthwise);
}

static void allocate_quant(QuantResult *q, int calibrated)
{
    memset(q, 0, sizeof(*q));
    q->input = xcalloc(INPUT_N, sizeof(int8_t));
    q->w0 = xcalloc(W0_N, sizeof(int8_t));
    q->w1 = xcalloc(W1_N, sizeof(int8_t));
    q->w2 = xcalloc(W2_N, sizeof(int8_t));
    q->b0 = xcalloc(CEXP, sizeof(int32_t));
    q->b1 = xcalloc(CEXP, sizeof(int32_t));
    q->b2 = xcalloc(CIN, sizeof(int32_t));
    q->expand = xcalloc(EXP_N, sizeof(int8_t));
    q->depthwise = xcalloc(EXP_N, sizeof(int8_t));
    q->project = xcalloc(INPUT_N, sizeof(int8_t));
    q->final_out = xcalloc(INPUT_N, sizeof(int8_t));
    if (calibrated) {
        q->w0_scales = xcalloc(CEXP, sizeof(float));
        q->w1_scales = xcalloc(CEXP, sizeof(float));
        q->w2_scales = xcalloc(CIN, sizeof(float));
    }
    init_diag(&q->expand_diag);
    init_diag(&q->depthwise_diag);
    init_diag(&q->project_diag);
    init_diag(&q->final_diag);
}

static void free_quant(QuantResult *q)
{
    free(q->input); free(q->w0); free(q->w1); free(q->w2);
    free(q->b0); free(q->b1); free(q->b2);
    free(q->expand); free(q->depthwise); free(q->project); free(q->final_out);
    free(q->w0_scales); free(q->w1_scales); free(q->w2_scales);
}

static int8_t q34_from_float(float value, uint64_t *sat_count)
{
    int64_t q16 = round_away_from_zero((double)value * 4096.0);
    if (q16 < INT16_MIN) {
        q16 = INT16_MIN;
        if (sat_count) ++*sat_count;
    } else if (q16 > INT16_MAX) {
        q16 = INT16_MAX;
        if (sat_count) ++*sat_count;
    }
    return (int8_t)floor_div_pow2(q16, 8);
}

static void run_q34(const float *input, const FoldedParams *p, QuantResult *q)
{
    q->input_scale = q->expand_scale = q->depthwise_scale =
        q->project_scale = q->final_scale = 1.0f / 16.0f;

    for (size_t i = 0; i < INPUT_N; ++i)
        q->input[i] = q34_from_float(input[i], &q->input_saturation_count);
    for (size_t i = 0; i < W0_N; ++i)
        q->w0[i] = q34_from_float(p->w0[i], &q->weight_saturation_count);
    for (size_t i = 0; i < W1_N; ++i)
        q->w1[i] = q34_from_float(p->w1[i], &q->weight_saturation_count);
    for (size_t i = 0; i < W2_N; ++i)
        q->w2[i] = q34_from_float(p->w2[i], &q->weight_saturation_count);
    for (int i = 0; i < CEXP; ++i) {
        q->b0[i] = checked_i32((double)p->b0[i] * 256.0, "q34_expand_bias", i);
        q->b1[i] = checked_i32((double)p->b1[i] * 256.0, "q34_depthwise_bias", i);
    }
    for (int i = 0; i < CIN; ++i)
        q->b2[i] = checked_i32((double)p->b2[i] * 256.0, "q34_project_bias", i);

    for (int oc = 0; oc < CEXP; ++oc) {
        const int8_t *weight = q->w0 + (size_t)oc * CIN;
        for (int pos = 0; pos < HW; ++pos) {
            int64_t acc = q->b0[oc];
            for (int ic = 0; ic < CIN; ++ic)
                acc += (int32_t)q->input[(size_t)ic * HW + pos] * weight[ic];
            observe_acc(&q->expand_diag, acc);
            int64_t raw = floor_div_pow2(acc, 4);
            q->expand[(size_t)oc * HW + pos] =
                clamp_i8(raw, 0, 96, &q->expand_diag.saturation_count);
        }
    }

    for (int c = 0; c < CEXP; ++c) {
        const int8_t *weight = q->w1 + (size_t)c * K * K;
        for (int oh = 0; oh < H; ++oh) {
            for (int ow = 0; ow < W; ++ow) {
                int64_t acc = q->b1[c];
                for (int kh = 0; kh < K; ++kh) {
                    int ih = oh + kh - 1;
                    if (ih < 0 || ih >= H) continue;
                    for (int kw = 0; kw < K; ++kw) {
                        int iw = ow + kw - 1;
                        if (iw < 0 || iw >= W) continue;
                        acc += (int32_t)q->expand[(size_t)c * HW + ih * W + iw]
                             * weight[kh * K + kw];
                    }
                }
                observe_acc(&q->depthwise_diag, acc);
                int64_t raw = floor_div_pow2(acc, 4);
                q->depthwise[(size_t)c * HW + oh * W + ow] =
                    clamp_i8(raw, 0, 96, &q->depthwise_diag.saturation_count);
            }
        }
    }

    for (int oc = 0; oc < CIN; ++oc) {
        const int8_t *weight = q->w2 + (size_t)oc * CEXP;
        for (int pos = 0; pos < HW; ++pos) {
            int64_t acc = q->b2[oc];
            for (int ic = 0; ic < CEXP; ++ic)
                acc += (int32_t)q->depthwise[(size_t)ic * HW + pos] * weight[ic];
            observe_acc(&q->project_diag, acc);
            int64_t project_raw = floor_div_pow2(acc, 4);
            int8_t project_q = clamp_i8(project_raw, -128, 127,
                                        &q->project_diag.saturation_count);
            q->project[(size_t)oc * HW + pos] = project_q;
            int64_t final_raw = (int64_t)project_q + q->input[(size_t)oc * HW + pos];
            observe_acc(&q->final_diag, final_raw);
            q->final_out[(size_t)oc * HW + pos] =
                clamp_i8(final_raw, -128, 127, &q->final_diag.saturation_count);
        }
    }
}

static QuantMultiplier make_multiplier(double real_multiplier)
{
    QuantMultiplier result = {0, 0};
    if (real_multiplier == 0.0) return result;
    int exponent = 0;
    double fraction = frexp(real_multiplier, &exponent);
    int64_t quantized = round_away_from_zero(fraction * 2147483648.0);
    if (quantized == 2147483648LL) {
        quantized /= 2;
        ++exponent;
    }
    if (quantized < 0 || quantized > INT32_MAX) {
        fprintf(stderr, "ERROR: invalid positive requant multiplier %.9g\n", real_multiplier);
        exit(2);
    }
    result.multiplier = (int32_t)quantized;
    result.exponent = exponent;
    return result;
}

static int64_t apply_multiplier(int64_t value, QuantMultiplier multiplier)
{
    int64_t product = value * (int64_t)multiplier.multiplier;
    int right_shift = 31 - multiplier.exponent;
    if (right_shift >= 0) return round_div_pow2(product, (unsigned)right_shift);
    if (-right_shift >= 31 || product > (INT64_MAX >> (-right_shift)) ||
        product < (INT64_MIN >> (-right_shift))) {
        fprintf(stderr, "ERROR: requantization shift overflow\n");
        exit(2);
    }
    return product << (-right_shift);
}

static int8_t calibrated_q8(float value, float scale, uint64_t *sat_count)
{
    int64_t raw = round_away_from_zero((double)value / scale);
    return clamp_i8(raw, -127, 127, sat_count);
}

static void quantize_weight_per_channel(const float *weight, int out_channels, int terms,
                                        int8_t *qweight, float *scales,
                                        uint64_t *sat_count)
{
    for (int oc = 0; oc < out_channels; ++oc) {
        float max_abs = max_abs_f32(weight + (size_t)oc * terms, terms);
        scales[oc] = nonzero_scale(max_abs);
        for (int i = 0; i < terms; ++i)
            qweight[(size_t)oc * terms + i] =
                calibrated_q8(weight[(size_t)oc * terms + i], scales[oc], sat_count);
    }
}

static void run_calibrated(const float *input, const FoldedParams *p,
                           const float *float_expand, const float *float_depthwise,
                           const float *float_project, const float *float_final,
                           QuantResult *q)
{
    q->input_scale = nonzero_scale(max_abs_f32(input, INPUT_N));
    q->expand_scale = nonzero_scale(max_abs_f32(float_expand, EXP_N));
    q->depthwise_scale = nonzero_scale(max_abs_f32(float_depthwise, EXP_N));
    q->project_scale = nonzero_scale(max_abs_f32(float_project, INPUT_N));
    q->final_scale = nonzero_scale(max_abs_f32(float_final, INPUT_N));

    for (size_t i = 0; i < INPUT_N; ++i)
        q->input[i] = calibrated_q8(input[i], q->input_scale,
                                    &q->input_saturation_count);
    quantize_weight_per_channel(p->w0, CEXP, CIN, q->w0, q->w0_scales,
                                &q->weight_saturation_count);
    quantize_weight_per_channel(p->w1, CEXP, K * K, q->w1, q->w1_scales,
                                &q->weight_saturation_count);
    quantize_weight_per_channel(p->w2, CIN, CEXP, q->w2, q->w2_scales,
                                &q->weight_saturation_count);

    for (int oc = 0; oc < CEXP; ++oc) {
        q->b0[oc] = checked_i32((double)p->b0[oc] /
                                ((double)q->input_scale * q->w0_scales[oc]),
                                "calibrated_expand_bias", oc);
        q->b1[oc] = checked_i32((double)p->b1[oc] /
                                ((double)q->expand_scale * q->w1_scales[oc]),
                                "calibrated_depthwise_bias", oc);
    }
    for (int oc = 0; oc < CIN; ++oc)
        q->b2[oc] = checked_i32((double)p->b2[oc] /
                                ((double)q->depthwise_scale * q->w2_scales[oc]),
                                "calibrated_project_bias", oc);

    for (int oc = 0; oc < CEXP; ++oc) {
        const int8_t *weight = q->w0 + (size_t)oc * CIN;
        QuantMultiplier m = make_multiplier((double)q->input_scale * q->w0_scales[oc] /
                                            q->expand_scale);
        for (int pos = 0; pos < HW; ++pos) {
            int64_t acc = q->b0[oc];
            for (int ic = 0; ic < CIN; ++ic)
                acc += (int32_t)q->input[(size_t)ic * HW + pos] * weight[ic];
            observe_acc(&q->expand_diag, acc);
            int64_t raw = apply_multiplier(acc, m);
            q->expand[(size_t)oc * HW + pos] =
                clamp_i8(raw, 0, 127, &q->expand_diag.saturation_count);
        }
    }

    for (int c = 0; c < CEXP; ++c) {
        const int8_t *weight = q->w1 + (size_t)c * K * K;
        QuantMultiplier m = make_multiplier((double)q->expand_scale * q->w1_scales[c] /
                                            q->depthwise_scale);
        for (int oh = 0; oh < H; ++oh) {
            for (int ow = 0; ow < W; ++ow) {
                int64_t acc = q->b1[c];
                for (int kh = 0; kh < K; ++kh) {
                    int ih = oh + kh - 1;
                    if (ih < 0 || ih >= H) continue;
                    for (int kw = 0; kw < K; ++kw) {
                        int iw = ow + kw - 1;
                        if (iw < 0 || iw >= W) continue;
                        acc += (int32_t)q->expand[(size_t)c * HW + ih * W + iw]
                             * weight[kh * K + kw];
                    }
                }
                observe_acc(&q->depthwise_diag, acc);
                int64_t raw = apply_multiplier(acc, m);
                q->depthwise[(size_t)c * HW + oh * W + ow] =
                    clamp_i8(raw, 0, 127, &q->depthwise_diag.saturation_count);
            }
        }
    }

    QuantMultiplier skip_to_final = make_multiplier((double)q->input_scale / q->final_scale);
    for (int oc = 0; oc < CIN; ++oc) {
        const int8_t *weight = q->w2 + (size_t)oc * CEXP;
        QuantMultiplier to_project = make_multiplier(
            (double)q->depthwise_scale * q->w2_scales[oc] / q->project_scale);
        QuantMultiplier to_final = make_multiplier(
            (double)q->depthwise_scale * q->w2_scales[oc] / q->final_scale);
        for (int pos = 0; pos < HW; ++pos) {
            int64_t acc = q->b2[oc];
            for (int ic = 0; ic < CEXP; ++ic)
                acc += (int32_t)q->depthwise[(size_t)ic * HW + pos] * weight[ic];
            observe_acc(&q->project_diag, acc);
            int64_t project_raw = apply_multiplier(acc, to_project);
            q->project[(size_t)oc * HW + pos] =
                clamp_i8(project_raw, -127, 127, &q->project_diag.saturation_count);

            int64_t project_final = apply_multiplier(acc, to_final);
            int64_t skip_final = apply_multiplier(q->input[(size_t)oc * HW + pos],
                                                  skip_to_final);
            int64_t final_raw = project_final + skip_final;
            observe_acc(&q->final_diag, final_raw);
            q->final_out[(size_t)oc * HW + pos] =
                clamp_i8(final_raw, -127, 127, &q->final_diag.saturation_count);
        }
    }
}

static int export_qresult(const char *out_dir, const char *prefix, const QuantResult *q)
{
    struct FileItem { const char *suffix; const void *data; size_t size; size_t count; } files[] = {
        {"input_int8.bin", q->input, sizeof(int8_t), INPUT_N},
        {"expand_weight_int8.bin", q->w0, sizeof(int8_t), W0_N},
        {"depthwise_weight_int8.bin", q->w1, sizeof(int8_t), W1_N},
        {"project_weight_int8.bin", q->w2, sizeof(int8_t), W2_N},
        {"expand_bias_int32.bin", q->b0, sizeof(int32_t), CEXP},
        {"depthwise_bias_int32.bin", q->b1, sizeof(int32_t), CEXP},
        {"project_bias_int32.bin", q->b2, sizeof(int32_t), CIN},
        {"expand_output_int8.bin", q->expand, sizeof(int8_t), EXP_N},
        {"depthwise_output_int8.bin", q->depthwise, sizeof(int8_t), EXP_N},
        {"project_output_int8.bin", q->project, sizeof(int8_t), INPUT_N},
        {"final_output_int8.bin", q->final_out, sizeof(int8_t), INPUT_N}
    };
    char name[256], path[1024];
    for (size_t i = 0; i < sizeof(files) / sizeof(files[0]); ++i) {
        snprintf(name, sizeof(name), "%s_%s", prefix, files[i].suffix);
        join_path(path, sizeof(path), out_dir, name);
        if (write_bin(path, files[i].data, files[i].size, files[i].count)) return -1;
    }
    float *dequant = xcalloc(INPUT_N, sizeof(float));
    for (size_t i = 0; i < INPUT_N; ++i)
        dequant[i] = (float)q->final_out[i] * q->final_scale;
    snprintf(name, sizeof(name), "%s_final_output_dequant_f32.bin", prefix);
    join_path(path, sizeof(path), out_dir, name);
    int rc = write_bin(path, dequant, sizeof(float), INPUT_N);
    free(dequant);
    return rc;
}

static void json_float_array(FILE *fp, const float *values, int count)
{
    fputc('[', fp);
    for (int i = 0; i < count; ++i) {
        if (i) fputc(',', fp);
        if ((i % 8) == 0) fputs("\n        ", fp);
        fprintf(fp, "%.9g", values[i]);
    }
    fputs("\n      ]", fp);
}

static void json_string(FILE *fp, const char *value)
{
    fputc('"', fp);
    for (const unsigned char *p = (const unsigned char *)value; *p; ++p) {
        switch (*p) {
        case '"': fputs("\\\"", fp); break;
        case '\\': fputs("\\\\", fp); break;
        case '\b': fputs("\\b", fp); break;
        case '\f': fputs("\\f", fp); break;
        case '\n': fputs("\\n", fp); break;
        case '\r': fputs("\\r", fp); break;
        case '\t': fputs("\\t", fp); break;
        default:
            if (*p < 0x20) fprintf(fp, "\\u%04x", *p);
            else fputc(*p, fp);
        }
    }
    fputc('"', fp);
}

static void json_diag(FILE *fp, const StageDiag *d)
{
    fprintf(fp,
            "{\"acc_min\":%" PRId64 ",\"acc_max\":%" PRId64
            ",\"saturation_count\":%" PRIu64 ",\"int32_overflow_count\":%" PRIu64 "}",
            d->min_acc, d->max_acc, d->saturation_count, d->int32_overflow_count);
}

static int write_manifest(const char *out_dir, const char *input_path,
                          const char *golden_path, RunMode mode,
                          const QuantResult *q34, const QuantResult *cal)
{
    char path[1024];
    join_path(path, sizeof(path), out_dir, "layer08_int8_manifest.json");
    FILE *fp = fopen(path, "w");
    if (!fp) return -1;
    fputs("{\n  \"format_version\":1,\n  \"input\":", fp);
    json_string(fp, input_path);
    fputs(",\n  \"golden\":", fp);
    json_string(fp, golden_path);
    fputs(",\n"
            "  \"storage_order\":\"CHW activations; OC-major weights\",\n"
            "  \"shapes\":{\"input\":[64,14,14],\"expand_weight\":[384,64,1,1],"
            "\"depthwise_weight\":[384,1,3,3],\"project_weight\":[64,384,1,1],"
            "\"expand_bias\":[384],\"depthwise_bias\":[384],\"project_bias\":[64]},\n", fp);

    int need_comma = 0;
    if (mode != MODE_CALIBRATED) {
        fprintf(fp,
                "  \"q34\":{\"dtype\":\"int8\",\"scale\":0.0625,"
                "\"source_rule\":\"round-to-Q3.12 then arithmetic shift right 8\","
                "\"bias_dtype\":\"int32\",\"bias_scale\":0.00390625,"
                "\"input_saturation_count\":%" PRIu64 ","
                "\"weight_saturation_count\":%" PRIu64 ",\"diagnostics\":{",
                q34->input_saturation_count, q34->weight_saturation_count);
        fputs("\"expand\":", fp); json_diag(fp, &q34->expand_diag);
        fputs(",\"depthwise\":", fp); json_diag(fp, &q34->depthwise_diag);
        fputs(",\"project\":", fp); json_diag(fp, &q34->project_diag);
        fputs(",\"final\":", fp); json_diag(fp, &q34->final_diag);
        fputs("}}", fp);
        need_comma = 1;
    }
    if (mode != MODE_Q34) {
        if (need_comma) fputs(",\n", fp); else fputs("  ", fp);
        fprintf(fp,
                "\"calibrated\":{\"activation_dtype\":\"symmetric int8, zero_point 0\","
                "\"weight_dtype\":\"per-output-channel symmetric int8, zero_point 0\","
                "\"bias_dtype\":\"int32 with per-channel input_scale*weight_scale\","
                "\"activation_scales\":{\"input\":%.9g,\"expand\":%.9g,"
                "\"depthwise\":%.9g,\"project\":%.9g,\"final\":%.9g},"
                "\"input_saturation_count\":%" PRIu64 ","
                "\"weight_saturation_count\":%" PRIu64 ",\n"
                "    \"weight_scales\":{\"expand\":",
                cal->input_scale, cal->expand_scale, cal->depthwise_scale,
                cal->project_scale, cal->final_scale,
                cal->input_saturation_count, cal->weight_saturation_count);
        json_float_array(fp, cal->w0_scales, CEXP);
        fputs(",\n      \"depthwise\":", fp); json_float_array(fp, cal->w1_scales, CEXP);
        fputs(",\n      \"project\":", fp); json_float_array(fp, cal->w2_scales, CIN);
        fputs("},\n    \"diagnostics\":{\"expand\":", fp); json_diag(fp, &cal->expand_diag);
        fputs(",\"depthwise\":", fp); json_diag(fp, &cal->depthwise_diag);
        fputs(",\"project\":", fp); json_diag(fp, &cal->project_diag);
        fputs(",\"final\":", fp); json_diag(fp, &cal->final_diag);
        fputs("}}", fp);
    }
    fputs("\n}\n", fp);
    fclose(fp);
    return 0;
}

static void report_metric_row(FILE *fp, const char *name, const Metrics *m)
{
    int channel = (int)(m->worst_index / HW);
    int pixel = (int)(m->worst_index % HW);
    fprintf(fp, "| %s | %.9g | %.9g | %.9g | %.10f | %d/%d |\n",
            name, m->max_abs, m->mean_abs, m->rmse, m->cosine, channel, pixel);
}

static int write_report(const char *out_dir, RunMode mode,
                        const Metrics *bn_folded, const Metrics *folded_golden,
                        const Metrics q34_stage[4], const Metrics *q34_golden,
                        const Metrics cal_stage[4], const Metrics *cal_golden,
                        const QuantResult *q34, const QuantResult *cal)
{
    char path[1024];
    join_path(path, sizeof(path), out_dir, "layer08_int8_accuracy_summary.md");
    FILE *fp = fopen(path, "w");
    if (!fp) return -1;
    const char *recommended = "only evaluated mode";
    if (mode == MODE_BOTH)
        recommended = cal_golden->rmse <= q34_golden->rmse ? "calibrated INT8" : "Q3.4 truncation";

    fprintf(fp,
            "# Layer 08 INT8 fixed-point accuracy\n\n"
            "**Recommendation:** %s. Selection uses lower final RMSE, with cosine similarity reported alongside it.\n\n"
            "This is a single-sample Layer 08 numeric comparison, not ImageNet Top-1 accuracy.\n\n"
            "## Accuracy\n\n"
            "| Comparison | Max abs | Mean abs | RMSE | Cosine | Worst channel/pixel |\n"
            "|---|---:|---:|---:|---:|---:|\n", recommended);
    report_metric_row(fp, "Float BN vs float folded", bn_folded);
    report_metric_row(fp, "Float folded vs layer08 golden", folded_golden);
    if (mode != MODE_CALIBRATED) {
        report_metric_row(fp, "Q3.4 expand vs folded", &q34_stage[0]);
        report_metric_row(fp, "Q3.4 depthwise vs folded", &q34_stage[1]);
        report_metric_row(fp, "Q3.4 project vs folded", &q34_stage[2]);
        report_metric_row(fp, "Q3.4 final vs folded", &q34_stage[3]);
        report_metric_row(fp, "Q3.4 final vs layer08 golden", q34_golden);
    }
    if (mode != MODE_Q34) {
        report_metric_row(fp, "Calibrated expand vs folded", &cal_stage[0]);
        report_metric_row(fp, "Calibrated depthwise vs folded", &cal_stage[1]);
        report_metric_row(fp, "Calibrated project vs folded", &cal_stage[2]);
        report_metric_row(fp, "Calibrated final vs folded", &cal_stage[3]);
        report_metric_row(fp, "Calibrated final vs layer08 golden", cal_golden);
    }

    fputs("\n## Integer diagnostics\n\n"
          "| Mode/stage | Acc min | Acc max | Saturations | INT32 overflows |\n"
          "|---|---:|---:|---:|---:|\n", fp);
    if (mode != MODE_CALIBRATED) {
        const StageDiag *d[] = {&q34->expand_diag, &q34->depthwise_diag,
                                &q34->project_diag, &q34->final_diag};
        const char *n[] = {"Q3.4 expand", "Q3.4 depthwise", "Q3.4 project", "Q3.4 final"};
        for (int i = 0; i < 4; ++i)
            fprintf(fp, "| %s | %" PRId64 " | %" PRId64 " | %" PRIu64 " | %" PRIu64 " |\n",
                    n[i], d[i]->min_acc, d[i]->max_acc,
                    d[i]->saturation_count, d[i]->int32_overflow_count);
    }
    if (mode != MODE_Q34) {
        const StageDiag *d[] = {&cal->expand_diag, &cal->depthwise_diag,
                                &cal->project_diag, &cal->final_diag};
        const char *n[] = {"Calibrated expand", "Calibrated depthwise",
                           "Calibrated project", "Calibrated final"};
        for (int i = 0; i < 4; ++i)
            fprintf(fp, "| %s | %" PRId64 " | %" PRId64 " | %" PRIu64 " | %" PRIu64 " |\n",
                    n[i], d[i]->min_acc, d[i]->max_acc,
                    d[i]->saturation_count, d[i]->int32_overflow_count);
    }
    fclose(fp);
    return 0;
}

static int any_overflow(const QuantResult *q)
{
    return q->expand_diag.int32_overflow_count || q->depthwise_diag.int32_overflow_count ||
           q->project_diag.int32_overflow_count;
}

static int self_test(void)
{
    uint64_t sat = 0;
    if (q34_from_float(1.5f, &sat) != 24 || q34_from_float(-1.5f, &sat) != -24 || sat != 0)
        return -1;
    int64_t acc = 256 + 16 * 2 + (-8) * (-3);
    if (floor_div_pow2(acc, 4) != 19) return -1;
    QuantMultiplier quarter = make_multiplier(0.25);
    if (apply_multiplier(100, quarter) != 25 || apply_multiplier(-100, quarter) != -25)
        return -1;
    return 0;
}

static void usage(const char *program)
{
    fprintf(stderr,
            "Usage: %s [--input layer07.bin] [--golden layer08.bin] "
            "[--out-dir DIR] [--mode q34|calibrated|both]\n", program);
}

int main(int argc, char **argv)
{
    const char *input_path = "MobileNet_v2/mobilenetv2_result_layer07.bin";
    const char *golden_path = "MobileNet_v2/mobilenetv2_result_layer08.bin";
    const char *out_dir = "layer08/quantized_compare";
    RunMode mode = MODE_BOTH;

    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--input") && i + 1 < argc) input_path = argv[++i];
        else if (!strcmp(argv[i], "--golden") && i + 1 < argc) golden_path = argv[++i];
        else if (!strcmp(argv[i], "--out-dir") && i + 1 < argc) out_dir = argv[++i];
        else if (!strcmp(argv[i], "--mode") && i + 1 < argc) {
            const char *value = argv[++i];
            if (!strcmp(value, "both")) mode = MODE_BOTH;
            else if (!strcmp(value, "q34")) mode = MODE_Q34;
            else if (!strcmp(value, "calibrated")) mode = MODE_CALIBRATED;
            else { usage(argv[0]); return 2; }
        } else {
            usage(argv[0]);
            return 2;
        }
    }

    if (self_test()) {
        fprintf(stderr, "ERROR: deterministic integer self-test failed\n");
        return 2;
    }
    if (make_dirs(out_dir)) {
        fprintf(stderr, "ERROR: cannot create output directory %s\n", out_dir);
        return 2;
    }

    float *input = xcalloc(INPUT_N, sizeof(float));
    float *golden = xcalloc(INPUT_N, sizeof(float));
    float *float_bn = xcalloc(INPUT_N, sizeof(float));
    float *float_expand = xcalloc(EXP_N, sizeof(float));
    float *float_depthwise = xcalloc(EXP_N, sizeof(float));
    float *float_project = xcalloc(INPUT_N, sizeof(float));
    float *float_final = xcalloc(INPUT_N, sizeof(float));
    if (load_f32_bin(input_path, input, INPUT_N) || load_f32_bin(golden_path, golden, INPUT_N))
        return 2;

    FoldedParams folded;
    allocate_folded(&folded);
    build_folded(&folded);
    run_float_bn(input, float_bn);
    run_float_folded(input, &folded, float_expand, float_depthwise,
                     float_project, float_final);

    Metrics bn_folded = metrics_f32(float_bn, float_final, INPUT_N);
    Metrics folded_golden = metrics_f32(float_final, golden, INPUT_N);
    if (bn_folded.max_abs > 1.0e-4) {
        fprintf(stderr, "ERROR: BN folding validation failed, max error %.9g\n", bn_folded.max_abs);
        return 2;
    }

    QuantResult q34 = {0}, cal = {0};
    Metrics q34_stage[4] = {{0}}, cal_stage[4] = {{0}};
    Metrics q34_golden = {0}, cal_golden = {0};

    if (mode != MODE_CALIBRATED) {
        allocate_quant(&q34, 0);
        run_q34(input, &folded, &q34);
        q34_stage[0] = metrics_q8(q34.expand, q34.expand_scale, float_expand, EXP_N);
        q34_stage[1] = metrics_q8(q34.depthwise, q34.depthwise_scale, float_depthwise, EXP_N);
        q34_stage[2] = metrics_q8(q34.project, q34.project_scale, float_project, INPUT_N);
        q34_stage[3] = metrics_q8(q34.final_out, q34.final_scale, float_final, INPUT_N);
        q34_golden = metrics_q8(q34.final_out, q34.final_scale, golden, INPUT_N);
        if (export_qresult(out_dir, "q34", &q34)) return 2;
    }
    if (mode != MODE_Q34) {
        allocate_quant(&cal, 1);
        run_calibrated(input, &folded, float_expand, float_depthwise,
                       float_project, float_final, &cal);
        cal_stage[0] = metrics_q8(cal.expand, cal.expand_scale, float_expand, EXP_N);
        cal_stage[1] = metrics_q8(cal.depthwise, cal.depthwise_scale, float_depthwise, EXP_N);
        cal_stage[2] = metrics_q8(cal.project, cal.project_scale, float_project, INPUT_N);
        cal_stage[3] = metrics_q8(cal.final_out, cal.final_scale, float_final, INPUT_N);
        cal_golden = metrics_q8(cal.final_out, cal.final_scale, golden, INPUT_N);
        if (export_qresult(out_dir, "calibrated", &cal)) return 2;
    }

    if (write_manifest(out_dir, input_path, golden_path, mode, &q34, &cal) ||
        write_report(out_dir, mode, &bn_folded, &folded_golden,
                     q34_stage, &q34_golden, cal_stage, &cal_golden, &q34, &cal)) {
        fprintf(stderr, "ERROR: failed to write report files\n");
        return 2;
    }

    printf("Layer 08 fixed-point comparison\n");
    printf("  float BN vs folded : max %.9g, RMSE %.9g\n",
           bn_folded.max_abs, bn_folded.rmse);
    printf("  folded vs golden   : max %.9g, RMSE %.9g\n",
           folded_golden.max_abs, folded_golden.rmse);
    if (mode != MODE_CALIBRATED)
        printf("  Q3.4 vs golden     : max %.9g, mean %.9g, RMSE %.9g, cosine %.10f\n",
               q34_golden.max_abs, q34_golden.mean_abs, q34_golden.rmse,
               q34_golden.cosine);
    if (mode != MODE_Q34)
        printf("  calibrated vs gold : max %.9g, mean %.9g, RMSE %.9g, cosine %.10f\n",
               cal_golden.max_abs, cal_golden.mean_abs, cal_golden.rmse,
               cal_golden.cosine);
    printf("  outputs            : %s\n", out_dir);

    int failed = (mode != MODE_CALIBRATED && any_overflow(&q34)) ||
                 (mode != MODE_Q34 && any_overflow(&cal));
    if (failed) fprintf(stderr, "ERROR: an accumulator exceeded INT32 range\n");

    if (mode != MODE_CALIBRATED) free_quant(&q34);
    if (mode != MODE_Q34) free_quant(&cal);
    free_folded(&folded);
    free(input); free(golden); free(float_bn); free(float_expand);
    free(float_depthwise); free(float_project); free(float_final);
    return failed ? 2 : 0;
}
