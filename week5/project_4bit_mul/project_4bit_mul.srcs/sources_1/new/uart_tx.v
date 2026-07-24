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


module uart_tx(
    input       clk, rst_n,
    input       start,
    input [7:0] din,
    output reg  tx_data
    );
    
localparam ST_IDLE  = 2'b00,
		   ST_START = 2'b01,
           ST_DATA  = 2'b10,
		   ST_STOP  = 2'b11;

    reg [1:0] cstate;
    reg [1:0] nstate;
    reg [3:0] cnt = 4'd8;

    baudrate_gen baudrate_gen (.clk_in(clk), .rst_n(rst_n), .baud_tick(baud_tick));

    always @(*) begin
        if(!rst_n) begin
            cstate = ST_IDLE;
            nstate = ST_IDLE;
        end else begin
            cstate = nstate;
        end
    end

    always @(posedge baud_tick or negedge rst_n) begin
        case (cstate)
            ST_IDLE : begin
                if(start) begin
                    nstate <= ST_START;
                end
            end

            ST_START: begin
                nstate <= ST_DATA;
            end

            ST_DATA : begin
                if(cnt == 4'd8) begin
                    nstate <= ST_STOP;
                end
            end

            ST_STOP : begin
                nstate <= ST_IDLE;
            end

            default : nstate <= ST_IDLE;
        endcase
    end

    always @(posedge baud_tick or negedge rst_n) begin
        if(!rst_n)begin
            
        end else begin
            case (cstate)
                ST_IDLE : begin
                    cnt <= 4'd0;
                end

                ST_DATA: begin
                    if(cnt < 4'd8) begin
                        tx_data <= din[cnt];
                        cnt     <= cnt + 1'b1;
                    end
                end

                ST_START : begin
                    tx_data <= 1'b0;
                end

                ST_STOP : begin
                    tx_data <= 1'b1;
                    cnt     <= 4'd0;
                end
                default : cnt <= 4'd0;
            endcase
        end
    end
endmodule
