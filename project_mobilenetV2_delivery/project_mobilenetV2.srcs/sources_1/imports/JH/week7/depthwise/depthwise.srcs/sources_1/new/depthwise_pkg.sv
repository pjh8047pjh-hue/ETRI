`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/04 17:03:01
// Design Name: 
// Module Name: depthwise_pkg
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

package depthwise_pkg;

    parameter WEIGHT_LENGTH = 24576; // ?  ?  ?   24576 test?   50
    parameter WEIGHT_WIDTH  = 384; // ?  ?  ?   384  ?금 ? 5 weight [0~383][0~63][0]
    parameter CHANNEL_WIDTH = 196; // ?  ?  ?   196  ?금 ? 3 input  [0~ 63][0~13][0~13]
    parameter IN_CH = 64;
    // IN_CH 의 약수여야 한다. 1, 2, 4, 8, 16, 32, 64 만 유효.
    parameter PARALLEL_CH = 64;

endpackage : depthwise_pkg
