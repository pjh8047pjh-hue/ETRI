`timescale 1ns / 1ps

module mem_layer08_input_bram(
    input  logic                  clk,
    input  logic                  rst,

    // 이전 layer에서 1024-bit pixel vector를 한 개씩 적재한다.
    input  logic                  start_w,
    input  logic [pointwise_pkg::IN_CH*16-1:0] dina,
    output logic                  done_w,

    // pointwise FSM의 현재 pixel 주소를 읽는다.
    input  logic                  start_r,
    input  logic [$clog2(pointwise_pkg::CHANNEL_WIDTH)-1:0] pix_addr,
    output logic [pointwise_pkg::IN_CH*16-1:0] data_out,

    input  logic                  skip_rd_en,
    input  logic [$clog2(pointwise_pkg::CHANNEL_WIDTH)-1:0] skip_addr_a,
    input  logic [$clog2(pointwise_pkg::CHANNEL_WIDTH)-1:0] skip_addr_b,
    output logic [pointwise_pkg::IN_CH*16-1:0] skip_data_a,
    output logic [pointwise_pkg::IN_CH*16-1:0] skip_data_b
    );

    localparam integer DATA_WIDTH = pointwise_pkg::IN_CH * 16;
    localparam integer DEPTH      = pointwise_pkg::CHANNEL_WIDTH;
    localparam integer ADDR_WIDTH = $clog2(DEPTH);
    localparam logic [ADDR_WIDTH-1:0] LAST_ADDR = DEPTH - 1;

    logic [ADDR_WIDTH-1:0] wr_addr;
    logic [0:0]            wea;
    logic [DATA_WIDTH-1:0] port_b_data;

    assign wea[0] = start_w;

    // Block Memory Generator: True Dual Port RAM, 1024-bit x 196.
    input_bram_ip input_bram_ip (
        .clka  (clk),
        .ena   (start_w || skip_rd_en),
        .wea   (wea),
        .addra (start_w ? wr_addr : skip_addr_a),
        .dina  (dina),
        .douta (skip_data_a),
        .clkb  (clk),
        .enb   (start_r || skip_rd_en),
        .web   (1'b0),
        .addrb (skip_rd_en ? skip_addr_b : pix_addr),
        .dinb  ('0),
        .doutb (port_b_data)
    );

    assign data_out   = port_b_data;
    assign skip_data_b = port_b_data;

    // start_w가 들어오는 매 cycle마다 write 주소를 증가시킨다.
    // 전체 196개를 저장한 cycle에 done_w를 한 cycle pulse로 출력한다.
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

endmodule
