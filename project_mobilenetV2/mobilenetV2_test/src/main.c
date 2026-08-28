/* Actual Layer 08 FPGA verification through AXI GPIO. */

#include "xgpio.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xil_cache.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "sleep.h"

#define RESULT_COUNT       12544U
#define DONE_MASK          0x00010000U
#define START_MASK         0x00000001U
#define RESET_MASK         0x00000002U
#define DONE_POLL_LIMIT    1000000U
#define MAX_ERROR_PRINTS   20U
#define PL0_REF_CTRL_ADDR  0xFF5E00C0U
#define PL0_CLKACT_MASK    0x01000000U
#define DIAG_SIGNATURE_ADDR 0x3FFCU
#define DIAG_COUNTER_ADDR   0x3FFDU
#define DIAG_WRITE_ADDR     0x3FFEU
#define DIAG_STATUS_ADDR    0x3FFFU

/* Kept in PS memory so the complete hardware result can be inspected later. */
volatile s16 output_data[RESULT_COUNT];
volatile u32 verification_state = 0x4C380000U;
volatile u32 verification_error_count = 0xFFFFFFFFU;

static u32 read_result_address(XGpio *gpio, u32 address)
{
    XGpio_DiscreteWrite(gpio, 1, address << 2);
    usleep(10);
    return XGpio_DiscreteRead(gpio, 2) & 0xFFFFU;
}

static void print_hardware_diagnostics(XGpio *gpio)
{
    u32 signature = read_result_address(gpio, DIAG_SIGNATURE_ADDR);
    u32 counter_a = read_result_address(gpio, DIAG_COUNTER_ADDR);
    u32 write_addr = read_result_address(gpio, DIAG_WRITE_ADDR);
    u32 diag = read_result_address(gpio, DIAG_STATUS_ADDR);
    u32 counter_b;

    usleep(1000);
    counter_b = read_result_address(gpio, DIAG_COUNTER_ADDR);

    xil_printf("DIAG signature=0x%04x counter=%04x->%04x write_addr=%u status=0x%04x\r\n",
               signature, counter_a, counter_b, write_addr, diag);
    xil_printf("DIAG lock=%u reset=%u start_level=%u start_seen=%u "
               "pw1_seen=%u pw1_done=%u depth_seen=%u bram_done=%u "
               "pw2_seen=%u results_ready=%u\r\n",
               (diag >> 15) & 1U, (diag >> 14) & 1U,
               (diag >> 13) & 1U, (diag >> 12) & 1U,
               (diag >> 10) & 1U, (diag >> 8) & 1U,
               (diag >> 6) & 1U, (diag >> 4) & 1U,
               (diag >> 2) & 1U, diag & 1U);
}

static int golden_pw_q312(int channel, int pixel)
{
    static const int bias_q312[8] = {
        0, 1024, 2048, 3072, 4096, -1024, -2048, -4096
    };
    int value = pixel * 64 + (channel % 64) + bias_q312[channel % 8];

    if (value <= 0)
        return 0;
    if (value >= 24576)
        return 24576;
    return value;
}

static int golden_depth_q312(int channel, int pixel)
{
    int row = pixel / 14;
    int col = pixel % 14;
    int acc = 0;
    int bias_real;
    int dr;
    int dc;

    for (dr = -1; dr <= 1; ++dr) {
        for (dc = -1; dc <= 1; ++dc) {
            int rr = row + dr;
            int cc = col + dc;

            if (rr >= 0 && rr < 14 && cc >= 0 && cc < 14)
                acc += golden_pw_q312(channel, rr * 14 + cc);
        }
    }

    bias_real = channel % 8;
    if (bias_real == 7)
        bias_real = -1;
    acc += bias_real * 4096;

    if (acc <= 0)
        return 0;
    if (acc >= 24576)
        return 24576;
    return acc;
}

static s16 golden_p2_q34(u32 output_index)
{
    int output_channel = (int)(output_index / 196U);
    int pixel = (int)(output_index % 196U);
    int bias_q312 = (output_channel + 1) * 64;
    int skip_q312 = 2 * (pixel * 64 + output_channel);
    int value;

    if ((output_channel % 2) == 1)
        bias_q312 = -bias_q312;

    value = golden_depth_q312(6 * output_channel, pixel)
          + bias_q312 + skip_q312;
    return (s16)(value & 0xFFFF);
}

int main(void)
{
    XGpio gpio;
    u32 status = 0;
    u32 poll_count;
    u32 addr;
    u32 error_count = 0;
    u32 pl0_ref_ctrl;
    u32 reset_readback;
    u32 start_readback;

    xil_printf("\r\nMobileNetV2 hardware verification start\r\n");

    if (XGpio_Initialize(&gpio, XPAR_AXI_GPIO_0_DEVICE_ID) != XST_SUCCESS) {
        xil_printf("ERROR: AXI GPIO initialization failed\r\n");
        return XST_FAILURE;
    }
    /* Channel 1: {result_addr[13:0], rst, start}; Channel 2: {done, result}. */
    XGpio_SetDataDirection(&gpio, 1, 0x00000000U);
    /* Channel 2 is synthesized with C_ALL_INPUTS_2=1; do not write TRI2. */

    pl0_ref_ctrl = Xil_In32(PL0_REF_CTRL_ADDR);
    xil_printf("PL0_REF_CTRL=0x%08x CLKACT=%u\r\n",
               pl0_ref_ctrl,
               (pl0_ref_ctrl & PL0_CLKACT_MASK) ? 1U : 0U);

    /* Allow the PL reset release and the accelerator Clock Wizard to settle. */
    xil_printf("waiting for PL clock lock\r\n");
    sleep(1);

    XGpio_DiscreteWrite(&gpio, 1, RESET_MASK);
    usleep(1000);
    reset_readback = XGpio_DiscreteRead(&gpio, 1);
    XGpio_DiscreteWrite(&gpio, 1, 0U);
    usleep(1000);

    XGpio_DiscreteWrite(&gpio, 1, START_MASK);
    usleep(1000);
    start_readback = XGpio_DiscreteRead(&gpio, 1);
    XGpio_DiscreteWrite(&gpio, 1, 0U);
    usleep(1000);

    status = XGpio_DiscreteRead(&gpio, 2);
    xil_printf("GPIO reset_readback=0x%08x start_readback=0x%08x\r\n",
               reset_readback, start_readback);
    xil_printf("GPIO CH2 initial=0x%08x done=%u result=0x%04x\r\n",
               status, (status & DONE_MASK) ? 1U : 0U,
               status & 0xFFFFU);

    for (poll_count = 0; poll_count < DONE_POLL_LIMIT; ++poll_count) {
        status = XGpio_DiscreteRead(&gpio, 2);
        if ((status & DONE_MASK) != 0U)
            break;
    }
    if ((status & DONE_MASK) == 0U) {
        verification_state = 0x4C38DEADU;
        verification_error_count = 0xFFFFFFFFU;
        Xil_DCacheFlushRange((UINTPTR)&verification_state,
                             sizeof(verification_state) +
                             sizeof(verification_error_count));
        xil_printf("FAIL: timeout waiting for done, CH2=0x%08x\r\n", status);
        print_hardware_diagnostics(&gpio);
        while (1) {
            sleep(1);
            status = XGpio_DiscreteRead(&gpio, 2);
            pl0_ref_ctrl = Xil_In32(PL0_REF_CTRL_ADDR);
            xil_printf("HEARTBEAT: TIMEOUT PL0=0x%08x CH2=0x%08x\r\n",
                       pl0_ref_ctrl, status);
        }
    }

    xil_printf("done detected; reading %u results\r\n", RESULT_COUNT);

    for (addr = 0; addr < RESULT_COUNT; ++addr) {
        s16 expected;

        XGpio_DiscreteWrite(&gpio, 1, addr << 2);
        usleep(1);
        status = XGpio_DiscreteRead(&gpio, 2);
        output_data[addr] = (s16)(status & 0xFFFFU);
        expected = golden_p2_q34(addr);

        if (output_data[addr] != expected) {
            if (error_count < MAX_ERROR_PRINTS) {
                xil_printf("MISMATCH[%u]: got=%d expected=%d\r\n",
                           addr, (int)output_data[addr], (int)expected);
            }
            ++error_count;
        }
    }

    Xil_DCacheFlushRange((UINTPTR)output_data, sizeof(output_data));
    verification_error_count = error_count;
    verification_state = (error_count == 0U) ? 0x4C38A551U : 0x4C38FA11U;
    Xil_DCacheFlushRange((UINTPTR)&verification_state,
                         sizeof(verification_state) +
                         sizeof(verification_error_count));

    if (error_count == 0U) {
        xil_printf("PASS: all %u results match golden\r\n", RESULT_COUNT);
    } else {
        xil_printf("FAIL: %u / %u results mismatched\r\n",
                   error_count, RESULT_COUNT);
    }

    xil_printf("first 8 results:");
    for (addr = 0; addr < 8U; ++addr)
        xil_printf(" %d", (int)output_data[addr]);
    xil_printf("\r\n");

    /* Repeat the final status so a terminal opened after execution can see it. */
    while (1) {
        sleep(1);
        if (error_count == 0U)
            xil_printf("HEARTBEAT: PASS (%u results)\r\n", RESULT_COUNT);
        else
            xil_printf("HEARTBEAT: FAIL (%u mismatches)\r\n", error_count);
    }
}
