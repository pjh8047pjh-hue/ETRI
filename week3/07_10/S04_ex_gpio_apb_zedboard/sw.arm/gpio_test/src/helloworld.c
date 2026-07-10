
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

void delay_ms(volatile int ms)
{
    volatile int i;
    for (; ms > 0; ms--)
        for (i = 0; i < 100000; i++);
}

int main()
{
    init_platform();

    print("GPIO Test\n\r");

    // gpio_apb_xilinx_0 base = 0x60002000 (axi4_to_apb4_s3 M2_APB / ADDR_PBASE2)
    volatile uint32_t *reg_ctrl = (uint32_t*)0x60002000;  // REG_CTRL: 0=input, 1=output
    volatile uint32_t *reg_line = (uint32_t*)0x60002004;  // REG_LINE: write->LED, read->BTN
    volatile uint32_t *reg_mask = (uint32_t*)0x60002008;  // REG_MASK
    volatile uint32_t *reg_flag = (uint32_t*)0x6000200C;  // REG_FLAG

    printf("CTRL=0x%08lX\n\r", *reg_ctrl);
    printf("LINE=0x%08lX\n\r", *reg_line);
    printf("MASK=0x%08lX\n\r", *reg_mask);
    printf("FLAG=0x%08lX\n\r", *reg_flag);

    // led1~5 (하위 5비트) 하나씩 매핑 확인하며 순서대로 켜기
    for (int bit = 0; bit < 5; bit++) {
        uint32_t pattern = (1 << bit);
        *reg_line = pattern;
        printf("led%d ON, LINE=0x%02X\n\r", bit + 1, (unsigned)pattern);
        delay_ms(500);
    }
    *reg_line = 0x00;

    // 버튼 상태가 바뀔 때만 출력 + LED 반영 (값이 정확히 몇 비트 서는지 눈으로 확인)
    uint32_t last = 0xFFFFFFFF;
    while (1) {
        uint32_t btn = *reg_line & 0x1F;
        if (btn != last) {
            *reg_line = btn;
            printf("BTN=0x%02X\n\r", (unsigned)btn);
            last = btn;
        }
        delay_ms(50);
    }

    cleanup_platform();
    return 0;
}