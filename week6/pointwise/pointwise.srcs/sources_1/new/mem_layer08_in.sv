`timescale 1ns / 1ps

module mem_weight_in(

    input  logic        clk,
    input  logic        rst,
    input  logic        start_r,

    output logic [15:0] data_out,
    );

    import pointwise_pkg::*;

    localparam weight_offset = 384;

    logic [ 8:0] input_cnt;
    logic [15:0] addra;
    logic        ena;
    logic [ 1:0] rd_last;
    logic        input_last;      // input_cnt 가 마지막 값일 때만 1 (addra step enable)

    blk_mem_gen_0 single_port_rom(.clka(clk),
                                   .ena(ena),
                                   .douta(data_out),
                                   .addra(addra)
                                   );

    assign input_last = input_cnt == WEIGHT_WIDTH-1;

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            input_cnt <= 9'd0;
        end else if(start_r) begin
            input_cnt <= 9'd0;          // start 시엔 0 으로만, 펄스 안 만듦
        end else begin
            input_cnt <= input_last ? 9'd0 : input_cnt + 9'd1;
        end
    end

    // address logic
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin 
            addra <= 0;
        end else if(start_r) begin
            addra <= 16'd0;
        end else if(input_last) begin           // 196번 다 셌을 때만 진행
            if(addra == WEIGHT_LENGTH-1) begin  // wrap 을 최우선으로
                addra <= 16'd0;
            end else if(addra == WEIGHT_WIDTH) begin
                addra <= addra + weight_offset;
            end else begin
                addra <= addra + 16'd1;
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if(rst) ena <= 0;
        else if(start_r || input_last) ena <= 1;
        else if(ena) ena <= 0;
    end                
endmodule
