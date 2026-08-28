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
    input  logic [13:0] result_addr,

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
    wire               clk_locked;

    // AXI GPIO drives rst/start in the 100 MHz PL clock domain while the
    // accelerator runs from the Clock Wizard output.  Keep the asynchronous
    // boundary local to these two synchronizer chains instead of distributing
    // the GPIO outputs directly to the whole 450 MHz design.
    (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *) logic [1:0] rst_sync_ff;
    (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *) logic [1:0] start_sync_ff;
    logic rst_core;
    logic start_core;
    logic start_sync_seen;

    clk_wiz_0 clk_gen(.clk_in1(clk_in),
                  .locked(clk_locked),
                  .clk_out1(clk)
                  );

    // Lock loss asserts the local reset immediately.  Software rst/start are
    // sampled as levels, so an AXI GPIO write held for one 100 MHz cycle is
    // visible for several accelerator clocks and cannot be missed.
    always_ff @(posedge clk or negedge clk_locked) begin
        if (!clk_locked) begin
            rst_sync_ff   <= 2'b11;
            start_sync_ff <= 2'b00;
        end else begin
            rst_sync_ff <= {rst_sync_ff[0], rst};

            if (rst_sync_ff[1])
                start_sync_ff <= 2'b00;
            else
                start_sync_ff <= {start_sync_ff[0], start};
        end
    end

    // These third-stage registers are intentionally outside the ASYNC_REG
    // chains so Vivado may replicate them to handle the large core fanout.
    // AXI GPIO writes are levels and can last many core clocks; convert the
    // synchronized start level into exactly one core-clock pulse so repeated
    // start cannot repeatedly clear the accelerator's internal counters.
    always_ff @(posedge clk or negedge clk_locked) begin
        if (!clk_locked) begin
            rst_core        <= 1'b1;
            start_core      <= 1'b0;
            start_sync_seen <= 1'b0;
        end else begin
            rst_core <= rst_sync_ff[1];

            if (rst_sync_ff[1]) begin
                start_core <= 1'b0;
                start_sync_seen <= 1'b0;
            end else begin
                start_core      <= start_sync_ff[1] && !start_sync_seen;
                start_sync_seen <= start_sync_ff[1];
            end
        end
    end

    //------------------- pointwise before depthwise ----------------------
    mem_layer08_input_bram u_pointwise_input (
        .clk       (clk),
        .rst       (rst_core),
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
        .rst                         (rst_core),
        .start                       (start_core),
        .input_rd_data               (pointwise_input_rd_data),
        .input_rd_addr               (pointwise_input_rd_addr),
        .input_rd_en                 (pointwise_input_rd_en),
        .done                        (pointwise_before_depth_done),
        .output_valid                (pointwise_before_depth_valid),
        .pointwise_before_depth_out  (pointwise_before_depth_out)
    );

    // PW1 now emits a gap-free channel-pair-major 16x16 padded stream.
    logic pointwise_before_depth_valid_d;

    always_ff @(posedge clk or posedge rst_core) begin
        if (rst_core)
            pointwise_before_depth_valid_d <= 1'b0;
        else
            pointwise_before_depth_valid_d <= pointwise_before_depth_valid;
    end

    assign start_depth = pointwise_before_depth_valid
                      && !pointwise_before_depth_valid_d;

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
        .rst          (rst_core),
        .start        (start_depth),
        .input_data   (pointwise_before_depth_out),
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
        .rst(rst_core),
        .start(start_core),
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
        .rst(rst_core),
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
        .done(),
        .output_valid(pointwise_after_depth_valid),
        .pointwise_after_depth_out(pointwise_after_depth_out_full)
    );

    // Store all 64 output channels x 196 pixels. During calculation the
    // single port performs sequential writes; afterward it serves PS reads.
    localparam logic [13:0] RESULT_LAST_ADDR = 14'd12543;
    logic [13:0] result_wr_addr;
    (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *) logic [13:0] result_addr_sync_ff;
    logic [13:0] result_addr_core;
    logic [15:0] result_ram_dout;
    logic signed [15:0] result_write_data;
    logic               result_write_valid;
    logic        results_ready;
    logic [15:0] debug_cycle_counter;
    logic        debug_start_seen;
    logic        debug_pw1_valid_seen;
    logic        debug_pw1_done_seen;
    logic        debug_depth_valid_seen;
    logic        debug_write_done_seen;
    logic        debug_pw2_valid_seen;
    logic [15:0] debug_status;

    always_ff @(posedge clk) begin
        if (rst_core) begin
            result_addr_sync_ff <= '0;
            result_addr_core    <= '0;
        end else begin
            result_addr_sync_ff <= result_addr;
            result_addr_core    <= result_addr_sync_ff;
        end
    end

    // Register the PW2 result before the final BRAM data input.
    always_ff @(posedge clk) begin
        if (rst_core || start_core) begin
            result_write_data  <= '0;
            result_write_valid <= 1'b0;
        end else begin
            result_write_valid <= pointwise_after_depth_valid;
            if (pointwise_after_depth_valid)
                result_write_data <= pointwise_after_depth_out_full;
        end
    end

    always_ff @(posedge clk) begin
        if (rst_core || start_core) begin
            result_wr_addr <= '0;
            results_ready  <= 1'b0;
        end else if (result_write_valid && !results_ready) begin
            if (result_wr_addr == RESULT_LAST_ADDR)
                results_ready <= 1'b1;
            else
                result_wr_addr <= result_wr_addr + 1'b1;
        end
    end

    // The four addresses above the 12,544-entry result range are read-only
    // hardware diagnostic pages. They make a board-side timeout distinguishable
    // without an ILA and do not alter any normal result address.
    always_ff @(posedge clk) begin
        if (rst_core) begin
            debug_cycle_counter    <= '0;
            debug_start_seen       <= 1'b0;
            debug_pw1_valid_seen   <= 1'b0;
            debug_pw1_done_seen    <= 1'b0;
            debug_depth_valid_seen <= 1'b0;
            debug_write_done_seen  <= 1'b0;
            debug_pw2_valid_seen   <= 1'b0;
        end else begin
            debug_cycle_counter <= debug_cycle_counter + 1'b1;
            if (start_core)
                debug_start_seen <= 1'b1;
            if (pointwise_before_depth_valid)
                debug_pw1_valid_seen <= 1'b1;
            if (pointwise_before_depth_done)
                debug_pw1_done_seen <= 1'b1;
            if (depthwise_output_valid)
                debug_depth_valid_seen <= 1'b1;
            if (write_done)
                debug_write_done_seen <= 1'b1;
            if (pointwise_after_depth_valid)
                debug_pw2_valid_seen <= 1'b1;
        end
    end

    assign debug_status = {
        clk_locked,                       // 15
        rst_core,                         // 14
        start_sync_ff[1],                 // 13
        debug_start_seen,                 // 12
        pointwise_before_depth_valid,     // 11
        debug_pw1_valid_seen,             // 10
        pointwise_before_depth_done,      // 9
        debug_pw1_done_seen,              // 8
        depthwise_output_valid,           // 7
        debug_depth_valid_seen,           // 6
        write_done,                       // 5
        debug_write_done_seen,            // 4
        pointwise_after_depth_valid,      // 3
        debug_pw2_valid_seen,             // 2
        result_write_valid,               // 1
        results_ready                     // 0
    };

    layer08_result_final u_layer08_result_final (
        .clka  (clk),
        .ena   ((result_write_valid && !results_ready) || results_ready),
        .wea   (result_write_valid && !results_ready),
        .addra ((result_write_valid && !results_ready)
                ? result_wr_addr : result_addr_core),
        .dina  (result_write_data),
        .douta (result_ram_dout)
    );

    assign done = results_ready;
    assign result = (result_addr_core == 14'h3fff) ? debug_status
                  : (result_addr_core == 14'h3ffe) ? {2'b00, result_wr_addr}
                  : (result_addr_core == 14'h3ffd) ? debug_cycle_counter
                  : (result_addr_core == 14'h3ffc) ? 16'hd108
                  : result_ram_dout;

    //-----------------------------------------------------------------

endmodule
