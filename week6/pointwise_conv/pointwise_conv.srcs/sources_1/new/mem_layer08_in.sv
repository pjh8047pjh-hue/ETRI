`timescale 1ns / 1ps

module mem_weight_in(

    input  logic        clk,
    input  logic        start_r,
    input  logic [ 8:0] oc_cnt,

    output logic [pointwise_pkg::IN_CH*16-1:0] data_out
    );

    // Block Memory Generator ROM: 한 주소에 output channel 하나의
    // weight 64개(64 x 16bit = 1024bit)가 들어 있다.
    blk_mem_gen_0 single_port_rom(.clka(clk),
                                   .ena(start_r),
                                   .douta(data_out),
                                   .addra(oc_cnt)
                                   );
endmodule
