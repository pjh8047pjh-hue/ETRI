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

    import pointwise_pkg::*;

    localparam integer ACC_WIDTH  = 38;
    localparam integer DATA_WIDTH = 16;
    localparam integer DEPTH      = pointwise_pkg::WEIGHT_WIDTH
                                  * pointwise_pkg::CHANNEL_WIDTH;
    localparam integer ADDR_WIDTH = $clog2(DEPTH); // 75_264
    localparam logic [ADDR_WIDTH-1:0] LAST_ADDR = DEPTH - 1;

    logic [ADDR_WIDTH-1:0] wr_addr;
    logic [ADDR_WIDTH-1:0] rd_addr;
    logic                  reading;

    logic [DATA_WIDTH-1:0] quantized_data;
    logic [0:0]            wea;
    logic [15:0]           bram_data_out;
    logic                  bram_wr_en;
    logic [ADDR_WIDTH-1:0] bram_wr_addr;
    logic [DATA_WIDTH-1:0] bram_wr_data;

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

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            bram_wr_en   <= 1'b0;
            bram_wr_addr <= '0;
            bram_wr_data <= '0;
        end else begin
            bram_wr_en <= start_w;
            if (start_w) begin
                bram_wr_addr <= wr_addr;
                bram_wr_data <= quantized_data;
            end
        end
    end

    assign wea[0] = bram_wr_en;

    // Block Memory Generator: Simple Dual Port RAM, 16-bit x 75,264.
    output_bram_ip output_bram_ip (
        .clka  (clk),
        .ena   (bram_wr_en),
        .wea   (wea),
        .addra (bram_wr_addr),
        .dina  (bram_wr_data),
        .clkb  (clk),
        .enb   (reading),
        .addrb (rd_addr),
        .doutb (bram_data_out)
    );

    //----------------- write address logic --------------------------
    // New pointwise output order is output-channel outer / pixel inner.
    // It already matches the channel-major order used by the reader.
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

    localparam int ROW_LEN = 16;
    logic [3:0] rd_col_cnt;
    logic [3:0] rd_row_cnt;
    logic [8:0] rd_channel_cnt;

    // 14x14 데이터의 상/하/좌/우에 1칸씩 zero padding을 붙여 16x16으로 출력한다.
    wire real_slot = (rd_row_cnt >= 1) && (rd_row_cnt <= 14)
                  && (rd_col_cnt >= 1) && (rd_col_cnt <= 14);
    wire last_slot = reading
                  && (rd_channel_cnt == WEIGHT_WIDTH-1)
                  && (rd_row_cnt == ROW_LEN-1)
                  && (rd_col_cnt == ROW_LEN-1);
    
    logic real_slot_d1;
    logic real_slot_d2;
    logic reading_d1;
    logic reading_d2;
    logic last_slot_d1;
    logic last_slot_d2;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            real_slot_d1 <= 1'b0;
            real_slot_d2 <= 1'b0;
            reading_d1   <= 1'b0;
            reading_d2   <= 1'b0;
            last_slot_d1 <= 1'b0;
            last_slot_d2 <= 1'b0;
            data_valid   <= 1'b0;
            done_r       <= 1'b0;
        end else begin
            real_slot_d1 <= reading && real_slot;
            real_slot_d2 <= real_slot_d1;
            reading_d1   <= reading;
            reading_d2   <= reading_d1;
            last_slot_d1 <= last_slot;
            last_slot_d2 <= last_slot_d1;
            data_valid   <= reading_d2;
            done_r       <= last_slot_d2;
        end
    end

    assign data_out = real_slot_d2
                    ? bram_data_out
                    : 16'd0;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_addr    <= '0;
            reading    <= 1'b0;
        end else begin
            if (start_r && !reading) begin
                rd_addr <= '0;
                reading <= 1'b1;
            end else if (reading) begin
                if (last_slot) begin
                    rd_addr <= '0;
                    reading <= 1'b0;
                end else if (real_slot && (rd_addr != LAST_ADDR)) begin
                    rd_addr <= rd_addr + 1'b1;
                end
            end
        end
    end


//---------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if(rst || start_r) begin   
            rd_col_cnt     <= '0;
            rd_row_cnt     <= '0;
            rd_channel_cnt <= '0;
        end else if (reading) begin
            if (rd_col_cnt == ROW_LEN-1) begin
                rd_col_cnt <= '0;
                if (rd_row_cnt == ROW_LEN-1) begin
                    rd_row_cnt <= '0;
                    rd_channel_cnt <= (rd_channel_cnt == WEIGHT_WIDTH-1)
                                    ? '0 : rd_channel_cnt + 1'b1;
                end else begin
                    rd_row_cnt <= rd_row_cnt + 1'b1;
                end
            end else begin
                rd_col_cnt <= rd_col_cnt + 1'b1;
            end
        end
    end


endmodule
