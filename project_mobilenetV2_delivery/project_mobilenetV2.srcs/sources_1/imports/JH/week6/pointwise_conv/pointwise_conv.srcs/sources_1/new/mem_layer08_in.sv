`timescale 1ns / 1ps

module mem_weight_in(

    input  logic        clk,
    input  logic        start_r,
    input  logic [ 8:0] oc_cnt,

    output logic [pointwise_pkg::IN_CH*16-1:0] data_out
    );

    pointwise_weight pointwise_weight_rom1(.clka(clk),
                          .ena(start_r),
                          .douta(data_out),
                          .addra(oc_cnt)
                          );
endmodule
