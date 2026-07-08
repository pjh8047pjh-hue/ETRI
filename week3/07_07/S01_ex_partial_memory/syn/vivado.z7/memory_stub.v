// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Tue Jul  7 10:32:59 2026
// Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub memory_stub.v
// Design      : memory
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module memory(clk, en, we, add, din, dout)
/* synthesis syn_black_box black_box_pad_pin="clk,en,we,add[9:0],din[7:0],dout[7:0]" */;
  input clk;
  input en;
  input we;
  input [9:0]add;
  input [7:0]din;
  output [7:0]dout;
endmodule
