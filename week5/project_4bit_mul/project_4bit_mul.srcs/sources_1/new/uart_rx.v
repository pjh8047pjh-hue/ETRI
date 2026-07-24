`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/03 16:29:30
// Design Name: 
// Module Name: uart_tx
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


module uart_rx #(
    parameter WIDTH = 8,
    parameter CHUNK = 4
)
(
    input           baud_clk, rst_n,
    input 		  		rx_data,
		output reg			rx_done,
    output reg    [7:0] dout
    );

	localparam ST_IDLE  = 2'b00,
			ST_DATA  = 2'b01,
			ST_DONE  = 2'b11;

	reg [1:0] cstate;
	reg [1:0] nstate;
	reg [3:0] cnt = 4'd0;

	// current state logic
	always @(posedge baud_clk or negedge rst_n) begin
		if(!rst_n) begin
			cstate <= ST_IDLE;
			nstate <= ST_IDLE;
		end else begin
			cstate <= nstate;
		end
	end

	// next state logic
	always @(*) begin
		case (cstate)
			ST_IDLE: begin
				if(rx_data == 1'b0) begin
					nstate = ST_DATA;
				end else begin
					nstate = ST_IDLE;
				end
			end

			ST_DATA: begin
				if(cnt == 4'd8) begin
					nstate = ST_DONE;
				end else begin
					nstate = ST_DATA;
				end
			end

			ST_DONE: begin
				nstate = ST_IDLE;
			end

			default: nstate = ST_IDLE;
		endcase
	end

	// output logic
	always @(posedge baud_clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt	   <= 4'd0;
		end else begin
			case (cstate)
				ST_IDLE: begin
					dout    <= 8'd0;
					cnt     <= 4'd0;
					rx_done <= 1'b0;
				end
				ST_DATA: begin
					dout [cnt] <= rx_data;
					cnt		   <= cnt + 1;
				end

				ST_DONE: begin
					cnt     <= 4'd0;
					rx_done <= 1'b1;

				end
				default: rx_done <= 1'b0;
			endcase	
		end
	end

endmodule