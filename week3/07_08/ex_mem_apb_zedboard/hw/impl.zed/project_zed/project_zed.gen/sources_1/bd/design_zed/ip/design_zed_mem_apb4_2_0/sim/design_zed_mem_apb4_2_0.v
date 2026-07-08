// (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:mem_apb4:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_zed_mem_apb4_2_0 (
  PRESETn,
  PCLK,
  S_APB_PSEL,
  S_APB_PENABLE,
  S_APB_PADDR,
  S_APB_PWRITE,
  S_APB_PWDATA,
  S_APB_PRDATA,
  S_APB_PREADY,
  S_APB_PSLVERR,
  S_APB_PSTRB
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME PRESETn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 PRESETn RST" *)
input wire PRESETn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME PCLK, ASSOCIATED_RESET PRESETn, ASSOCIATED_BUSIF S_APB, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PCLK CLK" *)
input wire PCLK;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSEL" *)
input wire S_APB_PSEL;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PENABLE" *)
input wire S_APB_PENABLE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PADDR" *)
input wire [31 : 0] S_APB_PADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWRITE" *)
input wire S_APB_PWRITE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWDATA" *)
input wire [31 : 0] S_APB_PWDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PRDATA" *)
output wire [31 : 0] S_APB_PRDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PREADY" *)
output wire S_APB_PREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSLVERR" *)
output wire S_APB_PSLVERR;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_APB, ASSOCIATED_BUSIF S_APB, ASSOCIATED_RESET PRESETn" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSTRB" *)
input wire [3 : 0] S_APB_PSTRB;

  mem_apb4 #(
    .SIZE_IN_BYTES(1024),
    .DELAY(0)
  ) inst (
    .PRESETn(PRESETn),
    .PCLK(PCLK),
    .S_APB_PSEL(S_APB_PSEL),
    .S_APB_PENABLE(S_APB_PENABLE),
    .S_APB_PADDR(S_APB_PADDR),
    .S_APB_PWRITE(S_APB_PWRITE),
    .S_APB_PWDATA(S_APB_PWDATA),
    .S_APB_PRDATA(S_APB_PRDATA),
    .S_APB_PREADY(S_APB_PREADY),
    .S_APB_PSLVERR(S_APB_PSLVERR),
    .S_APB_PSTRB(S_APB_PSTRB)
  );
endmodule
