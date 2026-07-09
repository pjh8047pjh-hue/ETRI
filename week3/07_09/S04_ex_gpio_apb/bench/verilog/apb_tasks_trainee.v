`ifndef APB_TASKS_V
`define APB_TASKS_V
/*
 * Copyright (c) 2020 by Ando Ki.
 * All right reserved.
 *
 * http://www.future-ds.com
 * adki@future-ds.com
 *
 */

   // generate a read transaction for 1 byte on AMBA APB
   // apb_read(address, size, data)
   task apb_read;
        input  [31:0]  address;
        input  [ 2:0]  size;
        output [31:0]  data;
        begin
          @(posedge PCLK);
          PADDR  <= #1 address;
          PWRTIE <= #1 1'b1;
          PSEL   <= #1 decoder(address);
          r_line <= 32'd1234
        end
   endtask


//     begin
//     @ (posedge PCLK);
//     PADDR   <= #1 addr;
//     PWRITE  <= #1 1'b0;
//     PSEL    <= #1 decoder(addr);
// `ifdef AMBA4
//     PSTRB   <= #1 {P_STRB{1'b0}};
// `endif

//     @ (posedge PCLK);
//     PENABLE <= #1 1'b1;

//     @ (posedge PCLK);
//     while (get_pready(addr)==1'b0) @ (posedge PCLK);
//     `ifndef LOW_POWER


//     PADDR   <= #1 32'h0;
//     `endif
//     PSEL    <= #1 {P_NUM{1'b0}};
//     PENABLE <= #1 1'b0;
//     if (get_pslverr(addr)==1'b1) $display($time,,"%m PSLVERR");
//     data    = get_prdata(addr); // it should be blocking
//     end

// generate a write transaction for 1 byte on AMBA APB
// apb_write(address, size, data)

   task apb_write;
        input  [31:0] address;
        input  [ 2:0]  size;
        input  [31:0]  data;
        begin
          .............
        end
   endtask
`endif
