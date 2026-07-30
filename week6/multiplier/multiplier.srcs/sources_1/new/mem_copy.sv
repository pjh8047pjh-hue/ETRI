`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/29 10:46:20
// Design Name: 
// Module Name: mem_copy
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


module mem_copy(
    input  logic clk,
    input  logic rst,
    input  logic start,

    output logic done_w,
    output logic done_c,
    output logic done_r,
    output logic [15:0] data_out
    );
    
    logic [15:0] data_mem1_out1;

    logic done_r_mem1;
    logic done_w_delay;
    /*
    true_dual_port_mem1 mem1(.clk(clk),
                            .rst(rst),
                            .start_w(start_w),
                            .start_r(start_r),
                            .dina(dina),
                            .dinb(dinb),
                            .data_out1(data_mem1_out1),
                            .data_out2(data_mem1_out2),
                            .done_w(done_w_mem1),
                            .done_r(done_r_mem1)
                            );
    
    true_dual_port_mem2 mem2(.clk(clk),
                            .rst(rst),
                            .start_w(start_w),
                            .start_r(start_r),                        
                            .dina(data_mem1_out1),
                            .dinb(data_mem1_out2),
                            .data_out1(data_mem2_out1),
                            .data_out2(data_mem2_out2),
                            .done_w(done_w),
                            .done_r(done_r)
                            );
    */
// memory1 ---> memory2 : row, column conversion

    simple_dual_ram1 mem1(.clk(clk),
                         .rst(rst),
                         .start_w(start),
                         .start_r(done_w),
                         .data_out(data_mem1_out1),
                         .done_w(done_w),
                         .done_r(done_r_mem1)
                        );

    always_ff @(posedge clk or posedge rst) begin
        if(rst) done_w_delay <= 1'b0;
        else    done_w_delay <= done_w;
    end

    simple_dual_ram2 mem2(.clk(clk),
                         .rst(rst),
                         .start_w(done_w_delay),
                         .start_r(done_c),
                         .dina(data_mem1_out1),
                         .data_out(data_out),
                         .done_w(done_c),
                         .done_r(done_r)
                        );
    
endmodule
