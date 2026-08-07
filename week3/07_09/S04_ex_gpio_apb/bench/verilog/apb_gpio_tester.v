/*
 * Copyright (c) 2020 by Ando Ki.
 * All right reserved.
 *
 * http://www.future-ds.com
 * adki@future-ds.com
 *
 */
`timescale 1ns/1ns

module apb_gpio_tester #(
    parameter GPIO_WIDTH = 32
)(
    input  wire                  PRESETn,
    input  wire                  PCLK,
    output reg                   PSEL,
    output reg                   PENABLE,
    output reg  [31:0]           PADDR,
    output reg                   PWRITE,
    output reg  [31:0]           PWDATA,
    input  wire [31:0]           PRDATA,
    output reg  [GPIO_WIDTH-1:0] GPIO_I,
    input  wire [GPIO_WIDTH-1:0] GPIO_O,
    input  wire [GPIO_WIDTH-1:0] GPIO_T,
    input  wire                  IRQ
);
    localparam REG_LINE = 32'h04; // Line Register: 현재 GPIO 핀 level 또는 출력값 제어.
    localparam REG_CTRL = 32'h00; // Line Control Registor: 0이면 input, 1이면 output.
    localparam REG_MASK = 32'h08; // Interrupt Mask Register: interrupt 발생 여부.
    localparam REG_FLAG = 32'h0C; // Interrupt Flag: interrupt 발생 여부.
    localparam REG_EDGE = 32'h10; // Edge/Level Register: 0이면 level, 1이면 edge.
    localparam REG_POL  = 32'h14; // Polarity Register: level이면 low/high 선택, edge면 falling/rising 선택.


   `include "apb_tasks.v"

   reg [GPIO_WIDTH-1:0] rdata;

   initial begin
       @(posedge PRESETn); // reset 신호 대기
       repeat(2) @(posedge PCLK); // 안정화
       // write test
       apb_write(REG_CTRL, 3'd2, 32'h0000_0001);
       apb_write(REG_LINE, 3'd2, 32'h0000_0001);
       apb_write(REG_MASK, 3'd2, 32'h0000_0001);
       apb_write(REG_FLAG, 3'd2, 32'h0000_0000);
       apb_write(REG_EDGE, 3'd2, 32'h0000_0000);
       apb_write(REG_POL,  3'd2, 32'h0000_0000);

       repeat(2) @(posedge PCLK);

       // bit0(output)이 실제 GPIO_O 핀까지 나가는지 확인
       if (GPIO_O[0] !== 1'b1) $display("FAIL: GPIO_O[0] = %b (expected 1)", GPIO_O[0]);

       // bit0(output)은 구동, bit1(input)은 tristate인지 확인
       if (GPIO_T[0] !== 1'b0) $display("FAIL: GPIO_T[0] = %b (expected 0, driven)", GPIO_T[0]);
       if (GPIO_T[1] !== 1'b1) $display("FAIL: GPIO_T[1] = %b (expected 1, tristate)", GPIO_T[1]);

       // bit1(input)에 외부 값을 흘려주고 REG_LINE read가 GPIO_I를 그대로 반환하는지 확인
       GPIO_I[1] = 1'b1;
       repeat(2) @(posedge PCLK);
       apb_read(REG_LINE, 3'd2, rdata);
       if (rdata[1] !== 1'b1) $display("FAIL: REG_LINE bit1 (input passthrough) = %b (expected 1)", rdata[1]);

        // read test
        apb_read(REG_CTRL, 3'd2, rdata);
        if (rdata !== 32'h0000_0001) $display("FAIL: REG_CTRL = %h", rdata);

        apb_read(REG_LINE, 3'd2, rdata);
        if (rdata[0] !== 1'b1) $display("FAIL: REG_LINE bit0 = %h", rdata);

        apb_read(REG_MASK, 3'd2, rdata);
        if (rdata[0] !== 1'b1) $display("FAIL: REG_LINE bit0 = %h", rdata);

        apb_read(REG_FLAG, 3'd2, rdata);
        if (rdata[0] !== 1'b0) $display("FAIL: REG_LINE bit0 = %h", rdata);    
        
        apb_read(REG_EDGE, 3'd2, rdata);
        if (rdata[0] !== 1'b0) $display("FAIL: REG_LINE bit0 = %h", rdata);
        
        apb_read(REG_POL , 3'd2, rdata);
        if (rdata[0] !== 1'b0) $display("FAIL: REG_LINE bit0 = %h", rdata);

        $display("TEST DONE");
        $finish;
    end
endmodule
