/* ============================================================================
 *  layer8.c  --  MobileNetV2  Layer 8  (InvertedResidual bottleneck)
 * ----------------------------------------------------------------------------
 *  features[8] of torchvision MobileNetV2:
 *      InvertedResidual, expand-ratio t = 6, 64 -> 64 channels,
 *      14x14 spatial, stride 1, WITH residual (skip) connection.
 *
 *  Dataflow (= lecture slides):
 *     in[64][14][14]            <- MobileNet_v2/mobilenetv2_result_layer07.bin
 *   1) Expand  pointwise 1x1   64 -> 384   (features_8_conv_0_0_weight)
 *   2) BatchNorm + ReLU6                   (features_8_conv_0_1_*)
 *   3) Depthwise 3x3 s1 p1     384 -> 384  (features_8_conv_1_0_weight)
 *   4) BatchNorm + ReLU6                   (features_8_conv_1_1_*)
 *   5) Project pointwise 1x1   384 -> 64   (features_8_conv_2_weight)
 *   6) BatchNorm  (LINEAR, no ReLU)        (features_8_conv_3_*)
 *   7) Residual add:  out += in
 *     out[64][14][14]           compared to mobilenetv2_result_layer08.bin
 *
 *  MAC budget (from the slides):
 *     expand  384*14*14*64  ~ 4.81 M      |
 *     dwise   384*14*14*9   ~ 0.68 M      |  the two 1x1 convs are ~93% of MACs
 *     project 64*14*14*384  ~ 4.81 M      |
 *
 * ----------------------------------------------------------------------------
 *  HARDWARE-OPTIMIZATION NOTES  (implemented in layer8_optimized + discussed)
 *
 *  (1) BN folding / precompute scale+shift.
 *      Inference BN is a fixed per-channel affine:
 *          y = gamma*(x-mean)/sqrt(var+eps) + beta
 *            = x*scale + shift,   scale = gamma/sqrt(var+eps),
 *                                 shift = beta - mean*scale.
 *      Computed ONCE -> the hot loop has no sqrt/div (both very costly in HW),
 *      just one fused multiply-add (fmaf).  scale/shift can even be folded
 *      directly into the preceding conv weights so BN disappears entirely.
 *
 *  (2) Operator fusion (conv + BN + ReLU6 + residual in one pass).
 *      The expanded tensor is 384*14*14*4 ~ 294 KB.  Streaming it through
 *      BN/ReLU/skip on-chip instead of writing each stage to DRAM is the
 *      single biggest bandwidth win.  Depthwise needs only a 3-row halo, so a
 *      few line buffers suffice -> the 6x-inflated intermediate never has to
 *      be materialized in external memory.
 *
 *  (3) Roofline.  1x1 convs dominate MACs -> they map to a GEMM / systolic
 *      MAC array (compute-bound).  Depthwise is memory-bound (9 MACs/elem,
 *      weights reused only across space) -> co-schedule it with the pointwise
 *      stages so the array is not starved.
 *
 *  (4) Tiling & reuse.  One loaded 64-wide input column feeds all 384 expand
 *      outputs; one 384-wide depthwise column feeds all 64 project outputs.
 *      Tile output channels / spatial to fit on-chip SRAM.
 *
 *  (5) No explicit zero-padding buffer.  The reference path builds the
 *      [384][16][16] padded tensor from the slide; the optimized path instead
 *      uses boundary guards -> saves a full write pass and the padded buffer.
 *
 *  (6) Quantization (next step, out of scope for the FP32 golden).
 *      Per-channel int8 (int8*int8 -> int32 accumulate) ~4x less memory and
 *      far cheaper MACs.  The LINEAR bottleneck (no ReLU after project) keeps
 *      a signed range, which matters when picking quant parameters.
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "mobilenetv2_parameters.h"   /* features_8_* weights (const float[]) */

/* ---- Layer 8 geometry -------------------------------------------------- */
#define CIN   64      /* block input / output channels                      */
#define CEXP  384     /* expanded channels (t = 6 -> 64*6)                   */
#define H     14
#define W     14
#define HW    (H * W) /* 196 spatial positions                              */
#define K     3       /* depthwise kernel                                   */
#define EPS   1e-5f

#define DIR        "MobileNet_v2/"
#define IN_BIN     DIR "mobilenetv2_result_layer07.bin"
#define GOLDEN_BIN DIR "mobilenetv2_result_layer08.bin"

/* tensor indexing helpers (CHW, contiguous) */
#define IDX(c, h, w)  (((c) * H + (h)) * W + (w))

/* ---- I/O --------------------------------------------------------------- */
static int load_bin(const char *path, float *buf, size_t n)
{
    FILE *f = fopen(path, "rb");
    if (!f) { fprintf(stderr, "ERROR: cannot open %s\n", path); return -1; }
    size_t got = fread(buf, sizeof(float), n, f);
    fclose(f);
    if (got != n) {
        fprintf(stderr, "ERROR: %s has %zu floats, expected %zu\n", path, got, n);
        return -1;
    }
    return 0;
}

static int save_bin(const char *path, const float *buf, size_t n)
{
    FILE *f = fopen(path, "wb");
    if (!f) { fprintf(stderr, "ERROR: cannot write %s\n", path); return -1; }
    size_t put = fwrite(buf, sizeof(float), n, f);
    fclose(f);
    if (put != n) { fprintf(stderr, "ERROR: short write to %s\n", path); return -1; }
    return 0;
}

/* Explicit golden match check: load the reference .bin and compare element-wise.
 * Returns 1 (match) when every element is within tol of the golden value.      */
static int verify_against_golden(const char *golden_path, const float *y, size_t n, float tol)
{
    static float gold[CIN * HW];
    if (load_bin(golden_path, gold, n)) return 0;

    size_t exact = 0, mism = 0, argmax = 0;
    double max_err = 0.0;
    for (size_t i = 0; i < n; ++i) {
        if (y[i] == gold[i]) ++exact;                /* bit-exact count        */
        double e = fabs((double)y[i] - (double)gold[i]);
        if (e > max_err) { max_err = e; argmax = i; }
        if (e > tol) ++mism;                         /* over-tolerance count   */
    }
    int match = (mism == 0);
    printf("verify vs %s :\n", golden_path);
    printf("  elements        : %zu\n", n);
    printf("  bit-exact       : %zu\n", exact);
    printf("  within tol(%.0e) : %zu\n", (double)tol, n - mism);
    printf("  over tolerance  : %zu\n", mism);
    printf("  max abs error   : %.3e (idx %zu: got %.6f vs golden %.6f)\n",
           max_err, argmax, y[argmax], gold[argmax]);
    printf("  => %s\n", match ? "MATCH (output equals golden layer08.bin)"
                              : "MISMATCH");
    return match;
}

/* ============================================================================
 *  REFERENCE implementation -- literal, slide-faithful, easy to read.
 *  Separate buffers per stage, explicit sqrt BN, explicit zero-padded buffer.
 * ==========================================================================*/
static void bn_relu6_ref(float *t, int C,
                         const float *gamma, const float *beta,
                         const float *mean,  const float *var, int relu6)
{
    for (int c = 0; c < C; ++c) {
        float inv = 1.0f / sqrtf(var[c] + EPS);
        for (int i = 0; i < HW; ++i) {
            float y = gamma[c] * (t[c * HW + i] - mean[c]) * inv + beta[c];
            if (relu6) { if (y < 0.0f) y = 0.0f; else if (y > 6.0f) y = 6.0f; }
            t[c * HW + i] = y;
        }
    }
}

static void layer8_reference(const float *in, float *out)
{
    static float exp_buf[CEXP * HW];                 /* after expand PW      */
    static float pad_buf[CEXP * (H + 2) * (W + 2)];  /* zero-padded [384][16][16] */
    static float dw_buf [CEXP * HW];                 /* after depthwise      */

    /* 1) Expand pointwise 1x1: out[oc][p] = sum_ic in[ic][p]*W0[oc*64+ic] */
    for (int oc = 0; oc < CEXP; ++oc)
        for (int p = 0; p < HW; ++p) {
            float acc = 0.0f;
            for (int ic = 0; ic < CIN; ++ic)
                acc += in[ic * HW + p] * features_8_conv_0_0_weight[oc * CIN + ic];
            exp_buf[oc * HW + p] = acc;
        }

    /* 2) BN + ReLU6 */
    bn_relu6_ref(exp_buf, CEXP,
                 features_8_conv_0_1_weight, features_8_conv_0_1_bias,
                 features_8_conv_0_1_running_mean, features_8_conv_0_1_running_var, 1);

    /* 3) Depthwise 3x3 s1 p1 -- via an explicit zero-padded [384][16][16] buffer */
    const int PW = W + 2;                  /* padded row width = 16 */
    memset(pad_buf, 0, sizeof(pad_buf));
    for (int c = 0; c < CEXP; ++c)
        for (int h = 0; h < H; ++h)
            for (int w = 0; w < W; ++w)
                pad_buf[(c * (H + 2) + (h + 1)) * PW + (w + 1)] = exp_buf[c * HW + h * W + w];

    for (int c = 0; c < CEXP; ++c) {
        const float *ker = &features_8_conv_1_0_weight[c * K * K];
        for (int oh = 0; oh < H; ++oh)
            for (int ow = 0; ow < W; ++ow) {
                float acc = 0.0f;
                for (int kh = 0; kh < K; ++kh)
                    for (int kw = 0; kw < K; ++kw)
                        acc += pad_buf[(c * (H + 2) + (oh + kh)) * PW + (ow + kw)]
                             * ker[kh * K + kw];
                dw_buf[c * HW + oh * W + ow] = acc;
            }
    }

    /* 4) BN + ReLU6 */
    bn_relu6_ref(dw_buf, CEXP,
                 features_8_conv_1_1_weight, features_8_conv_1_1_bias,
                 features_8_conv_1_1_running_mean, features_8_conv_1_1_running_var, 1);

    /* 5) Project pointwise 1x1: out[oc][p] = sum_ic dw[ic][p]*W2[oc*384+ic] */
    for (int oc = 0; oc < CIN; ++oc)
        for (int p = 0; p < HW; ++p) {
            float acc = 0.0f;
            for (int ic = 0; ic < CEXP; ++ic)
                acc += dw_buf[ic * HW + p] * features_8_conv_2_weight[oc * CEXP + ic];
            out[oc * HW + p] = acc;
        }

    /* 6) BN (linear, NO ReLU) */
    bn_relu6_ref(out, CIN,
                 features_8_conv_3_weight, features_8_conv_3_bias,
                 features_8_conv_3_running_mean, features_8_conv_3_running_var, 0);

    /* 7) Residual add (skip connection) */
    for (int i = 0; i < CIN * HW; ++i)
        out[i] += in[i];
}

/* ============================================================================
 *  OPTIMIZED implementation -- hardware-oriented, portable C99.
 *  (a) BN scale/shift precomputed once  -> no sqrt/div in hot loops
 *  (b) conv + BN + ReLU6 fused in a single pass (no extra memory passes)
 *  (c) depthwise uses boundary guards   -> no materialized padded buffer
 *  (d) residual fused into the project store
 *  (e) GEMM-style loop order + optional OpenMP/SIMD
 * ==========================================================================*/
static void fold_bn(const float *gamma, const float *beta,
                    const float *mean, const float *var,
                    float *scale, float *shift, int C)
{
    for (int c = 0; c < C; ++c) {
        float s = gamma[c] / sqrtf(var[c] + EPS);   /* sqrt/div done ONCE   */
        scale[c] = s;
        shift[c] = beta[c] - mean[c] * s;
    }
}

static inline float relu6(float x)
{
    if (x < 0.0f) return 0.0f;
    if (x > 6.0f) return 6.0f;
    return x;
}

static void layer8_optimized(const float *in, float *out)
{
    static float exp_buf[CEXP * HW];   /* expand+BN+ReLU6 result            */
    static float dw_buf [CEXP * HW];   /* depthwise+BN+ReLU6 result         */

    /* precompute folded BN params for all three BN layers */
    float s0[CEXP], b0[CEXP], s1[CEXP], b1[CEXP], s3[CIN], b3[CIN];
    fold_bn(features_8_conv_0_1_weight, features_8_conv_0_1_bias,
            features_8_conv_0_1_running_mean, features_8_conv_0_1_running_var, s0, b0, CEXP);
    fold_bn(features_8_conv_1_1_weight, features_8_conv_1_1_bias,
            features_8_conv_1_1_running_mean, features_8_conv_1_1_running_var, s1, b1, CEXP);
    fold_bn(features_8_conv_3_weight, features_8_conv_3_bias,
            features_8_conv_3_running_mean, features_8_conv_3_running_var, s3, b3, CIN);

    /* 1+2) Expand PW fused with BN+ReLU6.
     * HW map: one PE per output channel (oc), 196-wide spatial SIMD inner loop;
     *         the 64-wide input column in[*][p] is reused across all 384 oc.   */
#ifdef _OPENMP
#pragma omp parallel for schedule(static)
#endif
    for (int oc = 0; oc < CEXP; ++oc) {
        const float *w = &features_8_conv_0_0_weight[oc * CIN];
        for (int p = 0; p < HW; ++p) {
            float acc = 0.0f;
            for (int ic = 0; ic < CIN; ++ic)
                acc = fmaf(in[ic * HW + p], w[ic], acc);
            exp_buf[oc * HW + p] = relu6(fmaf(acc, s0[oc], b0[oc]));  /* fused BN+ReLU6 */
        }
    }

    /* 3+4) Depthwise 3x3 fused with BN+ReLU6, NO padded buffer (boundary guards).
     * HW map: 384 channel-parallel lanes, each holding a 3x3 window in regs.   */
#ifdef _OPENMP
#pragma omp parallel for schedule(static)
#endif
    for (int c = 0; c < CEXP; ++c) {
        const float *ker = &features_8_conv_1_0_weight[c * K * K];
        const float *src = &exp_buf[c * HW];
        for (int oh = 0; oh < H; ++oh)
            for (int ow = 0; ow < W; ++ow) {
                float acc = 0.0f;
                for (int kh = 0; kh < K; ++kh) {
                    int ih = oh + kh - 1;
                    if (ih < 0 || ih >= H) continue;        /* zero outside */
                    for (int kw = 0; kw < K; ++kw) {
                        int iw = ow + kw - 1;
                        if (iw < 0 || iw >= W) continue;
                        acc = fmaf(src[ih * W + iw], ker[kh * K + kw], acc);
                    }
                }
                dw_buf[c * HW + oh * W + ow] = relu6(fmaf(acc, s1[c], b1[c]));
            }
    }

    /* 5+6+7) Project PW fused with BN (linear) AND residual add in one store.
     * HW map: one PE per output channel (oc), 196-wide spatial SIMD;
     *         the 384-wide depthwise column dw[*][p] is reused across 64 oc.   */
#ifdef _OPENMP
#pragma omp parallel for schedule(static)
#endif
    for (int oc = 0; oc < CIN; ++oc) {
        const float *w = &features_8_conv_2_weight[oc * CEXP];
        for (int p = 0; p < HW; ++p) {
            float acc = 0.0f;
            for (int ic = 0; ic < CEXP; ++ic)
                acc = fmaf(dw_buf[ic * HW + p], w[ic], acc);
            /* BN (no ReLU) + residual fused into the single output write */
            out[oc * HW + p] = fmaf(acc, s3[oc], b3[oc]) + in[oc * HW + p];
        }
    }
}

/* ---- verification ------------------------------------------------------ */
static int compare(const char *tag, const float *y, const float *gold, size_t n, float tol)
{
    double max_err = 0.0, sum_err = 0.0, sum_sq = 0.0, sum_gsq = 0.0;
    size_t over = 0, argmax = 0;
    for (size_t i = 0; i < n; ++i) {
        double e = fabs((double)y[i] - (double)gold[i]);
        if (e > max_err) { max_err = e; argmax = i; }
        if (e > tol) ++over;
        sum_err += e;
        sum_sq  += e * e;
        sum_gsq += (double)gold[i] * (double)gold[i];
    }
    double mse  = sum_sq / n;
    double psnr = (mse > 0.0) ? 10.0 * log10((sum_gsq / n) / mse) : INFINITY;
    int pass = (max_err < tol);
    printf("[%-9s] max=%.3e (@%zu: got %.6f vs gold %.6f)  mean=%.3e  >tol=%zu/%zu  PSNR=%.1f dB  -> %s\n",
           tag, max_err, argmax, y[argmax], gold[argmax],
           sum_err / n, over, n, psnr, pass ? "PASS" : "FAIL");
    return pass;
}

int main(void)
{
    static float in[CIN * HW], gold[CIN * HW];
    static float out_ref[CIN * HW], out_opt[CIN * HW];

    if (load_bin(IN_BIN, in, CIN * HW))       return 1;
    if (load_bin(GOLDEN_BIN, gold, CIN * HW)) return 1;

    layer8_reference(in, out_ref);
    layer8_optimized(in, out_opt);

    printf("MobileNetV2 Layer 8 (InvertedResidual 64->64, 14x14)  vs golden layer08.bin\n");
    const float tol = 1e-3f;
    int p1 = compare("reference", out_ref, gold, CIN * HW, tol);
    int p2 = compare("optimized", out_opt, gold, CIN * HW, tol);
    compare("ref-vs-opt", out_ref, out_opt, CIN * HW, tol);  /* the two should agree */

    printf("\nfirst 8 outputs:  idx : reference / optimized / golden\n");
    for (int i = 0; i < 8; ++i)
        printf("  %2d : % .6f / % .6f / % .6f\n", i, out_ref[i], out_opt[i], gold[i]);

    /* Save our computed Layer 8 output so it can be diffed against the golden .bin */
    const char *out_path = DIR "mobilenetv2_result_layer08_mine.bin";
    if (save_bin(out_path, out_opt, CIN * HW) == 0)
        printf("\nsaved computed output -> %s\n", out_path);

    /* Explicit "does it match the golden file?" check */
    printf("\n");
    int match = verify_against_golden(GOLDEN_BIN, out_opt, CIN * HW, tol);

    printf("\n%s\n", (p1 && p2 && match) ? "RESULT: PASS" : "RESULT: FAIL");
    return (p1 && p2 && match) ? 0 : 2;
}
