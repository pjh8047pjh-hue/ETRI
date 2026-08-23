/*
 * Temporary Vitis standalone self-test for Layer 08 Q3.12 data.
 *
 * This program verifies a small MAC example and actual Layer 08 input samples.
 * It does not start the Layer 08 accelerator. By default it uses CPU-visible
 * temporary RAM. Set USE_LAYER08_BRAM and LAYER08_BRAM_BASEADDR only after the
 * correct AXI BRAM address has been confirmed in xparameters.h.
 */

#ifdef HOST_TEST
#include <stdint.h>
#include <stdio.h>
typedef uint16_t u16;
typedef int16_t s16;
typedef uint32_t u32;
typedef int32_t s32;
typedef int64_t s64;
#define xil_printf printf
#define LINE_END "\n"
#else
#include "xil_printf.h"
#include "xil_types.h"
#define LINE_END "\r\n"
#endif

#define USE_LAYER08_BRAM       0
/* Example after confirming xparameters.h: XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR */
#define LAYER08_BRAM_BASEADDR  0x00000000U

#if USE_LAYER08_BRAM
#include "xparameters.h"
#include "xil_io.h"
#endif

#define SAMPLE_COUNT 4
#define FRAC_BITS     12

static volatile u16 temporary_memory[SAMPLE_COUNT];

static void print_hex16(u16 value)
{
    static const char hex[] = "0123456789abcdef";
    xil_printf("%c%c%c%c",
               hex[(value >> 12) & 0x0f],
               hex[(value >> 8) & 0x0f],
               hex[(value >> 4) & 0x0f],
               hex[value & 0x0f]);
}

static void print_values(const char *name, const u16 values[SAMPLE_COUNT], int count)
{
    xil_printf("%s:", name);
    for (int i = 0; i < count; ++i) {
        xil_printf(" ");
        print_hex16(values[i]);
    }
    xil_printf(LINE_END);
}

static void memory_write(int index, u16 value)
{
#if USE_LAYER08_BRAM
    UINTPTR address = (UINTPTR)LAYER08_BRAM_BASEADDR + (UINTPTR)(index & ~1) * 2U;
    u32 word = Xil_In32(address);
    if (index & 1)
        word = (word & 0x0000ffffU) | ((u32)value << 16);
    else
        word = (word & 0xffff0000U) | value;
    Xil_Out32(address, word);
#else
    temporary_memory[index] = value;
#endif
}

static u16 memory_read(int index)
{
#if USE_LAYER08_BRAM
    UINTPTR address = (UINTPTR)LAYER08_BRAM_BASEADDR + (UINTPTR)(index & ~1) * 2U;
    u32 word = Xil_In32(address);
    return (u16)((index & 1) ? (word >> 16) : word);
#else
    return temporary_memory[index];
#endif
}

static int compare_values(const u16 *actual, const u16 *expected, int count)
{
    for (int i = 0; i < count; ++i)
        if (actual[i] != expected[i]) return 0;
    return 1;
}

static void print_mode(void)
{
    xil_printf("MODE     : LAYER08 SELF TEST" LINE_END);
}

static int run_example_test(void)
{
    const s16 input[SAMPLE_COUNT] = {0x1000, 0x2000, 0x3000, 0x4000};
    const s16 weight[SAMPLE_COUNT] = {0x0800, 0x0400, -0x0800, 0x1000};
    const u16 expected[SAMPLE_COUNT] = {0x3800, 0, 0, 0};
    u16 input_print[SAMPLE_COUNT];
    u16 readback[SAMPLE_COUNT] = {0, 0, 0, 0};
    s64 accumulator = 0;

    for (int i = 0; i < SAMPLE_COUNT; ++i) {
        input_print[i] = (u16)input[i];
        accumulator += (s32)input[i] * weight[i];
    }
    memory_write(0, (u16)((accumulator + (1 << (FRAC_BITS - 1))) >> FRAC_BITS));
    readback[0] = memory_read(0);

    print_mode();
    xil_printf("TEST     : EXAMPLE Q3.12 MAC" LINE_END);
    print_values("INPUT    ", input_print, SAMPLE_COUNT);
    print_values("READBACK ", readback, 1);
    print_values("EXPECTED ", expected, 1);
    xil_printf("%s" LINE_END LINE_END,
               compare_values(readback, expected, 1) ? "PASS" : "FAIL");
    return compare_values(readback, expected, 1);
}

static int run_actual_input_test(void)
{
    /* q312_ifm_1024.coe, address 0, channels 0..3. */
    const u16 input[SAMPLE_COUNT] = {0xef30, 0xf6b2, 0x106e, 0xf911};
    u16 readback[SAMPLE_COUNT];

    for (int i = 0; i < SAMPLE_COUNT; ++i)
        memory_write(i, input[i]);
    for (int i = 0; i < SAMPLE_COUNT; ++i)
        readback[i] = memory_read(i);

    print_mode();
    xil_printf("TEST     : ACTUAL LAYER08 INPUT" LINE_END);
    print_values("INPUT    ", input, SAMPLE_COUNT);
    print_values("READBACK ", readback, SAMPLE_COUNT);
    print_values("EXPECTED ", input, SAMPLE_COUNT);
    xil_printf("%s" LINE_END,
               compare_values(readback, input, SAMPLE_COUNT) ? "PASS" : "FAIL");
    return compare_values(readback, input, SAMPLE_COUNT);
}

int main(void)
{
    int example_pass;
    int actual_pass;

    example_pass = run_example_test();
    actual_pass = run_actual_input_test();
    xil_printf(LINE_END "FINAL    : %s" LINE_END,
               example_pass && actual_pass ? "PASS" : "FAIL");
    return example_pass && actual_pass ? 0 : 1;
}
