`timescale 1ns / 1ps

module pointwise_mac(
    input  logic        clk,
    input  logic        rst,
    input  logic        en_mul,
    input  logic [ 5:0] ic_cnt,

    input  logic [pointwise_pkg::IN_CH*16-1:0] weight_data,
    input  logic [pointwise_pkg::IN_CH*16-1:0] input_data,

    output logic signed [37:0] result,
    output logic               result_valid
    );

    import pointwise_pkg::*;

    localparam integer INPUT_FRAC_BITS  = 12;
    localparam integer WEIGHT_FRAC_BITS = 12;
    localparam integer OUTPUT_FRAC_BITS = 12;
    localparam integer QUANT_SHIFT      = INPUT_FRAC_BITS
                                           + WEIGHT_FRAC_BITS
                                           - OUTPUT_FRAC_BITS;

    logic signed [15:0] weight [0:PARALLEL_CH-1];
    logic signed [15:0] input_d [0:PARALLEL_CH-1];
    logic signed [31:0] product [0:PARALLEL_CH-1];
    logic signed [37:0] product_sum;
    logic signed [37:0] accumulator;
    logic signed [37:0] final_sum;

    logic en_mul_d;
    logic first_d;
    logic last_d;

    // ic_cnt부터 PARALLEL_CH개 채널을 동시에 곱한다.
    generate
        for(genvar i = 0; i < PARALLEL_CH; i = i + 1) begin
            assign weight[i] = $signed(weight_data[(ic_cnt+i)*16 +: 16]);
            assign input_d[i] = $signed(input_data[(ic_cnt+i)*16 +: 16]);

            mult_gen_0 multiply(
                .CLK(clk),
                .A(weight[i]),
                .B(input_d[i]),
                .P(product[i])
                );
        end
    endgenerate

    // 같은 클럭에 계산한 병렬 곱셈 결과를 더한다.
    integer j;
    always_comb begin
        product_sum = 0;
        for(j = 0; j < PARALLEL_CH; j = j + 1)
            product_sum = product_sum + product[j];
    end

    // 마지막 product까지 포함한 Q28 누적값이다. PARALLEL_CH가 바뀌어
    // first와 last가 같은 cycle이 되더라도 첫 product를 중복해서 더하지 않는다.
    assign final_sum = first_d ? product_sum : accumulator + product_sum;

    // multiplier의 1클럭 지연에 맞춰 제어 신호도 1클럭 지연한다.
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            en_mul_d <= 0;
            first_d  <= 0;
            last_d   <= 0;
        end else begin
            en_mul_d <= en_mul;
            first_d  <= en_mul && (ic_cnt == 0);
            last_d   <= en_mul && (ic_cnt >= IN_CH - PARALLEL_CH);
        end
    end

    // 병렬 곱셈 결과를 채널 전체에 대해 누적한다.
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            accumulator  <= 0;
            result       <= 0;
            result_valid <= 0;
        end else begin
            result_valid <= 0;

            if(en_mul_d) begin
                if(first_d)
                    accumulator <= product_sum;
                else
                    accumulator <= accumulator + product_sum;

                if(last_d) begin
                    // input Q2.13 x weight Q1.15 = Q28. 모든 채널을 38bit로
                    // 먼저 누적한 뒤 마지막에만 15bit 산술 shift해 Q2.13으로
                    // 맞춘다. 반올림/포화 없이 하위 16bit가 출력 BRAM에 저장된다.
                    result       <= final_sum >>> QUANT_SHIFT;
                    result_valid <= 1;
                end
            end
        end
    end

endmodule
