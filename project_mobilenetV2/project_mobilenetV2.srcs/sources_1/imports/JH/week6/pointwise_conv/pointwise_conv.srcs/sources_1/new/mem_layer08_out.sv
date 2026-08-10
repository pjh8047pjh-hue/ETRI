`timescale 1ns / 1ps

module mem_layer08_out #(
    // MAC이 마지막 누적에서 Q2.13으로 변환하므로 하위 16bit를 저장한다.
    // 하위 16bit로 표현 안 되는 값(오버플로)은 saturate 처리한다.
    parameter integer QUANT_LSB  = 0
)(
    input  logic                        clk,
    input  logic                        rst,

    // result_valid 한 pulse당 MAC 결과 한 개를 저장한다.
    input  logic                        start_w,
    input  logic signed [37:0]          dina,
    output logic                        done_w,

    // start_r 한 pulse로 주소 0부터 전체 결과를 순서대로 읽는다.
    input  logic                        start_r,
    output logic [15:0]                 data_out,
    output logic                        data_valid,
    output logic                        done_r
    );

    localparam integer ACC_WIDTH  = 38;
    localparam integer DATA_WIDTH = 16;
    localparam integer DEPTH      = pointwise_pkg::WEIGHT_WIDTH
                                  * pointwise_pkg::CHANNEL_WIDTH;
    localparam integer ADDR_WIDTH = $clog2(DEPTH);
    localparam logic [ADDR_WIDTH-1:0] LAST_ADDR = DEPTH - 1;

    logic [ADDR_WIDTH-1:0] wr_addr;
    logic [ADDR_WIDTH-1:0] rd_addr;
    logic                  reading;

    logic [DATA_WIDTH-1:0] quantized_data;
    logic [0:0]            wea;

    // dina[QUANT_LSB +: DATA_WIDTH]를 그대로 자르면 16bit로 안 들어가는 값은
    // 부호까지 랩어라운드된다. 상위 확장 비트가 전부 부호비트와 같을 때만
    // (=16bit로 표현 가능할 때만) 그대로 자르고, 아니면 saturate한다.
    localparam integer EXT_BITS = ACC_WIDTH - QUANT_LSB - DATA_WIDTH + 1;
    localparam logic signed [DATA_WIDTH-1:0] MAX = {1'b0, {(DATA_WIDTH-1){1'b1}}};
    localparam logic signed [DATA_WIDTH-1:0] MIN = {1'b1, {(DATA_WIDTH-1){1'b0}}};

    wire in_range = &(dina[ACC_WIDTH-1 -: EXT_BITS] ~^ {EXT_BITS{dina[ACC_WIDTH-1]}});

    always_comb begin
        if(in_range) begin
            quantized_data = dina[QUANT_LSB +: DATA_WIDTH];
        end else if(dina[ACC_WIDTH-1]) begin
            quantized_data = MIN;
        end else begin
            quantized_data = MAX;
        end
    end

    assign wea[0]          = start_w;

    // Block Memory Generator: Simple Dual Port RAM, 16-bit x 75,264.
    output_bram_ip output_bram_ip (
        .clka  (clk),
        .ena   (start_w),
        .wea   (wea),
        .addra (wr_addr),
        .dina  (quantized_data),
        .clkb  (clk),
        .enb   (reading),
        .addrb (rd_addr),
        .doutb (data_out)
    );

    // pointwise의 loop 순서가 pixel -> output channel이므로 저장 주소는
    // 순서대로 address = pix_cnt * WEIGHT_WIDTH + oc_cnt가 된다.
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_addr <= '0;
            done_w  <= 1'b0;
        end else begin
            done_w <= 1'b0;

            if (start_w) begin
                if (wr_addr == LAST_ADDR) begin
                    wr_addr <= '0;
                    done_w  <= 1'b1;
                end else begin
                    wr_addr <= wr_addr + 1'b1;
                end
            end
        end
    end

    // 전체 결과 read. data_valid는 읽는 각 cycle에, done_r은 마지막
    // data_out이 유효한 cycle에 각각 올라온다.
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_addr    <= '0;
            reading    <= 1'b0;
            data_valid <= 1'b0;
            done_r     <= 1'b0;
        end else begin
            data_valid <= reading;
            done_r     <= reading && (rd_addr == LAST_ADDR);

            if (start_r && !reading) begin
                rd_addr <= '0;
                reading <= 1'b1;
            end else if (reading) begin
                if (rd_addr == LAST_ADDR) begin
                    rd_addr <= '0;
                    reading <= 1'b0;
                end else begin
                    rd_addr <= rd_addr + 1'b1;
                end
            end
        end
    end

endmodule
