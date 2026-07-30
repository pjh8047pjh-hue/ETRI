`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/28 16:56:55
// Design Name: 
// Module Name: true_dual_port
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module true_dual_port(
    input logic clk,
    input logic rst, 
    input logic start_w,
    input logic start_r,

    output logic [15:0] data_out1,
    output logic [15:0] data_out2,
    output logic done_w,
    output logic done_r
    );

    bit           wea;
    bit           web;
    bit           ena;
    bit           enb;

    logic [ 1:0] done_wa;
    logic [ 1:0] done_wb;
    logic [ 1:0] done_ra;
    logic [ 1:0] done_rb;
    logic [ 6:0] addra;
    logic [ 6:0] addrb;
    logic [15:0] dina;
    logic [15:0] dinb;
    logic [ 1:0] rd_last_a;
    logic [ 1:0] rd_last_b;

    logic [15:0] douta_i;
    logic [15:0] doutb_i;

    assign data_out1 = wea ? 16'd0 : douta_i;
    assign data_out2 = web ? 16'd0 : doutb_i;

    // address logic-------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            addra <= 7'd0;
        end
        else if(start_w) addra <= 7'd0;
        else if(start_r) addra <= 7'd0;
        else if(addra !== 7'd49 &&  ena) addra <= addra + 7'd1;
        else if(addra  == 7'd49 && !ena) addra <= 7'd0;
        
        if(rst) begin
            addrb <= 7'd50;
        end
        else if(start_w) addra <= 7'd0;
        else if(start_r) addrb <= 7'd50;
        else if(addrb !== 7'd99 &&  enb) addrb <= addrb + 7'd1;
        else if(addrb  == 7'd99 && !enb) addrb <= 7'd50;
    end
    //---------------------------------------------------------------

    // done_w--------------------------------------------------------
    always_comb begin
        if(rst) done_w = 0;
        else if(done_wa + done_wb == 2'b10) done_w = 1;
        else done_w = 0;
    end
    //---------------------------------------------------------------


    // done_r--------------------------------------------------------
    always_comb begin
        if(rst) done_r = 0;
        else if(done_ra + done_rb == 2'b10) done_r = 1;
        else done_r = 0;
    end
    //---------------------------------------------------------------


    blk_mem_gen_1 true_duarl_ram(.clka(clk),
                                 .clkb(clk),
                                 .ena(ena),
                                 .enb(enb),
                                 .douta(douta_i),
                                 .doutb(doutb_i),
                                 .dina(dina),
                                 .dinb(dinb),
                                 .addra(addra),
                                 .addrb(addrb),
                                 .wea(wea),
                                 .web(web)
                                 );


    // BRAM port A write
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin 
            wea      <= 0;
            done_wa  <= 0;
            dina     <= 16'd1;
        end else if(start_w == 1'b1) begin
            wea      <= 1'b1;
            dina     <= 16'd1;
            done_wa  <= 0;    
        end else if(wea && addra != 7'd49) begin
            dina     <= dina + 16'd1;
        end else if(wea && addra == 7'd49) begin
            wea      <= 0;
            done_wa  <= 1'b1;
        end else if(done_w) begin
            done_wa  <= 1'b0;
            dina     <= 0;
        end
    end

    // BRAM port A read task
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            done_ra   <= 0;
            rd_last_a <= 0;
        end else if(start_r == 1'b1) begin
            done_ra   <= 0;
            rd_last_a <= 2'b00;
        end else if(rd_last_a == 2'b10) begin
            done_ra   <= 1'b1;
            rd_last_a <= 2'b00;
        end else if(ena && !wea && addra == 7'd49 || rd_last_a == 2'b01) begin
            rd_last_a <= rd_last_a + 2'b01;
        end else if(done_ra) done_ra <= 0;
    end

    // port a enable logic
    always @(posedge clk or posedge rst) begin
        if(rst) ena <= 0;
        else if(start_w) ena <= 1;
        else if(start_r) ena <= 1;
        else if(wea && addra == 7'd49) ena <= 0;
        else if(rd_last_a == 2'b10) ena <= 0;
    end

//----------------------------------------------------------------
    // BRAM port B write
    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            web      <= 0;
            done_wb  <= 0;
            dinb     <= 16'd51;
        end else if(start_w == 1'b1) begin
            web      <= 1'b1;
            dinb     <= 16'd51;
            done_wb  <= 0;    
        end else if(web && addrb != 7'd99) begin
            dinb     <= dinb + 16'd1;
        end else if(web && addrb == 7'd99) begin
            web      <= 0;
            done_wb  <= 1'b1;
        end else if(done_w) begin
            done_wb  <= 1'b0;
            dinb     <= 0;
        end
    end

    // BRAM port B read task
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            done_rb   <= 0;
            rd_last_b <= 0;
        end else if(start_r == 1'b1) begin
            done_rb   <= 0;
            rd_last_b <= 2'b00;
        end else if(rd_last_b == 2'b10) begin
            done_rb   <= 1'b1;
            rd_last_b <= 2'b00;
        end else if(enb && !web && addrb == 7'd99 || rd_last_b == 2'b01) begin
            rd_last_b <= rd_last_b + 2'b01;
        end else if(done_rb) done_rb <= 0;
    end

    // port b enable logic
    always @(posedge clk or posedge rst) begin
        if(rst) enb <= 0;
        else if(start_w) enb <= 1;
        else if(start_r) enb <= 1;
        else if(web && addrb == 7'd99) enb <= 0;
        else if(rd_last_b == 2'b10) enb <= 0;
    end

//----------------------------------------------------------------

   
endmodule  