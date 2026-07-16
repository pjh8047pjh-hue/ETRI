//--------------------------------------------------------------------
// Copyright (c) 2024 by Future Design Systems Co., Ltd.
// All right reserved.
//
// http://www.future-ds.com
//--------------------------------------------------------------------
// dma_axi_api.c
//--------------------------------------------------------------------
// VERSION = 2024.07.16.
//--------------------------------------------------------------------
//#ifndef COMPACT_CODE
//#endif
//--------------------------------------------------------------------
#include "dma_axi_api.h"

//--------------------------------------------------------------------
// Register access macros
#define REGRD(add,val)      (val) = *((volatile uint32_t *)(add))
#define REGWR(add,val)     *((volatile uint32_t *)(add)) = (val)
#define MEM_WRITE_N(A,B,N)   memcpy((A), (B), (N)*4)
#define MEM_READ_N(A,B,N)    memcpy((B), (A), (N)*4)

//--------------------------------------------------------------------
static uint32_t ADDR_DMA_AHB_START=0x50000000;
static uint32_t CSRA_CONTROL=(ADDR_DMA_AHB_START+0x30);
static uint32_t CSRA_NUM    =(ADDR_DMA_AHB_START+0x40);
static uint32_t CSRA_SRC    =(ADDR_DMA_AHB_START+0x44);
static uint32_t CSRA_DST    =(ADDR_DMA_AHB_START+0x48);

//--------------------------------------------------------------------
// bit position
#define DMA_AHB_ctl_en     31
#define DMA_AHB_ctl_ip     1
#define DMA_AHB_ctl_ie     0

#define DMA_AHB_num_go     31
#define DMA_AHB_num_busy   30
#define DMA_AHB_num_done   29
#define DMA_AHB_num_chunk  16
#define DMA_AHB_num_bnum   0

//--------------------------------------------------------------------
// bit mask
#define DMA_AHB_ctl_en_MSK     0x80000000
#define DMA_AHB_ctl_ip_MSK     0x2
#define DMA_AHB_ctl_ie_MSK     0x1

#define DMA_AHB_num_go_MSK     0x80000000
#define DMA_AHB_num_busy_MSK   0x40000000
#define DMA_AHB_num_done_MSK   0x20000000
#define DMA_AHB_num_chunk_MSK  0x00FF0000
#define DMA_AHB_num_bnum_MSK   0x0000FFFF

//--------------------------------------------------------------------
// read control register
int dma_axi_control( uint32_t *cnt )
{
    volatile uint32_t value;
    REGRD(CSRA_CONTROL, value);
    *cnt = value;
    return 0;
}

//--------------------------------------------------------------------
// read control register
int dma_axi_enable( int en, int ie )
{
    volatile uint32_t value;
    value = 0;
    if (en) value |= DMA_AHB_ctl_en_MSK;
    if (ie) value |= DMA_AHB_ctl_ie_MSK;
    REGWR(CSRA_CONTROL, value);
    return 0;
}

//--------------------------------------------------------------------
int dma_axi_go ( uint32_t dst
               , uint32_t src
               , uint32_t bnum
               , uint32_t chunk
               , int time_out)
{
    volatile uint32_t value;
    int dly;
    #if defined(RIGOR)
    //if ((dst&((chunk*4)-1))!=(src&((chunk*4)-1))) {
    if ((dst&0x3)!=(src&0x3)) {
       printf("%s:%s ERROR src and dest address should be the same in terms of alignment 0x%x 0x%x\n",
               __FILE__, __FUNCTION__, src, dst);
    }
    #endif
    REGWR(CSRA_DST, dst);
    REGWR(CSRA_SRC, src);
    value  = DMA_AHB_num_go_MSK | (chunk&0xFF)<<16 | (bnum&0xFFFF);
    REGWR(CSRA_NUM, value);
    dly = 0;
    do { REGRD(CSRA_NUM, value);
         if (time_out) {
             dly++;
             if (dly>time_out) return 1;
         }
    } while (value&DMA_AHB_num_go_MSK);
    return 0;
}
//--------------------------------------------------------------------
// clear interrupt
int dma_axi_clear  ( void ) // interrupt clear
{
    volatile uint32_t value;
    REGRD(CSRA_CONTROL, value);
    value  |= DMA_AHB_ctl_ip_MSK;
    REGWR(CSRA_CONTROL, value);
    return 0;
}
/**
 * @brief Get all values of CSR.
 *
 * @return void
 */
void dma_axi_csr(void)
{
    uint32_t dataR;
    REGRD(CSRA_CONTROL, dataR); printf("DMA CONTROL: 0x%08lX\n", dataR);
    REGRD(CSRA_NUM    , dataR); printf("DMA NUM    : 0x%08lX\n", dataR);
    REGRD(CSRA_SRC    , dataR); printf("DMA SRC    : 0x%08lX\n", dataR);
    REGRD(CSRA_DST    , dataR); printf("DMA DST    : 0x%08lX\n", dataR);
}
//--------------------------------------------------------------------
/**
 * @brief Set base (offset) address.
 *
 * @param offset offset address
 *
 * @return 0 on success, otherwise negative number.
 */
int dma_axi_set_addr( uint32_t offset )
{
    ADDR_DMA_AHB_START=offset;
    CSRA_CONTROL=(offset+0x30);
    CSRA_NUM    =(offset+0x40);
    CSRA_SRC    =(offset+0x44);
    CSRA_DST    =(offset+0x48);
    return 0;
}
/**
 * @brief Get base (offset) address.
 *
 * @return current base (offset) address.
 */
uint32_t dma_axi_get_addr( void )
{
    rreturn ADDR_DMA_AHB_START;
}
//--------------------------------------------------------------------
// Revision History
//
// 2024.07.16: Start by Ando Ki (adki@future-ds.com)
//--------------------------------------------------------------------
