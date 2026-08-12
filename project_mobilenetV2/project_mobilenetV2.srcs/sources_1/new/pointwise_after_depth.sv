`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/12 11:12:43
// Design Name: 
// Module Name: pointwise_after_depth
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
// 64개의 dsp로 6 clk 동안 연산할 것. 6clk이 지나면 하나의 output channel 완성
//////////////////////////////////////////////////////////////////////////////////


module pointwise_after_depth(
    input  logic        clk,
    input  logic        rst,
    input  logic        start,
    input  logic [511:0] input_data,
    input  logic [511:0] weight_data,

    output logic        done,
    output logic signed [15:0] pointwise_after_depth_out
    );

    localparam PARALLEL_DSP = 64;
    localparam DATA_WIDTH   = 8;

    //------------------ 입력 count 로직 --------------------------

    logic [55:0] sum;
    logic [ 5:0] cnt;
    logic [ 2:0] ic_cnt;
    logic [ 3:0] delay_cnt;
    logic        input_done;

    assign input_done = enable_point && (cnt == 63) && (ic_cnt == 5);

    // 64번의 연산을 6clk 반복하면 384에 대한 output channel 1개가 나옴
    always_ff @(posedge clk) begin
        if(rst) begin
            cnt    <= '0;
            ic_cnt <= '0;
        end
        else if(enable_point) begin
            if(cnt == 63) begin
                cnt <= '0;
                if(ic_cnt == 5) ic_cnt <= '0;
                else ic_cnt <= ic_cnt + 1'b1;
            end
            else cnt <= cnt + 1'b1;
        end
    end
    //----------------------------------------------------------

    //------------------ 입력 count 로직 ------------------------
    logic [ 5:0] out_cnt;
    logic [ 2:0] out_ic_cnt;

    // 64번의 연산을 6clk 반복하면 384에 대한 output channel 1개가 나옴
    always_ff @(posedge clk) begin
        if(rst) begin
            out_cnt    <= 0;
            out_ic_cnt <= 0;
            done       <= 0;
        end
        else begin
            done <= 0;
            if(output_valid) begin
                if(out_cnt == 63) begin
                    out_ic_cnt <= '0;
                    if(out_ic_cnt == 5) begin
                        out_ic_cnt <= '0;
                        done       <=  1;
                    end
                    else out_ic_cnt <= out_ic_cnt + 1'b1;
                end
            end else out_cnt <= out_cnt + 1'b1;
        end
    end
    //--------------------------------------------------------

    //--------------------- enable logic ---------------------
    logic       enable_point;
    logic [7:0] weight_point [0:PARALLEL_DSP-1];
    logic [7:0] input_point  [0:PARALLEL_DSP-1];

    always_ff @(posedge clk) begin
        if(rst) enable_point <= 0;
        else if(start) enable_point <= 1;
        else if(input_done) enable_point <= 0;
    end
    //--------------------------------------------------------

    //--------------------- delay logic ----------------------
    // dsp에서 나오는 데 11 clk, adder tree 3clk = 14clk
    localparam TOTAL_LATENCY = 14;

    logic [TOTAL_LATENCY-1:0] valid_delay;
    logic                     output_valid;
    
    // enable_point가 들어오고 나서 total latency를 지나고 나서 output valid 신호를 띄움
    always_ff @(posedge clk) begin
        if(rst) valid_delay <= '0;
        else valid_delay <= {valid_delay[TOTAL_LATENCY-2:0], enable_point};
    end

    // 최상위 비트를 통해 output valid를 14clk 늦춤
    assign output_valid = valid_delay[TOTAL_LATENCY-1];
    //--------------------------------------------------------


    
    //-------------- DSP generate (MAC calculation) -----------------------------
    // 현재 weight, input 의 bit 수는 512.
    generate
        for(genvar i = 0; i < PARALLEL_DSP; i++) begin
            assign weight_point[i] = $signed(weight_data[i*DATA_WIDTH +: DATA_WIDTH]);
            assign  input_point[i] = $signed(input_data [i*DATA_WIDTH +: DATA_WIDTH]);
        end
    endgenerate
    
    //--------------------------------------------------------
    // dsp 출력까지 7 clk 걸림
    localparam NUM_GROUPS = 8;
    localparam GROUP_SIZE = 8;

    logic signed [47:0] pc_chain [0:NUM_GROUPS-1][0:6];
    logic signed [47:0] group_sum[0:NUM_GROUPS-1];

    generate
        for (genvar i = 0; i < NUM_GROUPS; i++) begin
            // Stage 0
            dsp48_first_point u_first (
                .CLK   (clk),
                .A     (input_point [i*GROUP_SIZE]),
                .B     (weight_point[i*GROUP_SIZE]),
                .P     (),
                .PCOUT (pc_chain[i][0])
            );

            // Stage 1~6
            for (genvar j = 1; j < 7; j++) begin
                dsp48_middle_point u_middle (
                    .CLK   (clk),
                    .A     (input_point [i*GROUP_SIZE+j]),
                    .B     (weight_point[i*GROUP_SIZE+j]),
                    .P     (),
                    .PCIN  (pc_chain[i][j-1]),
                    .PCOUT (pc_chain[i][j])
                );
            end

            // Stage 7
            dsp48_last_point u_last (
                .CLK  (clk),
                .A    (input_point [i*GROUP_SIZE+7]),
                .B    (weight_point[i*GROUP_SIZE+7]),
                .PCIN (pc_chain[i][6]),
                .P    (group_sum[i])
            );
        end
    endgenerate
    //----------------------------------------------------------



    // 타이밍을 안정적으로 잡기 위한 adder tree 사용
    //-------------------- adder tree -------------------------
    logic [48:0] adder_first_tree [0:3];
    logic [49:0] adder_second_tree[0:1];
    logic [50:0] adder_third_tree;

    always_ff @(posedge clk) begin
        if(rst) begin
            adder_first_tree  <= '0;
            adder_second_tree <= '0;
            adder_third_tree  <= '0;
        end
        else begin
            // adder tree 구조로 8 -> 4 -> 2 -> 1순으로 저장
            // DSP에서 각 8개마다 하나의 합으로 만들었기 때문에 8개의 총합이 나옴
            for(int f = 0; f < 4; f++) begin
                adder_first_tree[f] <= $signed(group_sum[2*f] + group_sum[2*f+1]);
            end
            
            // second adder tree
            adder_second_tree[0] <= $signed(adder_first_tree[0] + adder_first_tree[1]);
            adder_second_tree[1] <= $signed(adder_first_tree[2] + adder_first_tree[3]);

            // third  adder tree
            adder_third_tree <= $signed(adder_second_tree[0] + adder_second_tree[1]);
        end
    end

endmodule