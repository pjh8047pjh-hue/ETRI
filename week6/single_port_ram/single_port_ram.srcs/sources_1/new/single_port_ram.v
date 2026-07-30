`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/28 09:55:43
// Design Name: 
// Module Name: single_port_ram
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


module single_port_ram(
    input wire clk,
    input wire rst, 
    input wire start,

    output wire [15:0] data_out,
    output reg done_w,
    output reg done_r
    );

    reg wea;
    reg ena;
    reg [ 9:0] addra;
    reg [15:0] dina;
    reg [ 1:0] rd_last;
    
    blk_mem_gen_0 ram(.clka(clk),
                     .ena(ena),
                     .douta(data_out),
                     .dina(dina),
                     .addra(addra),
                     .wea(wea)
                     );

    // write task 
    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            wea      <= 0;
            done_w   <= 0;
            dina     <= 16'd1;
        end else if(start == 1'b1) begin
            wea      <= 1'b1;
            dina     <= 16'd1;
            done_w   <= 0;    
        end else if(wea && ena && addra != 10'd99) begin
            dina     <= dina + 16'd1;
        end else if(wea && ena && addra == 10'd99) begin
            wea      <= 0;
            done_w   <= 1;
        end else if(addra == 0) begin
            done_w <= 0;
            dina   <= 0;
        end
    end


    // read task
 // addra==99 issued; wait one more clk for data_out (read latency 1)

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            done_r   <= 0;
            rd_last  <= 0;
        end else if(done_w == 1'b1) begin
            done_r   <= 0;
            rd_last  <= 2'b00;
        end else if(rd_last == 2'b10) begin
            done_r   <= 1;
            rd_last  <= 2'b00;
        end else if(!wea && addra == 10'd99 || rd_last == 2'b01) begin
            rd_last  <= rd_last + 2'b01;
        end else if(done_r) done_r <= 0;
    end

    always @(posedge clk or posedge rst) begin
        if(rst) ena <= 0;
        else if(start) ena <= 1;                          // write sweep begins
        else if(done_w) ena <= 1;                          // read sweep begins
        else if(rd_last == 2'b10) ena <= 0;                         // last read data is now available
    end

    always @(posedge clk or posedge rst) begin
        if(rst) addra <= 0;
        else if(start) addra <= 10'd0;
        else if(addra !== 10'd99 && ena) addra <= addra + 10'd1;
        else if(addra  == 10'd99 && !ena) addra <= 10'd0;
    end

endmodule
