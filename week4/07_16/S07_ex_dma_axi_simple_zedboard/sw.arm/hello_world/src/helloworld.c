/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "dma_axi_api.h"

#define ADDR_MEM_AXI0 0x40000000
#define ADDR_MEM_AXI1 0x60000000
#define ADDR_DMA_AXI  0x50000000

#define SIZE_MEM_AXI0 (1024*8)
#define SIZE_MEM_AXI1 (1024)

int main()
{
    init_platform();

    print("DMA-AXI-Simple Testing\n\r");
    print("Successfully ran Hello World application\n\r");

    volatile uint32_t dataW, dataR;
    volatile uint32_t *addr;

    addr=(uint32_t*)ADDR_MEM_AXI0;
    dataW = 0x12345678;
    *addr = dataW;
    dataR = *addr;
    printf("A=0x%08X DW=0x%08lX DR=0x%08lX\n\r", (unsigned)addr, dataW, dataR);

    addr=(uint32_t*)ADDR_MEM_AXI1;
    dataW = 0x87654321;
    *addr = dataW;
    dataR = *addr;
    printf("A=0x%08X DW=0x%08lX DR=0x%08lX\n\r", (unsigned)addr, dataW, dataR);

    //--------------------------------------------------------------------------
    // fill patterns in the source memory
    volatile uint32_t loc = ADDR_MEM_AXI1;
    uint32_t nbytes = 0x20; //SIZE_MEM_AXI1;
    for (uint32_t idx=0; idx<nbytes; idx+=4) { 
         *(uint32_t*)(loc+idx) = idx;
    }
    // read data from the soruce memory to check its contents
    loc = ADDR_MEM_AXI1;
    int error = 0;
    for (uint32_t idx=0; idx<nbytes; idx+=4) { 
         volatile uint32_t data = *(uint32_t*)(loc+idx);
         if (data!=idx) {
             printf("CHECK A=0x%08lX D=0x%08lX E=0x%08lX\n\r", loc+idx, data, idx);
             error++;
         }
    }
    if (error==0) {
        printf("Check %ld-bytes from 0x%08X to 0x%08X OK.\n\r", nbytes, ADDR_MEM_AXI1, ADDR_MEM_AXI0);
    } else {
        printf("Check %ld-bytes from 0x%08X to 0x%08X %d-word mismatch.\n\r", nbytes, ADDR_MEM_AXI1, ADDR_MEM_AXI0, error);
    }
    //--------------------------------------------------------------------------

    dma_axi_set_addr( ADDR_DMA_AXI );
    dma_axi_csr();

do {
printf("Enter to go:"); getchar();
    dma_axi_go( ADDR_MEM_AXI0 // dst
              , ADDR_MEM_AXI1 // src
              , nbytes // bnum
              , 16 // chunk
              , 0 ); // time out (0 for blocking)

    // read data from the destination memory
    loc = ADDR_MEM_AXI0;
    error = 0;
    for (uint32_t idx=0; idx<nbytes; idx+=4) { 
         volatile uint32_t data = *(uint32_t*)(loc+idx);
         if (data!=idx) {
             printf("DMA A=0x%08lX D=0x%08lX E=0x%08lX\n\r", loc+idx, data, idx);
             error++;
         }
    }
    if (error==0) {
        printf("DMA %ld-bytes from 0x%08X to 0x%08X OK.\n\r", nbytes, ADDR_MEM_AXI1, ADDR_MEM_AXI0);
    } else {
        printf("DMA %ld-bytes from 0x%08X to 0x%08X %d-word mismatch.\n\r", nbytes, ADDR_MEM_AXI1, ADDR_MEM_AXI0, error);
    }
} while (1);

    cleanup_platform();
    return 0;
}
