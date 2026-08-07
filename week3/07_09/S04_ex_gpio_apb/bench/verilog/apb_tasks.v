`ifndef APB_TASKS_V
`define APB_TASKS_V

   // generate a read transaction for 1 byte on AMBA APB
   // apb_read(address, size, data)
   task apb_read;
        input  [31:0]  address;
        input  [ 2:0]  size;
        output [31:0]  data;
        begin
          @(posedge PCLK);
          PADDR   <= #1 address;
          PWRITE  <= #1 1'b0;
          PSEL    <= #1 1'b1;
          PENABLE <= #1 1'b0;

          @(posedge PCLK);
          PADDR   <= #1 32'h0;
          PSEL    <= #1 1'b0;
          PWDATA  <= #1 32'h0;

          @(posedge PCLK);
          data = PRDATA;
          end
   endtask

// generate a write transaction for 1 byte on AMBA APB
// apb_write(address, size, data)

   task apb_write;
        input  [31:0] address;
        input  [ 2:0]  size;
        input  [31:0]  data;
        begin
          @(posedge PCLK);
          PADDR   <= #1 address;
          PWRITE  <= #1 1'b1;
          PSEL    <= #1 1'b1;
          PWDATA  <= #1 data;
          PENABLE <= #1 1'b0; //set up phase

          @(posedge PCLK)
          PENABLE <= #1 1'b1; // access phase

          @(posedge PCLK);
          PADDR   <= #1 32'h0;
          PWRITE  <= #1 1'b0;
          PSEL    <= #1 1'b0;
          PWDATA  <= #1 32'h0;
          PENABLE <= #1 1'b0;
          end
    endtask
`endif
