`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/07 14:56:23
// Design Name: 
// Module Name: mobilenetV2
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


module mobilenetV2(
    input  logic        clk_in,
    input  logic        rst,
    input  logic        start,

    output logic        done,
    output logic [15:0] result
    );

    wire        start_depth;

    wire        pointwise_input_rd_en;
    wire [7:0]  pointwise_input_rd_addr;
    wire signed [1023:0] pointwise_input_rd_data;
    wire        skip_rd_en;
    wire [7:0]  skip_rd_addr_even, skip_rd_addr_odd;
    wire signed [1023:0] skip_bram_data_even, skip_bram_data_odd;

    wire signed [31:0] pointwise_before_depth_out;
    wire               pointwise_before_depth_valid;
    wire               pointwise_before_depth_done;
    wire               clk;
    
    logic [3:0]         pw_prefill_cnt;
    wire                pw_depth_start = pointwise_before_depth_valid && (pw_prefill_cnt == 4'd8);

    always_ff @(posedge clk or posedge rst) begin
        if (rst || pointwise_before_depth_done) pw_prefill_cnt <= '0;
        else if (pointwise_before_depth_valid && pw_prefill_cnt < 4'd9) pw_prefill_cnt <= pw_prefill_cnt + 1'b1;
    end

    wire        pointwise_buffer_write_done;
    wire [31:0] pointwise_padded_out;
    wire        pointwise_padded_valid;
    wire        pointwise_padded_done;

    wire signed [37:0] pointwise_before_depth_even_ext =
        {{22{pointwise_before_depth_out[15]}}, pointwise_before_depth_out[15:0]};
    wire signed [37:0] pointwise_before_depth_odd_ext =
        {{22{pointwise_before_depth_out[31]}}, pointwise_before_depth_out[31:16]};

    clk_wiz_0 clk_gen(.clk_in1(clk_in),
                  .locked(),
                  .clk_out1(clk)
                  );

    //------------------- pointwise before depthwise ----------------------
    mem_layer08_input_bram u_pointwise_input (
        .clk       (clk),
        .rst       (rst),
        .start_w   (1'b0),
        .dina      ('0),
        .done_w    (),
        .start_r   (pointwise_input_rd_en),
        .pix_addr  (pointwise_input_rd_addr),
        .data_out  (pointwise_input_rd_data),
        .skip_rd_en(skip_rd_en),
        .skip_addr_a(skip_rd_addr_even),
        .skip_addr_b(skip_rd_addr_odd),
        .skip_data_a(skip_bram_data_even),
        .skip_data_b(skip_bram_data_odd)
    );

    top_pointwise_before_depth u_pointwise_before_depth (
        .clk                         (clk),
        .rst                         (rst),
        .start                       (start),
        .input_rd_data               (pointwise_input_rd_data),
        .input_rd_addr               (pointwise_input_rd_addr),
        .input_rd_en                 (pointwise_input_rd_en),
        .done                        (pointwise_before_depth_done),
        .output_valid                (pointwise_before_depth_valid),
        .pointwise_before_depth_out  (pointwise_before_depth_out)
    );

    mem_layer08_out #(
        .QUANT_LSB (0)
    ) u_pointwise_output (
        .clk        (clk),
        .rst        (rst),
        .start_w    (pointwise_before_depth_valid),
        .dina_even  (pointwise_before_depth_even_ext),
        .dina_odd   (pointwise_before_depth_odd_ext),
        .done_w     (pointwise_buffer_write_done),
        .start_r    (pw_depth_start),
        .data_out   (pointwise_padded_out),
        .data_valid (pointwise_padded_valid),
        .done_r     (pointwise_padded_done)
    );
    //----------------------------------------------------

    // Pointwise output is channel-major 14x14. Buffer it and insert a
    // one-pixel zero border before starting the 16x16 depthwise stream.

    logic pointwise_padded_valid_d;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            pointwise_padded_valid_d <= 1'b0;
        else
            pointwise_padded_valid_d <= pointwise_padded_valid;
    end

    assign start_depth = pointwise_padded_valid && !pointwise_padded_valid_d;

    //------------------- depthwise ---------------------
    // depth_mac에서 bias add와 ReLU6까지 처리된 결과가 출력된다.
    wire signed [31:0] depthwise_data_out;
    wire               depthwise_output_valid;
    wire               pointwise_after_depth_valid;

    depth_top #(
        .SP         (16),
        .DW         (16)
    ) depthwise(
        .clk          (clk),
        .rst          (rst),
        .start        (start_depth),
        .input_data   (pointwise_padded_out),
        .depth_output_valid (depthwise_output_valid),
        .data_out     (depthwise_data_out)
    );
 //------------------- interconnect bram ---------------------
    wire  [ 10:0] input_rd_addr_a, input_rd_addr_b;
    wire  [1023:0] input_rd_data_a, input_rd_data_b;
    wire          input_rd_en;
    wire          write_done;
    wire signed [15:0] pointwise_after_depth_out_full;
    
    // BRAM은 Q3.12 16-bit lane 64개를 한 word(1024-bit)로 저장한다.
    interconnect_bram_d2p bram_d2p(
        .clk(clk),
        .rst(rst),
        .start(start),
        .wr_data(depthwise_data_out),
        .wr_valid(depthwise_output_valid),
        .input_rd_addr_a(input_rd_addr_a),
        .input_rd_addr_b(input_rd_addr_b),
        .input_rd_en(input_rd_en),
        .input_rd_data_a(input_rd_data_a),
        .input_rd_data_b(input_rd_data_b),
        .write_done(write_done)
    );
    //------------------- pointwise after depthwise ---------------------

    top_pointwise_after_depth pad(
    // input  logic         clk_in,
        .clk(clk),
        .rst(rst),
        .start(write_done),
        .depth_relu_data(depthwise_data_out),
        .depth_relu_valid(depthwise_output_valid),
        .input_rd_data_a(input_rd_data_a),
        .input_rd_data_b(input_rd_data_b),
        .skip_bram_data_even(skip_bram_data_even),
        .skip_bram_data_odd(skip_bram_data_odd),
        .input_rd_addr_a(input_rd_addr_a),
        .input_rd_addr_b(input_rd_addr_b),
        .input_rd_en(input_rd_en),
        .skip_rd_addr_even(skip_rd_addr_even),
        .skip_rd_addr_odd(skip_rd_addr_odd),
        .skip_rd_en(skip_rd_en),
        .done(done),
        .output_valid(pointwise_after_depth_valid),
        .pointwise_after_depth_out(pointwise_after_depth_out_full)
    );

    assign result = pointwise_after_depth_out_full;

    //-----------------------------------------------------------------

endmodule
