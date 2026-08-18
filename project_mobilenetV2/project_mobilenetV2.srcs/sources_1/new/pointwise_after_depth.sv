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

module pointwise_after_depth #(
    parameter int RELU_UPPER = 6  // legacy compatibility only; Project output is linear
)(
    input  logic         clk,
    input  logic         rst,
    input  logic         first,
    input  logic         last_all,
    input  logic         last,

    input  logic [1023:0] input_data,
    input  logic [1023:0] weight_data,
    input  logic signed [ 31:0] bias_data,

    output logic        done,
    output logic        output_valid,
    output logic signed [15:0] pointwise_after_depth_out
    );

    localparam PARALLEL_DSP = 64;
    localparam DATA_WIDTH   = 16;
    localparam FRAC_BITS    = 12;

    //------------------- output delay logic ------------------
    // dsp에서 나오는 데 11 clk, adder tree 3clk = 14clk
    localparam TOTAL_LATENCY = 14;

    logic [TOTAL_LATENCY-1:0] first_output;
    logic [TOTAL_LATENCY-1:0] last_output;
    logic [TOTAL_LATENCY  :0] done_delay; // sum에서 한 클락 더 더하고 있으므로 마지막 input으로부터 15 clk 필요

    /* enable_point가 들어오고 나서 total latency를 지나고 나서 output valid 신호를 띄움
     64개 연산을 6clk 동안 저장하고 다음 채널을 연산할 때는 초기화 할 수 있도록 하는 것이 
     필요하기 때문에 처음과 마지막 신호를 알려줌
    */
    always_ff @(posedge clk) begin
        if(rst) begin
            first_output <= '0;
            last_output  <= '0;
            output_valid <= '0;
            done_delay   <= '0;
        end
        else begin
            first_output <= {first_output[TOTAL_LATENCY-2:0], first};
            last_output  <= {last_output [TOTAL_LATENCY-2:0], last};
            done_delay   <= {done_delay  [TOTAL_LATENCY-1:0], last_all};
            output_valid <= last_output[TOTAL_LATENCY-1]; // 최상위 비트를 통해 output valid를 14clk 늦춤
        end
    end

    assign done = done_delay[TOTAL_LATENCY];
    //--------------------------------------------------------  
    
    //-------------- DSP cascade 구성 -----------------------------
    // DSP 하나의 A/B -> P 지연은 4clk, PCIN -> P 지연은 1clk이다.
    // PCIN은 곱셈기를 안 거치므로 단이 하나 늘 때 붙는 건 PREG 1clk뿐이고,
    // 그래서 stage j는 stage j-1보다 1clk 뒤의 입력을 쓰게 된다.
    // 8단 캐스케이드 전체 지연 = 4 + 7 = 11 clk.
    localparam NUM_GROUPS   = 8;
    localparam GROUP_SIZE   = 8;

    //-------------- lane 슬라이싱 + input skew -------------------
    // Q3.12 16-bit lane 64개이므로 weight/input bus는 각각 1024-bit.
    // A/B를 전부 같은 clk에 넣으면 lane 0~7이 서로 다른 입력 워드의 곱을
    // 더하게 된다. lane j의 A/B를 j clk 늦춰 PCIN 도착 시점과 맞춘다.
    logic signed [DATA_WIDTH-1:0] weight_point [0:PARALLEL_DSP-1];
    logic signed [DATA_WIDTH-1:0] input_point  [0:PARALLEL_DSP-1];

    generate
        for(genvar i = 0; i < PARALLEL_DSP; i++) begin
            localparam int SKEW = (i % GROUP_SIZE);

            // 512-bit에서 이 lane 몫을 꺼낸다. 양쪽 분기가 같이 쓴다.
            logic signed [DATA_WIDTH-1:0] in_slice, wg_slice;
            assign in_slice = $signed(input_data [i*DATA_WIDTH +: DATA_WIDTH]);
            assign wg_slice = $signed(weight_data[i*DATA_WIDTH +: DATA_WIDTH]);

            if(SKEW == 0) begin
                // 캐스케이드의 시작 단이라 지연 없이 직결
                assign  input_point[i] = in_slice;
                assign weight_point[i] = wg_slice;
            end
            else begin
                logic signed [DATA_WIDTH-1:0] a_sr [0:SKEW-1];
                logic signed [DATA_WIDTH-1:0] b_sr [0:SKEW-1];

                always_ff @(posedge clk) begin
                    // 뒤 칸부터 한 칸씩 밀고, 새 값은 [0]으로 넣는다.
                    // SKEW==1이면 아래 for는 돌지 않고 [0] 대입만 남는다.
                    for (int k = SKEW-1; k > 0; k--) begin
                        a_sr[k] <= a_sr[k-1];
                        b_sr[k] <= b_sr[k-1];
                    end
                    a_sr[0] <= in_slice;
                    b_sr[0] <= wg_slice;
                end

                // 가장 오래된 칸이 SKEW clk 지연된 값이다
                assign  input_point[i] = a_sr[SKEW-1];
                assign weight_point[i] = b_sr[SKEW-1];
            end
        end
    endgenerate
    //----------------------------------------------------------

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
    logic signed [48:0] adder_first_tree [0:3];
    logic signed [49:0] adder_second_tree[0:1];
    logic signed [50:0] adder_third_tree;
    logic signed [50:0] sum; 

    always_ff @(posedge clk) begin
        if(rst) begin
            for(int f = 0; f < 4; f++) adder_first_tree[f]  <= '0;
            for(int s = 0; s < 2; s++) adder_second_tree[s] <= '0;
            adder_third_tree <= '0;
        end
        else begin
            // adder tree 구조로 8 -> 4 -> 2 -> 1순으로 저장
            // DSP에서 각 8개마다 하나의 합으로 만들었기 때문에 8개의 총합이 나옴
            for(int f = 0; f < 4; f++) begin
                adder_first_tree[f] <=
                    $signed({group_sum[2*f][47], group_sum[2*f]}) +
                    $signed({group_sum[2*f+1][47], group_sum[2*f+1]});
            end
            
            // second adder tree
            adder_second_tree[0] <=
                $signed({adder_first_tree[0][48], adder_first_tree[0]}) +
                $signed({adder_first_tree[1][48], adder_first_tree[1]});
            adder_second_tree[1] <=
                $signed({adder_first_tree[2][48], adder_first_tree[2]}) +
                $signed({adder_first_tree[3][48], adder_first_tree[3]});

            // third  adder tree
            adder_third_tree <=
                $signed({adder_second_tree[0][49], adder_second_tree[0]}) +
                $signed({adder_second_tree[1][49], adder_second_tree[1]});
        end
    end

    always_ff @(posedge clk) begin
        if(rst) sum <= '0;
        // first_output가 들어와서 시작할 때는 sum을 adder_third_tree의 값으로 초기화
        else if(first_output[TOTAL_LATENCY-1]) sum <= adder_third_tree;
        // 아닐 때에는 누적합 진행
        else sum <= $signed(sum + adder_third_tree);
    end

    wire signed [50:0] bias_extended = {{(51-32){bias_data[31]}}, bias_data};
    assign pointwise_after_depth_out = (sum + bias_extended) >>> FRAC_BITS;
    /*
    // Q3.12 x Q3.12 = Q24. bias_data도 Q24이므로 shift 전에 더한다.
    // Project convolution은 linear이므로 ReLU6를 적용하지 않는다.
    localparam logic signed [50:0] Q312_MAX = 51'sd32767;
    localparam logic signed [50:0] Q312_MIN = -51'sd32768;

    wire signed [50:0] biased_acc    = sum + bias_extended;
    wire signed [50:0] shifted_q312  = biased_acc >>> FRAC_BITS;

    always_comb begin
        if (!output_valid)
            pointwise_after_depth_out = '0;
        else if (shifted_q312 > Q312_MAX)
            pointwise_after_depth_out = 16'sh7fff;
        else if (shifted_q312 < Q312_MIN)
            pointwise_after_depth_out = 16'sh8000;
        else
            pointwise_after_depth_out = shifted_q312[15:0];
    end
    //----------------------------------------------------------
    */
endmodule
