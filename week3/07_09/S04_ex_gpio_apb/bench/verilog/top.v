
`timescale 1ns/1ns

`ifndef CLK_FREQ
`define CLK_FREQ       50000000
`endif

module top ;
   //--------------------------------------------------------
   localparam GPIO_WIDTH = 32;

    reg                   PRESETn = 1'b0;
    reg                   PCLK = 1'b0;
    wire                  PSEL;
    wire                  PENABLE;
    wire [31:0]           PADDR;
    wire                  PWRITE;
    wire [31:0]           PWDATA;
    wire [31:0]          PRDATA;
    wire [GPIO_WIDTH-1:0] GPIO_I;
    wire [GPIO_WIDTH-1:0] GPIO_O;
    wire [GPIO_WIDTH-1:0] GPIO_T;
    wire                  IRQ;
   //--------------------------------------------------------
   apb_gpio_tester #(.GPIO_WIDTH(GPIO_WIDTH))
   u_tester (
            .PRESETn (PRESETn)
          , .PCLK    (PCLK)
          , .PSEL    (PSEL)
          , .PADDR   (PADDR)
          , .PENABLE (PENABLE)
          , .PWRITE  (PWRITE)
          , .PWDATA  (PWDATA)
          , .PRDATA  (PRDATA)
          , .GPIO_I  (GPIO_I)
          , .GPIO_O  (GPIO_O)
          , .GPIO_T  (GPIO_T)
          , .IRQ     (IRQ)
   );
   //--------------------------------------------------------
   gpio_apb #(.GPIO_WIDTH(GPIO_WIDTH))
   u_gpio (
            .PRESETn (PRESETn)
          , .PCLK    (PCLK)
          , .PSEL    (PSEL)
          , .PADDR   (PADDR)
          , .PENABLE (PENABLE)
          , .PWRITE  (PWRITE)
          , .PWDATA  (PWDATA)
          , .PRDATA  (PRDATA)
          , .GPIO_I  (GPIO_I)
          , .GPIO_O  (GPIO_O)
          , .GPIO_T  (GPIO_T)
          , .IRQ     (IRQ)
   );

   //-----------------------------------------------------
   localparam CLK_FREQ=`CLK_FREQ;
   localparam CLK_PERIOD_HALF=1000000000/(CLK_FREQ*2);
   //-----------------------------------------------------
   always #CLK_PERIOD_HALF PCLK <= ~PCLK;
   //-----------------------------------------------------
   real stamp_x, stamp_y, delta;
   initial begin
       PRESETn <= 1'b0;
       repeat (5) @ (posedge PCLK);
       `ifdef RIGOR
        @ (posedge PCLK);
        @ (posedge PCLK); stamp_x = $time;
        @ (posedge PCLK); stamp_y = $time; delta = stamp_y - stamp_x;
        @ (negedge PCLK); $display("%m PCLK %f nsec %f Mhz", delta, 1000.0/delta);
       `endif
       repeat (5) @ (posedge PCLK);
       PRESETn <= 1'b1;
   end
   //------------------------------------------------
   `ifdef VCD
   initial begin
       $dumpfile("wave.vcd");
       $dumpvars(0);
   end
   `endif
endmodule