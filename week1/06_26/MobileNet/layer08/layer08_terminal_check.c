/* Minimal terminal checks for the Layer 08 Q3.12 BRAM COE images. */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CIN 64
#define COUT 384
#define HW 196
#define FRAC_BITS 12
#define RELU6_Q 0x6000

typedef struct {
    char *data;
    int words;
    int digits;
} Coe;

static void make_path(char *out, size_t size, const char *dir, const char *name)
{
    snprintf(out, size, "%s/%s", dir, name);
}

static void strip_line(char *line)
{
    size_t n = strlen(line);
    while (n && (line[n - 1] == '\r' || line[n - 1] == '\n' ||
                 line[n - 1] == ',' || line[n - 1] == ';'))
        line[--n] = '\0';
}

static int read_coe(const char *path, int words, int digits, Coe *coe)
{
    FILE *fp = fopen(path, "r");
    char line[1024];
    int count = 0;
    if (!fp) return -1;

    if (!fgets(line, sizeof(line), fp) ||
        strcmp(line, "memory_initialization_radix=16;\n") != 0) {
        fclose(fp);
        return -1;
    }
    if (!fgets(line, sizeof(line), fp)) {
        fclose(fp);
        return -1;
    }
    strip_line(line);
    if (strcmp(line, "memory_initialization_vector=") != 0) {
        fclose(fp);
        return -1;
    }

    coe->data = calloc((size_t)words, (size_t)digits + 1);
    if (!coe->data) {
        fclose(fp);
        return -1;
    }
    coe->words = words;
    coe->digits = digits;

    while (fgets(line, sizeof(line), fp)) {
        strip_line(line);
        if (!line[0]) continue;
        if (count >= words || (int)strlen(line) != digits) {
            free(coe->data);
            fclose(fp);
            return -1;
        }
        memcpy(coe->data + (size_t)count * (digits + 1), line, (size_t)digits + 1);
        ++count;
    }
    fclose(fp);
    if (count != words) {
        free(coe->data);
        return -1;
    }
    return 0;
}

static const char *coe_word(const Coe *coe, int address)
{
    return coe->data + (size_t)address * (coe->digits + 1);
}

static uint32_t hex_slice(const char *text, int offset, int digits)
{
    char token[9];
    memcpy(token, text + offset, (size_t)digits);
    token[digits] = '\0';
    return (uint32_t)strtoul(token, NULL, 16);
}

static int16_t lane16(const Coe *coe, int address, int lane)
{
    const char *word = coe_word(coe, address);
    int offset = coe->digits - 4 * (lane + 1);
    return (int16_t)hex_slice(word, offset, 4);
}

static int32_t lane32(const Coe *coe, int address, int lane)
{
    const char *word = coe_word(coe, address);
    int offset = coe->digits - 8 * (lane + 1);
    return (int32_t)hex_slice(word, offset, 8);
}

static int load_i16(const char *path, int16_t *data, size_t count)
{
    FILE *fp = fopen(path, "rb");
    size_t got;
    if (!fp) return -1;
    got = fread(data, sizeof(*data), count, fp);
    fclose(fp);
    return got == count ? 0 : -1;
}

static int input_check(const char *dir)
{
    Coe ifm = {0};
    int16_t *reference = malloc(CIN * HW * sizeof(*reference));
    char path[512];
    int matches = 0;
    if (!reference) return 2;

    make_path(path, sizeof(path), dir, "q312_ifm_1024.coe");
    if (read_coe(path, HW, 256, &ifm)) goto error;
    make_path(path, sizeof(path), dir, "q312_input_chw_int16.bin");
    if (load_i16(path, reference, CIN * HW)) goto error;

    for (int address = 0; address < HW; ++address)
        for (int channel = 0; channel < CIN; ++channel)
            matches += lane16(&ifm, address, channel) == reference[channel * HW + address];

    printf("MODE     : COE TEST\n");
    printf("INPUT    :");
    for (int channel = 0; channel < 4; ++channel)
        printf(" %04x", (uint16_t)reference[channel * HW]);
    putchar('\n');
    printf("READBACK :");
    for (int channel = 0; channel < 4; ++channel)
        printf(" %04x", (uint16_t)lane16(&ifm, 0, channel));
    putchar('\n');
    printf("EXPECTED :");
    for (int channel = 0; channel < 4; ++channel)
        printf(" %04x", (uint16_t)reference[channel * HW]);
    putchar('\n');
    printf("%s (%d/%d)\n",
           matches == CIN * HW ? "PASS" : "FAIL", matches, CIN * HW);
    free(ifm.data);
    free(reference);
    return matches == CIN * HW ? 0 : 1;

error:
    fprintf(stderr, "ERROR: cannot read Layer 08 IFM files in %s\n", dir);
    free(ifm.data);
    free(reference);
    return 2;
}

static int example_check(void)
{
    const int16_t input[4] = {0x1000, 0x2000, 0x3000, 0x4000};
    const int16_t weight[4] = {0x0800, 0x0400, -0x0800, 0x1000};
    const int16_t expected = 0x3800;
    int64_t acc = 0;

    for (int i = 0; i < 4; ++i)
        acc += (int32_t)input[i] * weight[i];
    int16_t output = (int16_t)((acc + (1 << (FRAC_BITS - 1))) >> FRAC_BITS);

    printf("MODE     : COE TEST\n");
    printf("INPUT    :");
    for (int i = 0; i < 4; ++i)
        printf(" %04x", (uint16_t)input[i]);
    printf("\nREADBACK : %04x\n", (uint16_t)output);
    printf("EXPECTED : %04x\n", (uint16_t)expected);
    printf("%s\n", output == expected ? "PASS" : "FAIL");
    return output == expected ? 0 : 1;
}

static int result_check(const char *dir)
{
    Coe ifm = {0}, weight_coe = {0}, bias_coe = {0}, golden = {0};
    int16_t *input = calloc(CIN * HW, sizeof(*input));
    int16_t *weight = calloc(COUT * CIN, sizeof(*weight));
    int16_t *output = calloc(COUT * HW, sizeof(*output));
    int32_t *bias = calloc(COUT, sizeof(*bias));
    char path[512];
    int matches = 0;
    int first_oc = -1, first_pos = -1;
    int16_t first_actual = 0, first_expected = 0;
    if (!input || !weight || !output || !bias) goto error;

    make_path(path, sizeof(path), dir, "q312_ifm_1024.coe");
    if (read_coe(path, HW, 256, &ifm)) goto error;
    make_path(path, sizeof(path), dir, "q312_weight_1024.coe");
    if (read_coe(path, COUT, 256, &weight_coe)) goto error;
    make_path(path, sizeof(path), dir, "q312_bias_chunks_2048.coe");
    if (read_coe(path, COUT / CIN, 512, &bias_coe)) goto error;
    make_path(path, sizeof(path), dir, "q312_golden_output_chunks_1024.coe");
    if (read_coe(path, (COUT / CIN) * HW, 256, &golden)) goto error;

    for (int pos = 0; pos < HW; ++pos)
        for (int ic = 0; ic < CIN; ++ic)
            input[ic * HW + pos] = lane16(&ifm, pos, ic);

    for (int chunk = 0; chunk < COUT / CIN; ++chunk)
        for (int ic = 0; ic < CIN; ++ic)
            for (int output_lane = 0; output_lane < CIN; ++output_lane) {
                int oc = chunk * CIN + output_lane;
                weight[oc * CIN + ic] = lane16(&weight_coe, chunk * CIN + ic, output_lane);
            }

    for (int oc = 0; oc < COUT; ++oc)
        bias[oc] = lane32(&bias_coe, oc / CIN, oc % CIN);

    for (int oc = 0; oc < COUT; ++oc)
        for (int pos = 0; pos < HW; ++pos) {
            int64_t acc = bias[oc];
            for (int ic = 0; ic < CIN; ++ic)
                acc += (int32_t)input[ic * HW + pos] * weight[oc * CIN + ic];
            if (acc <= 0) output[oc * HW + pos] = 0;
            else {
                int64_t value = (acc + (1 << (FRAC_BITS - 1))) >> FRAC_BITS;
                output[oc * HW + pos] = (int16_t)(value > RELU6_Q ? RELU6_Q : value);
            }
        }

    for (int oc = 0; oc < COUT; ++oc)
        for (int pos = 0; pos < HW; ++pos) {
            int16_t actual = output[oc * HW + pos];
            int16_t expected = lane16(&golden, (oc / CIN) * HW + pos, oc % CIN);
            if (actual == expected) ++matches;
            else if (first_oc < 0) {
                first_oc = oc;
                first_pos = pos;
                first_actual = actual;
                first_expected = expected;
            }
        }

    for (int address = 0; address < 4; ++address)
        printf("%04x  %04x\n",
               (uint16_t)output[address], (uint16_t)lane16(&golden, address, 0));
    printf("%s (%d/%d)\n", matches == COUT * HW ? "PASS" : "FAIL",
           matches, COUT * HW);
    if (first_oc >= 0)
        printf("FIRST ERR: channel=%d, pixel=%d, calc=%04x, golden=%04x\n",
               first_oc, first_pos, (uint16_t)first_actual, (uint16_t)first_expected);

    free(ifm.data); free(weight_coe.data); free(bias_coe.data); free(golden.data);
    free(input); free(weight); free(output); free(bias);
    return matches == COUT * HW ? 0 : 1;

error:
    fprintf(stderr, "ERROR: cannot read Layer 08 COE files in %s\n", dir);
    free(ifm.data); free(weight_coe.data); free(bias_coe.data); free(golden.data);
    free(input); free(weight); free(output); free(bias);
    return 2;
}

int main(int argc, char **argv)
{
    const char *dir = argc > 2 ? argv[2] : "q312_hw";
    if (argc < 2 || (strcmp(argv[1], "example") && strcmp(argv[1], "actual") &&
                     strcmp(argv[1], "result"))) {
        fprintf(stderr, "Usage: %s example|actual [q312_hw_dir]\n", argv[0]);
        return 2;
    }
    if (strcmp(argv[1], "example") == 0) return example_check();
    if (strcmp(argv[1], "actual") == 0) return input_check(dir);
    return result_check(dir);
}
