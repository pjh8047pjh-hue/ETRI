//--------------------------------------------------------
// Copyright (c) 2020 by Ando Ki.
// All right reserved.
//
// http://www.future-ds.com
// adki@future-ds.com
//--------------------------------------------------------
// mem_apb.h
//--------------------------------------------------------
// VERSION = 2020.07.11.
//--------------------------------------------------------
// Macros and parameters:
//     SIZE_IN_BYTES: Size of memory in bytes
//     DELAY:         The number of clocks until PREADY
//--------------------------------------------------------
`ifdef AMBA_APB4
`ifndef AMBA_APB3
ERROR AMBA_APB3 shouldb edefined when AMBA_APB4 is defined
`endif
`endif

module mem_apb
     #(parameter SIZE_IN_BYTES=1024  // memory size in bytes
               , DELAY=0           ) // access delay if any for AMBA_APB3/AMBA_APB4
(
     ... ...
);
    //----------------------------------------------------
    ... ...
    //----------------------------------------------------
endmodule

//--------------------------------------------------------
// Revision history
//
// 2020.07.11: Started by Ando Ki (adki@future-ds.com)
//--------------------------------------------------------
