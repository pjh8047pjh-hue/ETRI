`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/01 13:18:57
// Design Name: 
// Module Name: clock_down_counter
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


module clock_down_counter(
    input clk, rst, start,
    input [3:0] num, // 입력으로 숫자를 줄 것
    output reg dout, done
    );
    
    parameter ST_IDLE = 2'b00, ST_W1 = 2'b01, ST_W0 = 2'b10, ST_DONE = 2'b11;
    reg [1:0] cstate, nstate;
    reg [3:0] len, cnt; // len는 지금 출력할 1의 개수, cnt는 입력 받은 num을 저장하고 1씩 줄어드는 역할
    
    //curennt state logic
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) cstate <= ST_IDLE;
        else cstate <= nstate;
    end
    
    // next state logic : blocking
    always @(*) begin
        case (cstate) 
            ST_IDLE : begin // IDLE 상태 시작
                if (start) nstate = ST_W1; // start 신호가 들어오면 ST_W1으로 넘어감 (1 출력)
                else nstate = ST_IDLE; // 그 어느 값도 아닐 경우 IDLE 상태로 복귀
            end

            ST_W1 : begin // 1을 출력하는 상태
                if (len > 1) nstate = ST_W1;
                else if (len == 1 && cnt != 1) nstate = ST_W0;
                else if (len == 1 && cnt == 1) nstate = ST_DONE;
            end                            
            
            ST_W0 : begin
                nstate = ST_W1;
            end
            
            ST_DONE : begin
                nstate = ST_IDLE;
            end
            default : nstate = ST_IDLE;
        endcase
    end      

    // 데이터 패스 : non-blocking
    always @(posedge clk) begin
        if (start) begin
            cnt <= num;
            len <= num; 
        
        end

        case (cstate)
            ST_IDLE : begin
                dout <= 0;
                done <= 0;
            end

            ST_W1 : begin
                dout <= 1'b1;
                done <= 1'b0;
                if (len == 1) len <= 1;
                else len <= len - 1;
            end    

            ST_W0 : begin                
                dout <= 1'b0;
                done <= 1'b0;
                if (cnt == 0) cnt <= 0;
                else begin
                    len <= cnt - 1; 
                    cnt <= cnt - 1;
                end
            end

            ST_DONE : begin
                dout <= 1'b0;
                done <= 1'b1;
            end
        endcase
    end
            
            
            
            
endmodule
