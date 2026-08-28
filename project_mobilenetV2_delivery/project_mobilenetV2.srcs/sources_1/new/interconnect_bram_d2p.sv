`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2026 09:49:04 AM
// Design Name: 
// Module Name: interconnect_bram_d2p
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


module interconnect_bram_d2p(
    input  logic                clk,
    input  logic                rst,
    input  logic                start,
    input  logic signed [  7:0] wr_data,
    input  logic                wr_valid,
    input  logic        [ 10:0] input_rd_addr,
    input  logic                input_rd_en,

    output logic signed [511:0] input_rd_data,
    output logic                write_done
);

/* 
    relu 6가 끝나고 8비트 데이터가 들어옴. 그런데 한 addr에 512 bit가 써져야 함
    그래서 wr_addr과 함께 wr_lane값을 받아서 처음으로 나온 값부터 0~63 lane으로 저장
    이렇게 하면 512 bit를 한 addr에 저장 가능
    -> BRAM이 read, write width, depth가 비대칭이라서 발생한 문제

    1. depthwise의 연산 순서를 고려해서 저장해야 함
    -> 주소가 한 번 연산하고 나서 다음 픽셀로 넘어가야 됨
    -> 14*14의 addr를 증가시켜서 196번째가 되는 순간 wr_lane이 1 증가
    -> channel은 384, addr은 196이 될 때까지만 write 이후는 x
    -> 그런데 pointwise에 친화적으로 데이터를 저장해야 함. 들어올 때는 8 bit씩, 나갈 때는 
    512 bit 씩 나가기 때문에 저장할 때 wr_lane 사용해서 저장 총 8bit 씩 64개의 그룹을 만들어
    512 bit를 저장해서 한 chunk를 부를 때 한 번에 픽셀의 64channel 값이 나가도록 설계
        주소 수  = 6 chunk × 196 pixel = 1,176
        lane 수  = 64
        전체 값  = 1,176 × 64 = 75,264
*/
    
    localparam int PIXEL = 196;
    localparam int CHUNK = 6;    // 384ch / 64lane
    localparam int LANE  = 64;

    logic [   10:0] wr_addr;
    logic [    5:0] wr_lane;
    logic [    7:0] wr_pixel_cnt;    // 0~195
    logic [    8:0] wr_channel_cnt;  // 0~383
    logic [LANE-1:0] wr_wea;

    //----------- index calculator --------------------
    always_ff @(posedge clk) begin
        if (rst || start) begin
            wr_pixel_cnt   <= '0;
            wr_channel_cnt <= '0;
            write_done     <=  0;
        end else begin
            write_done <= 0;

            if(wr_valid) begin
                if(wr_pixel_cnt == 195) begin
                    wr_pixel_cnt <= '0;

                    if(wr_channel_cnt == 383) begin
                        wr_channel_cnt <= '0;
                        write_done     <= 1;
                    end else begin
                        wr_channel_cnt <= wr_channel_cnt + 1'b1;
                    end
                end else begin
                    wr_pixel_cnt <= wr_pixel_cnt + 1'b1;
                end
            end
        end
    end

    // wr_channel_cnt[8:6] = channel / 64 -> chunk
    // wr_channel_cnt[5:0] = channel % 64 -> lane
    // 주소 배치는 top_pointwise_after_depth 의 input_rd_addr 과 반드시 동일해야 함
    //   top : input_rd_addr = pixel_cnt * CHUNK + chunk_cnt   (pixel-major)
    assign wr_addr = wr_pixel_cnt * CHUNK + wr_channel_cnt[8:6];
    assign wr_lane = wr_channel_cnt[5:0];

    // 실제로 메모리에서 바뀌는 건 wr_lane 이 가리키는 8bit 한 칸뿐.
    // dina 는 512bit 전체를 요구하므로 같은 값을 복제해두고 wea 가 골라가게 함.
    always_comb begin
        wr_wea           = '0;
        wr_wea[wr_lane]  = 1'b1;   // one-hot decoder
    end

    wire [8*LANE-1:0] wr_dina = {LANE{wr_data}};

    pointwise_after_depth_input u_in (
        // 쓰기 (depthwise 붙일 때 연결)
        .clka (clk),
        .ena  (wr_valid),
        .wea  (wr_wea),
        .addra(wr_addr),
        .dina (wr_dina),
        // 읽기
        .clkb (clk),
        .enb  (input_rd_en),
        .addrb(input_rd_addr),
        .doutb(input_rd_data)
    );

endmodule
