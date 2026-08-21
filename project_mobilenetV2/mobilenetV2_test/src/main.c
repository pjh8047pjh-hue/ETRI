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
#define DONE_POLL_LIMIT    10000000U
#define MAX_ERROR_PRINTS   20U
#define PL0_REF_CTRL_ADDR  0xFF5E00C0U
#define PL0_CLKACT_MASK    0x01000000U

/* Kept in PS memory so the complete hardware result can be inspected later. */
volatile s16 output_data[RESULT_COUNT];

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
    int dr, dc;

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
    XGpio_SetDataDirection(&gpio, 2, 0x0001FFFFU);

    pl0_ref_ctrl = Xil_In32(PL0_REF_CTRL_ADDR);
    xil_printf("PL0_REF_CTRL=0x%08x CLKACT=%u\r\n",
               pl0_ref_ctrl,
               (pl0_ref_ctrl & PL0_CLKACT_MASK) ? 1U : 0U);

    XGpio_DiscreteWrite(&gpio, 1, RESET_MASK);
    usleep(10);
    reset_readback = XGpio_DiscreteRead(&gpio, 1);
    XGpio_DiscreteWrite(&gpio, 1, 0U);
    usleep(10);

    XGpio_DiscreteWrite(&gpio, 1, START_MASK);
    usleep(10);
    start_readback = XGpio_DiscreteRead(&gpio, 1);
    XGpio_DiscreteWrite(&gpio, 1, 0U);
    usleep(10);

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
        xil_printf("FAIL: timeout waiting for done, CH2=0x%08x\r\n", status);
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
