`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/11 11:21:46
// Design Name: 
// Module Name: ReLU6_pw
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


module ReLU6_pw #(
    parameter DIN_W = 16,
    parameter int UPPER = 6
)(
    input  logic                    clk,
    input  logic                    rst,
    input  logic signed [DIN_W-1:0] din,

    output logic [15:0] data_out_relu
    );

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            data_out_relu <= 16'd0;
        end else if(din > UPPER) begin
            data_out_relu <= UPPER[15:0];
        end else if(din < 0) begin
            data_out_relu <= 16'd0;
        end else begin
            data_out_relu <= din[15:0];
        end
    end


//----------------------------- zero padding logic ----------------------------
  localparam int ROW_LEN = 15;
    
    logic [3:0] col_cnt;
    logic [3:0] row_cnt;
    logic       run_interconnect;
    logic       start_depth;
    
    logic [15:0] interconnect_data;

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            run_interconnect <= 1'b0;
            start_depth      <= 1'b0;
        end else begin
            start_depth <= 1'b0;
            if(output_data_valid && !run_interconnect) begin
                run_interconnect <= 1'b1;
                start_depth      <= 1'b1;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin   
            col_cnt <= 0;
            row_cnt <= 0;
        end else if(start_depth) begin
            col_cnt <= 0;
            row_cnt <= 0;
        end else if(run_interconnect) begin
            if(col_cnt == ROW_LEN-1) begin
                col_cnt <= 0;
                row_cnt <= (row_cnt == ROW_LEN-1) ? 4'd0 : row_cnt + 4'd1;
            end else begin
                col_cnt <= col_cnt + 4'd1;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            interconnect_data <= '0;
        end else if (row_cnt != 0 && row_cnt != 15) begin
                if (col_cnt != 0 && col_cnt != 15) begin
                    interconnect_data <= pointwise_data_out;
                end else begin
                    interconnect_data <= '0;
                end
        end else if(row_cnt == 0 || row_cnt == 15) begin
            interconnect_data <= '0;
        end 
    end
// -----------------------------------------------------------------------




endmodule
