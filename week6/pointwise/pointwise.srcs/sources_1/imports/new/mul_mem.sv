`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/29 15:34:30
// Design Name: 
// Module Name: mul_mem
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


module 
    
    (

    input  logic        clk,
    input  logic        rst,
    input  logic        start_w,
    input  logic        start_r,
    input  logic [15:0] dina,

    output logic [15:0] data_out,
    output logic        done_w,
    output logic        done_r
    );

    logic [ 6:0] addra;
    logic [ 6:0] addrb;
    logic        wea;
    logic        ena;
    logic        enb;
    logic [ 1:0] rd_last;
    
    blk_mem_gen_0 simple_dual_ram(.clka(clk),
                                   .clkb(clk),
                                   .ena(ena),
                                   .enb(enb),
                                   .doutb(data_out),
                                   .dina(dina),
                                   .addra(addra),
                                   .addrb(addrb),
                                   .wea(wea)  
                                   );
                            
    // write
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin 
            wea      <= 0;
            done_w   <= 0;
        end else if(start_w == 1'b1) begin
            wea      <= 1'b1;
            done_w   <= 0;    
        end else if(wea && addra == 7'd71) begin
            wea      <= 0;
            done_w   <= 1;
        end else if(done_w) begin
            done_w   <= 0;
        end
    end

    // read task
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            done_r   <= 0;
            rd_last  <= 0;
        end else if(start_r == 1'b1) begin
            done_r   <= 0;
            rd_last  <= 2'b00;
        end else if(rd_last == 2'b10) begin
            done_r   <= 1;
            rd_last  <= 2'b00;
        end else if((enb && !wea && addrb == 7'd71) || rd_last == 2'b01) begin
            rd_last  <= rd_last + 2'b01;
        end else if(done_r) done_r <= 0;
    end

    // address logic
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin 
            addra <= 0;
        end
        else if(start_w) addra <= 7'd0;
        else if(addra !== 7'd71 &&  ena) addra <= addra + 7'd1;
        else if(addra  == 7'd71 && !ena) addra <= 7'd0;
        
        if(rst) begin
            addrb <= 0;
        end
        else if(start_r) addrb <= 7'd0;
        else if(addrb !== 7'd71 &&  enb) addrb <= addrb + 7'd1;
        else if(addrb  == 7'd71 && !enb) addrb <= 7'd0;
    end


    // enable logic
    always_ff @(posedge clk or posedge rst) begin
        if(rst) ena <= 0;
        else if(start_w) ena <= 1;
        else if(!wea) ena <= 0;
    end

    always_ff @(posedge clk or posedge rst) begin
        if(rst) enb <= 0;
        else if(start_r) enb <= 1;
        else if(rd_last == 2'b10) enb <= 0;
    end                

endmodule