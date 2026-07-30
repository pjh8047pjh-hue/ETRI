`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/30 12:48:20
// Design Name: 
// Module Name: pointwise_pkg
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

package pointwise_pkg;

    parameter WEIGHT_LENGTH = 24576; // ?��?��?�� 24576 test?�� 50
    parameter WEIGHT_WIDTH  = 384; // ?��?��?�� 384 �?금�? 5 weight [0~383][0~63][0]
    parameter CHANNEL_WIDTH = 196; // ?��?��?�� 196 �?금�? 3 input  [0~ 63][0~13][0~13]
    parameter MUL_DELAY     = 2;

endpackage : pointwise_pkg
