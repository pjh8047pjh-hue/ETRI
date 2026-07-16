#ifndef DMA_AXI_API_H
#define DMA_AXI_API_H
//--------------------------------------------------------------------
// Copyright (c) 2024 by Future Design Systems Co., Ltd.
// All right reserved.
//
// http://www.future-ds.com
//--------------------------------------------------------------------
// dma_axi_api.h
//--------------------------------------------------------------------
// VERSION = 2024.07.16.
//--------------------------------------------------------------------
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

extern int dma_axi_control( uint32_t *cnt ); // read control register
extern int dma_axi_enable ( int en, int ie );
extern int dma_axi_go     ( uint32_t dst
                          , uint32_t src
                          , uint32_t bnum
                          , uint32_t chunk
                          , int time_out // 0 for blocking
                          );
extern int dma_axi_clear  ( void ); // interrupt clear
				    //
/**
 * @brief Get all values of CSR.
 *
 * @return void
 */
void dma_axi_csr(void);
/**
 * @brief Set base (offset) address.
 *
 * @param offset offset address
 *
 * @return 0 on success, otherwise negative number.
 */
extern int dma_axi_set_addr( uint32_t offset );

/**
 * @brief Get base (offset) address.
 *
 * @return current base (offset) address.
 */
extern uint32_t dma_axi_get_addr( void );

#ifdef __cplusplus
}
#endif
//--------------------------------------------------------
// Revision History
//
// 2024.07.16: Start by Ando Ki (adki@future-ds.com)
//--------------------------------------------------------
#endif
