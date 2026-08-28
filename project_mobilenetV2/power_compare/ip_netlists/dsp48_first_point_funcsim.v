// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Aug 24 12:48:17 2026
// Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/user/Documents/JH/project_mobilenetV2/power_compare/ip_netlists/dsp48_first_point_funcsim.v
// Design      : dsp48_first_point
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu3eg-sbva484-1-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dsp48_first_point,xbip_dsp48_macro_v3_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_18,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module dsp48_first_point
   (CLK,
    A,
    B,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCOUT;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "1" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "0" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "0" *) 
  (* C_HAS_CARRYIN = "0" *) 
  (* C_HAS_CARRYOUT = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_CEA = "0" *) 
  (* C_HAS_CEB = "0" *) 
  (* C_HAS_CEC = "0" *) 
  (* C_HAS_CECONCAT = "0" *) 
  (* C_HAS_CED = "0" *) 
  (* C_HAS_CEM = "0" *) 
  (* C_HAS_CEP = "0" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "0" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000100100000010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "31" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  dsp48_first_point_xbip_dsp48_macro_v3_0_18 U0
       (.A(A),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B(B),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_U0_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYOUT(NLW_U0_CARRYOUT_UNCONNECTED),
        .CE(1'b1),
        .CEA(1'b1),
        .CEA1(1'b1),
        .CEA2(1'b1),
        .CEA3(1'b1),
        .CEA4(1'b1),
        .CEB(1'b1),
        .CEB1(1'b1),
        .CEB2(1'b1),
        .CEB3(1'b1),
        .CEB4(1'b1),
        .CEC(1'b1),
        .CEC1(1'b1),
        .CEC2(1'b1),
        .CEC3(1'b1),
        .CEC4(1'b1),
        .CEC5(1'b1),
        .CECONCAT(1'b1),
        .CECONCAT3(1'b1),
        .CECONCAT4(1'b1),
        .CECONCAT5(1'b1),
        .CED(1'b1),
        .CED1(1'b1),
        .CED2(1'b1),
        .CED3(1'b1),
        .CEM(1'b1),
        .CEP(1'b1),
        .CESEL(1'b1),
        .CESEL1(1'b1),
        .CESEL2(1'b1),
        .CESEL3(1'b1),
        .CESEL4(1'b1),
        .CESEL5(1'b1),
        .CLK(CLK),
        .CONCAT({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(PCOUT),
        .SCLR(1'b0),
        .SCLRA(1'b0),
        .SCLRB(1'b0),
        .SCLRC(1'b0),
        .SCLRCONCAT(1'b0),
        .SCLRD(1'b0),
        .SCLRM(1'b0),
        .SCLRP(1'b0),
        .SCLRSEL(1'b0),
        .SEL(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
RjBOnpqHtHSn7Th98eHEXvWyBHe3T/gX1ti9+oK+DEEpXjYJihGx5qABFhKaZ7HnG7jWsuBRgFTw
VE0K5T9mAw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
AD8tLEblaOjB+faGHLQIkzbrG4aM6nCBT8dcD81Iun3SQOUijB8ABDIg5lEYH5K3EeksCSGHki8g
OvxbLFTgjliJBLxLsx+ia51eHHbkDhVrKKZyRVjuRNVWUvpPqSQue0dt1m+8vXZ8EbDTFu57FQES
ftptMOmvCz4P45+upgw=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Dd31zkgUgmtbPfI+NIw7WlVAEr8tSKWNShbB1sHb/DVoeVc7e1sPES4YIchOZKIfybkZs4GbQZzu
7p0DR6LJViMcpdkP8L6fqfNzF1OhTLtyiyODjmJKVbEn9K3WIpfx3cKfr6NLVyyNtOZfkBdGi5Ju
yPztYIemvy4+HBXWlBIbtGcnfXdNFt6Od4zR7R7/HusvUvKc/AGqJmz7S3809B2hCVf4LcEqkDzC
l8O/4DarStZq7ROZLBUD+boey+5aS2clMyo0UHdNPvD6k+zdaj8GrnfawU2PU/hDlhDX4CeV6VAR
YUnkfC0yC72QCfwlKJ4gUttkmO+HsgYJkC+aOg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QhWl9RMPJdD/ZzRR8EMwTgTNuPOKRQrQFdbwGVDvZKtpMwRqT9R3LfVWtbQcz8WGEhjsrZdTQ2Tt
VXYvZIIO7sMT53lhA3efDgr1bk94sKVKucYzrMdSlvkj44xuzeTUMsmVRrIVvGGtMytti17Vm1/W
vosV75seV2FQGB2C4rv4he7Cogzs2UePX7lT3jCmXP0VH7iWZUx7ew5GrP2Lte6VI+nAr6bYcgvE
vgA3qG2GsLNZpxxVVGWNesA3GqSc+PIUB2xPr00h4vrrgYxO428jrUtnAR5wwUZw9W152bGVgIX8
xZau1x+uZ3yzQTazm9yu6t4ME2PBCwXVz17jDw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jpkTKe1I/bpe85OESn4XWlnPzxPg7qI9WIaK5XaiGGBGixYLwRzLlNkUzErN03b7oqURMr88K5M4
jNn2+jzz9HmzWdP0ZGKTlhrW6Sdko4T714+/bxB2IR+v5vpPzrpnI50QFbCjIFmAS+RzojYfVaSs
9AwUQ1qyecUtyzkjygo=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FnnZEWGd+W7GPfbxXNmL25gL5GeM4EahuG6OQnjnqdruSkYjP2R/neKgChYgKz0laVTQyyADbUGE
HLaB3cP6Mshm6TnsnznSYK3MYY8w1lwyPLH2P3S29O1EOQLfDNE4m3G3ihbblMd78y/8SmJiycPk
go89UvGCQbKY9DEXc1lfc/kIKXgMkB/CNdD4PkOcSDb4YH1FlP8KteLdVDv12i1cLvqCVQYiZIvr
bPu0MglEawi5DZttyhu7zb5dLJqPtl5YpEeYPpnAKqKQ0+SJhzfzjc9wrtkT7vf0NhK8OwYDgbp7
wX8Dma61ADq291MJDKSyxgY2OiH7zkhHt9mvdA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
k9ONE6V8cDPlTUs5hhzMJIw+J7u2toMV3xjrlyeyXlJat41nqtoIXMfKe4BvqchMuefafW9o2L9r
11s6BZl20Y69RcOU0WetH72qfd7/7Kpp+ikXD+VrFWxzhaZufypkPXMtQGr98S0nR5j7y1TFJIJd
qDRH1OuRhVjJcgd9KVnrtLm9mT/oJOOeiqPMHaqf6aQFna+ZSigYPN/QMMnTMfSsdJQLmLWo6Z4/
lAS0efB4bdfMEzg55uYjJstVlH6jQr/CRM+9L6IkMoFxPYHNWqS7LsPs/zw78SU/JnA3/cVvx7Wy
RzBFiRvPRFB7x6tSNas53jhf6lVanpPxpin40A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NJ3AewbGy/1b3Q7grl6l3g8U/DqAzeMvF0M/rx3LiqYv/mBQyl3As83UPy99ReUtnyfJP3CLmF9r
4i+XbKr4we6uYQcjbnhylwEw56pFm7SGXVTq5roiDHSotdKqcr33xTDX+9/auKrJUcx1Lf5rScgw
m0oxolc2QVL1yT4tMLK/R4C/mdARmD1Jhf7hKfUOIKi/xNXzXcqfBPU3jQ9AuZW8aTM0nILtH3XA
ZHBcPwZv41mguaikMmdwlA0v5KQ4jHbnOftBLuEpvG4KDiFFgCVN0rxTp3ObmKYNi0n/sIdyXwyu
xJkurQJKLU+73OaQuBjToZKkK8Hi7opi24E4eA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
J9x89Uvo6pGaqNI/JxQkXmn17BeLNJdHi40iwXG4XmigXrbTK8r0txxMjDZPf7lGcor6U/li1IgB
zqsF3jG03OqOjPVxJz3ymVNO2uLbm6Xefy/o5XhmwVZIwmxxNRtZfSeFXJDcLqJ1FEOUpKjWZc9w
u1v+F+g4pKLsoQOSnFRGnaRfLErIqY+NuyhvRJXNncy5oAd3mY1c66jcpNLqMMjIFG4OXxB+NeYi
XGI6+jt4apOfng5+RGiJVzA88WHZIlLzqgXaKg2TpgBxodNUl7nCUIADd8EgIGdiLaX3GC+IKIB2
1UO+CctB6E21VKAqU74VG0lD/p93HxBKnKjD1g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9248)
`pragma protect data_block
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
KdrHaNgkkBw+w/NDko8=
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
RjBOnpqHtHSn7Th98eHEXvWyBHe3T/gX1ti9+oK+DEEpXjYJihGx5qABFhKaZ7HnG7jWsuBRgFTw
VE0K5T9mAw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
AD8tLEblaOjB+faGHLQIkzbrG4aM6nCBT8dcD81Iun3SQOUijB8ABDIg5lEYH5K3EeksCSGHki8g
OvxbLFTgjliJBLxLsx+ia51eHHbkDhVrKKZyRVjuRNVWUvpPqSQue0dt1m+8vXZ8EbDTFu57FQES
ftptMOmvCz4P45+upgw=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Dd31zkgUgmtbPfI+NIw7WlVAEr8tSKWNShbB1sHb/DVoeVc7e1sPES4YIchOZKIfybkZs4GbQZzu
7p0DR6LJViMcpdkP8L6fqfNzF1OhTLtyiyODjmJKVbEn9K3WIpfx3cKfr6NLVyyNtOZfkBdGi5Ju
yPztYIemvy4+HBXWlBIbtGcnfXdNFt6Od4zR7R7/HusvUvKc/AGqJmz7S3809B2hCVf4LcEqkDzC
l8O/4DarStZq7ROZLBUD+boey+5aS2clMyo0UHdNPvD6k+zdaj8GrnfawU2PU/hDlhDX4CeV6VAR
YUnkfC0yC72QCfwlKJ4gUttkmO+HsgYJkC+aOg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QhWl9RMPJdD/ZzRR8EMwTgTNuPOKRQrQFdbwGVDvZKtpMwRqT9R3LfVWtbQcz8WGEhjsrZdTQ2Tt
VXYvZIIO7sMT53lhA3efDgr1bk94sKVKucYzrMdSlvkj44xuzeTUMsmVRrIVvGGtMytti17Vm1/W
vosV75seV2FQGB2C4rv4he7Cogzs2UePX7lT3jCmXP0VH7iWZUx7ew5GrP2Lte6VI+nAr6bYcgvE
vgA3qG2GsLNZpxxVVGWNesA3GqSc+PIUB2xPr00h4vrrgYxO428jrUtnAR5wwUZw9W152bGVgIX8
xZau1x+uZ3yzQTazm9yu6t4ME2PBCwXVz17jDw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jpkTKe1I/bpe85OESn4XWlnPzxPg7qI9WIaK5XaiGGBGixYLwRzLlNkUzErN03b7oqURMr88K5M4
jNn2+jzz9HmzWdP0ZGKTlhrW6Sdko4T714+/bxB2IR+v5vpPzrpnI50QFbCjIFmAS+RzojYfVaSs
9AwUQ1qyecUtyzkjygo=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FnnZEWGd+W7GPfbxXNmL25gL5GeM4EahuG6OQnjnqdruSkYjP2R/neKgChYgKz0laVTQyyADbUGE
HLaB3cP6Mshm6TnsnznSYK3MYY8w1lwyPLH2P3S29O1EOQLfDNE4m3G3ihbblMd78y/8SmJiycPk
go89UvGCQbKY9DEXc1lfc/kIKXgMkB/CNdD4PkOcSDb4YH1FlP8KteLdVDv12i1cLvqCVQYiZIvr
bPu0MglEawi5DZttyhu7zb5dLJqPtl5YpEeYPpnAKqKQ0+SJhzfzjc9wrtkT7vf0NhK8OwYDgbp7
wX8Dma61ADq291MJDKSyxgY2OiH7zkhHt9mvdA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
k9ONE6V8cDPlTUs5hhzMJIw+J7u2toMV3xjrlyeyXlJat41nqtoIXMfKe4BvqchMuefafW9o2L9r
11s6BZl20Y69RcOU0WetH72qfd7/7Kpp+ikXD+VrFWxzhaZufypkPXMtQGr98S0nR5j7y1TFJIJd
qDRH1OuRhVjJcgd9KVnrtLm9mT/oJOOeiqPMHaqf6aQFna+ZSigYPN/QMMnTMfSsdJQLmLWo6Z4/
lAS0efB4bdfMEzg55uYjJstVlH6jQr/CRM+9L6IkMoFxPYHNWqS7LsPs/zw78SU/JnA3/cVvx7Wy
RzBFiRvPRFB7x6tSNas53jhf6lVanpPxpin40A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NJ3AewbGy/1b3Q7grl6l3g8U/DqAzeMvF0M/rx3LiqYv/mBQyl3As83UPy99ReUtnyfJP3CLmF9r
4i+XbKr4we6uYQcjbnhylwEw56pFm7SGXVTq5roiDHSotdKqcr33xTDX+9/auKrJUcx1Lf5rScgw
m0oxolc2QVL1yT4tMLK/R4C/mdARmD1Jhf7hKfUOIKi/xNXzXcqfBPU3jQ9AuZW8aTM0nILtH3XA
ZHBcPwZv41mguaikMmdwlA0v5KQ4jHbnOftBLuEpvG4KDiFFgCVN0rxTp3ObmKYNi0n/sIdyXwyu
xJkurQJKLU+73OaQuBjToZKkK8Hi7opi24E4eA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
J9x89Uvo6pGaqNI/JxQkXmn17BeLNJdHi40iwXG4XmigXrbTK8r0txxMjDZPf7lGcor6U/li1IgB
zqsF3jG03OqOjPVxJz3ymVNO2uLbm6Xefy/o5XhmwVZIwmxxNRtZfSeFXJDcLqJ1FEOUpKjWZc9w
u1v+F+g4pKLsoQOSnFRGnaRfLErIqY+NuyhvRJXNncy5oAd3mY1c66jcpNLqMMjIFG4OXxB+NeYi
XGI6+jt4apOfng5+RGiJVzA88WHZIlLzqgXaKg2TpgBxodNUl7nCUIADd8EgIGdiLaX3GC+IKIB2
1UO+CctB6E21VKAqU74VG0lD/p93HxBKnKjD1g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cU2LmR8I9S5r+YxJ0a2gpKEhhkcYSVhV/JGs0aAPC+M0GDF/7siymgn904d3Ls1dhcRObRzihHj2
6Kn4Yo279hiHu+P/x11nE9kHL2fSHeRnFjUf3/SbmCf2Zromx0AZ7+1yOxO6m0klAAE3oFwPWvY7
0sAZM3pQTYtfHeNakIXfnuRRUrX166xbAxREM2h/Xvq0x0l+CDXF6F/CidXjH8Bf1vl2hzoYHfbs
fWYXdw8XvvIsUtJh7JJZoC2xe2pz/hQecG8sLmSCglwzoVQ1aIAeMedpEngiEGftKTvyIQu7IVd5
XZz2iQLs8pOjRC53A9mnQJospNKF62vIV8Yglw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
IXKy940RU4oaHWZjZrXNTa0kAeT5hnhiv7sRw+PZwjjG3l8IMM8qoRt94+1DLCwv6nF4I9RkTgPj
54S1JRutM+ywxrmOJ0qvTlBg3duFtMFwiblIB6n4oTBrcbcNGfpgMr1Cogq2wl9GKY0nfhJhXHwr
j1xtL4LPI3lYKACOvpHxcEBstTjyvEH+bfqg7HEjdK77kaTyesiPZOoNQh7+CoK3zA3wdTlqooWp
gh/VnOs0JpYjD1Mqk+1+xsL3Ro7zrMZuLlZlAQ3019K1OLA8KP41IQeZTofHjYtyZZuIe3ZTdQ2W
ayxlbM9438t9SEiAorP5cNoMLMj+ogZ6Cy6tLw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 33536)
`pragma protect data_block
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
Ef3IugqrJiLUEZ48niCkEtxfbFo=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
