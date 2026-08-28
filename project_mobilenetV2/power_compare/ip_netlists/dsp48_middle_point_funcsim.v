// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Aug 24 12:48:18 2026
// Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/user/Documents/JH/project_mobilenetV2/power_compare/ip_netlists/dsp48_middle_point_funcsim.v
// Design      : dsp48_middle_point
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu3eg-sbva484-1-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dsp48_middle_point,xbip_dsp48_macro_v3_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_18,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module dsp48_middle_point
   (CLK,
    PCIN,
    A,
    B,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
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
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  dsp48_middle_point_xbip_dsp48_macro_v3_0_18 U0
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
        .PCIN(PCIN),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9040)
`pragma protect data_block
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
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
iHlKZKyfagw2GMqxsTfckeWILEpKTc+3WOY2o5CKiJL6zuGtoW2WO4GwAy6YAPDw0R3BX4UtbOs8
qxmp0cNPUG3xRX6O+CEsK7XxCanWcOq/60HxbzAzjfQ5Um8VuaW1nnfbDeUlqaLgXDAA+lGbaRyl
ug0NfWufQeHVWt9vnuGDYjt06ltfdn6KBVbY8B6B64+RDvsaUbzn/T6fCc4TYbv5EwDm9nWctkzX
wHtryycYlmNGDGlNXU871TBjBbWlzjyiFYGJqAJP0GxsKeF9EvuMb5CEX51a3KcIRnhEACP2KKL9
0QYFd9pDWJZm4UCCmEZvv4h3v30zVe+8PTCfjA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ty9KfanEyUDT7Gq7kkHo3UYgdcWaieLVOlR2/IKcCHza4coidbXodfCGStljjsqce9G00lVON/tP
WvbmNGIyn4wQTI30qu0kRLqYJKy9FExZqAUohRibcBrROYDy5ZV6/j5WGtTsfvzcPE7Ijx3hOW1K
ImFnRYYi3Jp8Uv1Yp5Y+Gs62Ea0nq9gB78tAcWfgV0sEGltuWnq/cyc7PYFBq/3PWUZBUeSusYUG
EVZvg29n6X51pbnxCYJ35IJkUT8nROESaEMYmSX9TEcfHGv4SKNk5W4JJVbFWOaZ3Y+GNeJUrmU+
o9pb2hi0qLGfug3ORJmSHCq+EB1EtgTbPqrC3Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 32800)
`pragma protect data_block
iiWBPeAjuYVda+qA2ZR92TfYvY0t4d1tF2HCeRFT5JAiXx7jXadzFk/IpZUC8hWW3uh7avNXpuYm
nGadex7HiV4DhbAqPdiUOVmjX5aYjFv/0EixaG8iMDCqPt0qLmSg2Pdsjs1hrxtpbZDLUnEzK7X/
PxPEB5k5XTtZ2mBthUwLBvBsIaTYgb7mf0I+VxYX32wjucIIaB4eeVseOuc/Ho9CxP6vxaqLJXlh
SGjzllzGhQ7RU7Nn9wtdWFBcrIC/2NGHU9eev1jnETECzSkGi5i2l9NLEdU1RdnEDr2HOp/xsXZf
zy9xpBHNMsd9ipJxY2/AvmPzM7qvlVCb97hH069RWAR2QQ/f/Zw3ka9opLIhtuz+vDT0Ooje8nuT
FG+cHlnAM8dZHELaJ15E7xFkzZw+CfN9UfojmUKEoEiTt+WGEIfUJMZL42gVFr+tJT/6ftAyy1iK
Sax3wOs90roT4Rvn9bWKwN8Adqa4MEk6e7WDTwo7GNkX6MOfrZKe2RkWI0DfsiEU6SqfM1Y9Ypfr
+U3aChY9S2+OJkpbO35RcJoBvBTfCMtaI9KBNh7m6+hu5COStWYeucdRB/y7r1H3qj6d9VyKeAPZ
w6FXqap4zXaL34xvkkCjTj1vBXiR/NXaXoaZavdrlbRTEfJJKwLK+WsQbj5FtRECXoX8H0V+Bqo5
clFTSIifslCOZJuJJ3VlByyaH/GLRQrGeroTsDBTvvj6SlYeVpAdPTr0dG4K8Ox8G+nrkRDF8a9T
CA4wFlRXx+9o/0eIWWet3Tgt569yfcs04JhQMGKiO6pJtg3D/3xl0Jfc+1ZRIIN4jXdphZTAvtix
V0lheVsbY7RiYZS5F7ppR94VbN543pkA42oJEjEmabeP9L/tLUhIRUv0q5aSWINHCnr7RxQeOa8h
QIWdB0kAiysod8q4I2b+n6F/vR0zq2eiPLQycYUsLVy+bPL/rmjVvQUMHPHlNvmb5D2qk8Q67ye4
WzerO47P2YEi1MDmupKbrflhJhEdrjrAJ7EDd2yg8riLuJPr0mFcRTPlDHFU8jxDbX8Vo+qFKsPk
/2zfbtWma8eodnuhKlaHQOP7AL6zuDb+6OCaOHEPb+okcrdq1mkt3ZgME4v4EYuc8qmPS9WPJz+G
kV25J+H3qIiqG22dnLeBjb+DP//LS3M9E4zXeqxk6ESMyUfRIdyCcQbaz8o2JBKJh2KFk8VM0Gsp
VmKutXB0zC0S7FdlPUMpPe4Br/9ESHG9Rec+HUzMzieZIghyBEMsWr9gt9rwyD+NglGdI8uHmgkK
XHpEZE+2CYuabnr1tORHm/8NfVc+u9PLGOct0IPKBiHMA3Q+/TmtIyp4vuDFsVAj+jING7ihtWZP
hb9t19pG5XzYz60z+ZE6x0qd7uC4KwqNMb+tByWEPeGe77u3ukemvhhM2JBSIIZ1Ioof6KYkZ5Ab
cauSQ1LLjY8auWvIZuffiSX6rB0TnZyiWosKVpAi/uNbjw+ESI2pHGE8qUOdnB677e/7o/pd5vSz
JEKBBJScsZgBcZ7phmLeWU+OoMpQiFVIZUxTDkR9tl4la13zc898oe05fYtMLu2GFMGz9Wu6sGu3
Ane82AQMoeCvrW7HrgE28uSkgqv2QhpMXDYi7grJt3/j/z0YE7lNOp2uxOQN+eKLoG62BueL1XEE
vm1LiyKjM2aMalu/gSQ1ulzFmrkln1KRAosfApeYtgdCQwRDn2/THiwZudHadiE93B5IKxMznNh+
sVqsSjYYP1XA6L0dMr6ctWY9BLVjd5yLEGzRKmetIFU+cjISnSWvARAVs5ose/ikHNY5yPftwHbx
sS/OLdMLnkkuK86n2wAgsuXD1rDIEw27o5/D6GhjkNSY4rJqp9iwrwI0ze4UHy6K/QgWicqQg2K5
riFVb5NrmnEpPwdQemG8WxqYGF1OMwJbwI9YhW+Vw8TD9ucon4oo6M0J6Id8F7tC7ThWWbE9VHYg
UK5U11bju4n8F4MDOId1mW5jAPFtIAVK2l1ySszBGMPkY7ya6UhnBoV0UQ17+6UQgTSbigvdwfV4
d0NdU5ucgFoe0mSqjaXOWXNzcd/h3Od6BnFNM9anToLcxrfDIHlRjZzYZRIi79JcgnR6rrYuj4fD
aBgFquE1Ha1TL5m1KdT94BOBXnYpFOLzQXK4ZnpmlhVEOxRg2KoX55vqmT/5/UfgtNzcoomigxRL
P68qgg4JK8tcajpyU5TsRFDdrRciB6vA1C4wKba056WntP/U2ohkHFztrRSAJliqUFoUaWmRLsOt
bg+ip3a7gTz1m5NGXGAuIqFXJ1E/Fy0H8XID7IenMYKdH3y01ilpBa+tqga7BL0cs6EcfjJuypxs
qq9R37xcb18j3Ew352hQCj1bZ2jmzMm2ogR9GyBtrBZ3jhjufSzZcsWnBtL6N4CF+SkOb0DdhSFC
icDpDyd+vo3SL3P9Pt0291kCzG03MZm/5lGZTQfpG+49cUfU6vA3hJsOx8zGdFLCF/qRHwmEdXf/
L7r5MKHnqqpg5lHht92BefF0lqdHV/tqRpyF1WxHTZZMn4M38LZOBppWewJF76BvV59+gJyhlbVp
TwwwmSnr6D6OtIJi51DcTUzKvWtAwOGPaUmsGde5JFjl6/JjlBKd5SUUhHwI24uKfr1N0JBrqWGS
HgaoZCVJsudDji0qztuHgpyZqtf534dXSjdaUGW1p3eKaYslQ9LlxGYqHdu1r+2IKHOQxmO1ZfD0
jTIkv9WD8NmN1zg/6J8UMZjguRhnhzdrW0ccZZVVET2RX4kqcDak8p5EksOUP2UPou5yHHS+IrGr
+FsrCxPY1FzuU5+5eBZsnQ2xtI6ErOS8bq++1mx7HBf4pRIayxlMPKyXThJrFLcEAxwH7fMgUcto
9nEjruGAm6AzQn+9XoFv+v7KK4/IBm/9uRNLxkRwTW2wodWXh3EiaPtmww2vtbMlVbpa1I+Q15sU
dviy7UHm6ICjiWl2PfdUcRuCz0GeM1UfpT8gRhlTXzeMtT2f+e40uquQ7MnAaEZwtAitJ7J7gTvV
YUs5Oguo7ZYcqRx2qzTmPNvMUUMHU3Z84JHZOsNJJlitzKpGp6KVDVBR8x4ul5BBTivZrNa7MVKU
JXR0i5Pcs4H8BE+TwgLtlXTBGCts2GVDpaQfjK9cz88Wl3KXK6VI2bjBGo4y0ZNC7776wH2I53BT
YWSPRKPLVTKTF6ETU1P8IUOchy8i88Z3c3cWixfpHQriKgSupsm+XogdZEiMKr/T3X0YAuT24qIb
jrzD7GfMjaTA+tYR7RgDCxbZPvO12YXQFeoXtObvKRCy8Dz4mXxCLav7AffH63JADyqqHX9xbvgr
f7tHc5esU+RcxOvFBarq8sjX/hS9bcatq97r2fM0Y8E+bv/msAbca+xhjJXmCCx2nexd6z71i8aG
+IG69DBsq3IQnzuWIsJzTDPvU8jjgxkjKjDJvzKPn8WkdwtizaQjXspYurhUpmyrW7VLiqThvaBA
NrZni/oKTrqwwlOJLcjH3dWN8Ih8L2pn+vbJMVK2zOj4dkbpmT5RvowmwubFKYDGVKTlbFPTAZ54
2tpNM+EoGsH3H/tbTpz5AhaRkL6c3SrW1XqnmqVqNrDIvmQpqJGhGSmUeMqK5UUXQRynPfRe5sv8
vpMMahXhGjkDj6L9xJL7jwSdDMRc7PcRNMXsz7Xe7wd/YZ6nHerbi1h3aiewuuSeDRqGkcdfMO/2
pQz7f2HixIIeKKQIVkakJiUM9IdWsrEQcNH4G6X7g6BOeJCrxPjelj3yfHhID0mkSKXtOVfWCSZu
VkNWjooi1tLSWD5esEt5cBaxbFVWJIEtjXQS0GaatIPiOGMAuQy5I9NKfu1JpzDqBERcP4pcMj2s
ktrxD/rFpZC2jD6hNB3r/jX9MSCmKaFYC8kBOYUL1FjHtnJe2P/5lLM6Qo3B5DTM/DC7xcjzyt9t
nfoKuhEG6FzwUDxr/kbq6HoxWo+o2Sa8Rvr/9n55H3VoMg6rS+lJpB50zUJw2Miy0yblG5dxymk6
LGOMFTNyVTknwGLD6vqzb0C3J9+HKaLHQPcoT6q7I+ZACBCElifACIRjWperOftW+Ieyh83JV5lq
IXCV2qynqu8SLfRIpDvgAqXvv+jnIuzS0szCdE3UYEwz7Obvu6p7pekw/BYB/O8WfgDxB6RQNVjB
sFHWGu8bLJAWe718nm2oyqzYLpYrxdgp22e1dhlkwWQQcLC+FSCzTxvJndmIrC8ZBDSND85dwaQ1
PJ8Cub34DCjhdmwP0KcfONegTZnzyvY3lN/KNbgnZ7jWjtDybm1v6Rcii30Ye6lX30w4i5dOxykA
whClGWmaNFcQOl2gZtmsIcifPw7TIkpHZiXj2O82lDItDC2ufYT9GoQ+o+mqSD54WgCCos1E68uq
u3SuR9vLjzkavrxFcLrZdnW3CYfusg82gawlGddUPXAMYKWhaY4fbp6GTzvVu2moeG0bVlm4NvEM
ZetFNmOEnEU8a7Oo6acYyW9uP1/OgiGmiFtI+Pw9r1khaeEqhmadPQE4pmskys4i+7otdciIWmYp
B6JdXYwoWbiL8dG49ihPeztAwAgFK4nBb6hWdfH03vJVg7Gyjiw+gtVFfA0hHRJWtTov6S5PNIkQ
zvc7c+wetiNgvvxC7rP6SWejFIlxW0CSV/dR+/SBfXYKNzpEiiwbZBnD0P5TwDnhdGCuUMxUb70/
lXBrCGnIQcSBQ+DQL2QoOH+2sP3j0J3FrBqMqcaznIkm3jD7nrauViNdxL8omQ84VuhjjTM8Z0QF
/2EblQ+8DZycbXrn9YU1M51+ifmGGYTJbwItU4cRnkpX44TeKeY8y8XXVVQ2qIqm0L13HOQVwnXC
QHFowtvI4aLV1zlT+0sXQtvLGbUizSVQPf/sZ4/5+0nIAO/8UWpW/53l0ZIf8UUdcc+lXoTZBzlS
stW7ciioLIY6w6wJ16YOA59mCk+cwGEKKCqSMvsgElAcdPV7fGCcwgWJIVYUdKURWtmY0+S5362K
E9amN4nU4cx0jWjJpTyA6l8fYB0Z0RM+BymW17r6468D6rxkDN7bkU+qctcPj5NIFJV3GOwCh0NT
9Qian/aAQdu3cQm/qr7/0MsKFivNWj3l+I0w1Ys+PI68SuIHJls9rjzXoTb7+xQ7beiCa7i2QewR
YfKELuMlJRp4iiQfjlrID6gCEvVcOQlKDpRqfUstTmTRIH9NeG//oX6SaEmRtYmewNM/EPIzHq/O
rTFouDbonzaESTudNYPHFVT+aqsfkUvl0p3AKCBogzkYMHQHRQNPOyykvHF8dliEZjZi2oFzUfuP
mPlzuVTVa+o4UhL3OJ7JprHSPyKkpOAcnu/1FNk1302vCrJYj79dvIukc7Dv9r6l5/1anyyqw3Vh
X+QR3DYJ8VGXWNyd2kxVyh/mgAILGOpr4HljyF8LBvS1+qo0b0MchwDujDf/avRPaJ3W4hS9VRUV
S49CjylexTMD81zb6lbcxgTV8qpzeWrWPJn+HKeYB/Xt2wf9UPZqd2AGS6F+FmpEeiAja1LyyOMw
JY/b/nnHYaJ7u3AtQfNeuZHQJK3gwCP2jeGBvjVhTU/jfMtMRN+rPd1eeulHZsIenQYu0zpymg0i
YhlDMqKCGvbj3ozq5gzYuVlbkw4OTPfZ/NNJwAVvwXdlKTRAWramefE7fdNMJxGOrok3/RewKfxM
gblZAypYkbXblpEm3dhxhpVXyQQ6fj9y0Q78jBXEor0QtOcmYnn5VnCXeOd4NbtMkv3lmDlGP3oY
F71P1NaFBBwsIVMVCZcMLR2F++Fa1sIqwWG3nnx+3v7UgFiCeRLBrRgAzNNlRAa+4zjMfh8QuTkl
uIhBsiefgMnM7DJon5e45D6cbHUrtvnNKM7mmmTjljJFtjpE5EKJ8KqZdgqj7HWzdrpRKYllOKvN
FIJ1hEjN7UyHVFr+t2zZdrKJH4ahuQQhAwPV6SLR8EE0nz2n8EA4+KmGwO1VMCv4eM98vU+ZboMp
f6aBebD1ZOmjNTtfUcixAoXyJSGj2l1ZfkguHlBQ4sP3viz+AThSo0Hqx/ZIGPErSecQLsJ9/Jmi
bXPXbPPk+XEh4mHNHUJ+gdUs70RibAhjPXim7V94HATTxxmHTIagzQLsEqP1gKw6/HjWcqUTw/c3
CkhLQz88fP5fDAANzxdBmyTafIfqXd6oft7SuNKLClcS3zEYvlJijDG8DtRjSwt6iNcqyOtGQnHg
A5fH3o8LvLrD1F6YUGKH7CsvFnJsZhLiAYU1m//46gZL4nJ5Vf1fLGEHl7kaOhv2ceULP6aHeS9l
AqWBGxJJkwN3Ma+JnKHKNHrQwax9trHUU2uOU2Ay2IYEpB4u4XuSLJG5JzoUfSK49vv3raE3sIvy
/ueO2WHnRb/HWCMvI/ylvJB+MtrWU3TAfWR+1E0tvccw65vXPFnWk81gHukmoSn80DNOCcmJjSr5
2unjU2+2aoOpTZ7R/4kv2KPr7OmktW4i6hPBhs/+5V/C1rmOxL3RYjGBCZpyx5NVC+qQl3IRaHd3
STbHqZWB2OBqOgfesRaxpj0eAlxOdz5mc+94Dea2OtQ2dtWclcpHyMLDV5MOCvMkBfS4s7prgyOW
7TKygsiC/+L2t4XoZJcG+va2nP4hAb/2A0oPD7k9jhuhsCiaWeqKm4bnwd7bGMqCVnTh458fYb8N
pSPK6fHQjEsE63d0eJUFmwR1oeG6N2bjsdS99B9y2Znzp9BGCwLWkTML7e84SrtnokFZ7dBZBzCa
unSXXOkKqyDqRBRrwXpnZ+Sj7xfMMX8RtA9rqI8Cz1lhpz9wq3J0vBPYzPKyQos3pPjE7nStwQrV
/GwDfUhW5ZQBGBejjwYOeMVtnyx2vOrAZ6oLzk1nG75Uebn1a/4hftpuncss5xolKia8BZFIb86w
5djLNwJsb9Tx1+9HSQM+KeulsSw+5naJ/Zy6IVkuviLEV51kabc6Do81Eqf5vi9GsL8JHLESdSwR
xA+yj+FsVLludjFSPvd+7IlGFABxUMbsAWKw0QUYgxsbHhGDeJYv5o/rh49FUKIKvlfa/2znkHhQ
KDU71SGjstXf/vuZtA+Q/91GqpcF4VG0aEF+CReEA23ieJ6rISGYd9r0JdnpHj3eKx8r4XkHeJ2H
Ew6M6azn9sItO2AqmDhzcxNEEV8RA69tr8QrH5BBPZW/l6941COGy6H+PIhhOx88mxrgpkvBjlIZ
d6NnQRwQIQYAVxhM0JtJasVH44QzJEZK3f1KnxSTUMkswIveEXHDV9ZqKDheK1j9qodAUIRph65H
/qF9e3E3BchVWqjidZE0m/oLjY2EjMU/WFztPoQ4a7iUJGF2NT97wR5GERyWDsqsT0NoiBRgi4io
1/7UZDhyM2/zzWetfvC+a+MfJhnNMEfz64V0aEJVVaKL4rqjql7e9RhFwO8Zi3LRp4afohdJd1Lk
ahUv//yS17HM+ZWTagWGBk+cwwYUnSf4D1icISVV+uApdUtEErC0Mw77nX0BQgfBHpKfvBd2CqIO
NoJ3fRK5p8nB4zukAOlX2OdYIK0K43615bzZokJsCKTGbdeHxVPXjW+nVunNefIjy/WMWwipmaw9
XJ8Clmy+/5KWm4pZaozPnVkpnLl0mjHTZXT71sjSncs44OxdC02I0i3mgSC9Ydm5LIC46z70TcTY
WDMtS5v1MLoetyhithjzGhI+1er9QZOhTcwlim0g8WdHgPv/D+aa4Xgn/iuIuBXN3ZRpeXmM0+uF
/o/sBD7aNSRSc04XW/QaTIDdCJWICJl6m9grjtRcZf3waKacqztvfZSkZTabBDW6xRA6T5wqHgwF
ZggWIOKYH/DU0lMShxmrvvBnUJP1sBYfKSt91hF/zE0uWFoJtzweeyH1apJUj9tGbn4getoW86CC
G5IfjdxZhRB+K8N7vBArHaGsStzoCQsUySpzMWiytacAutrgwoNqxBxcQr+blSaJHlrWQDqhUOzd
iOdUEOsrKGCgYXE3LTD0vmnKh4PitMGhl381hLIotoKMVFk8UfaEwlIPYYyRG+N90Rg30OuMBH6R
UVbrxnAGJRcufjLJQT0LfNrQ+jmN+FcvWc7TEYPizgef6P2dzR94YLHoZHta804J2QFANdaX1+ZO
I0dFnOOXvqmD9/iS4Yi8HksT2r+fiP24xPZrVQijgxNmNpptNJ4KPzBqATzCgUr6/+PFfrGwbRtZ
pcg6jBYOGHfC9fGYuYbC8KMIlVmVYFMuzm3QPqaTWWsnUusyX5xf4FwCF6MAajCCphJrC4WOh8AZ
wA5/mSVCfIbhsf3BSR8K29yPaXtfHVNDSYNUNpy+bVMoQcGuSA+8w0kbrXPr2XPFGTpMSgjoA8n2
Uz5N03zKHfWb9UDD6RfGEho9b0XuP/wYkMmvL5HQsyZQDuFYI75iWrI/nY59W9hXHuRD71PpSCZJ
PPW+RwBkCC6LftpwtSTZZedQXShNc0tCh7N5WUh39zFGHXh+phQ9kii1ncsNiH9sOKvNTHgkaRbF
hcP3uukJKZ2EHn2nm2FmpPMT3yhVLz15B1cUSZh3aa9Vx1L25MU5VfHm64oZjac3njo6dF34hBwD
QheHOzzgG5gcPRsaAlFYEbaCcS9+1F+GS9c3DaXmatUP1Q3YGhe23UkADX8u1JFT3tFHRUt/HXHz
flFtLdRofx9cJEb11YKEvxlRimgKKuz/bHXOYliJLrfctS3riNvg+KgcCIg9BQSeTfNHuEgqUawO
qWscd6RbgePFcBszsc8Mvnt7/EYG9pVj7Pgz2RVCy6Dk+dDxsQA7YhaCnW6XkwsfDLM4bdK9pZ9s
DoJLn9bxthB0EyquN7LE1kfDDMrzzDitIuUC/dOChGSR3bxd+Dy3Nolq7eOnsyzR8uITAWJnvX2o
8ehPwCi6xbe4e20FlxaFibc+UlmB06PuIwtxMEODu6RTXnll3OjB9+Kcz1wDQ8wH8yF7bPs2uAhI
jm8LjyDfzTG9ygRbSG5bMCWU2/eHyja1nscMzlybHc/7wd5h1Yijnx5M1VKMDprWFOxlbAWNCWoN
sMvt0XeriadU3KM/ab2kZmawZ+VOtO4pHb53auUB+idKWTXILrUbn5PKobWr8gXso/I/1EQoSn+O
S/JQ9eE3CiXCeDkaSJ4RkctPM4Duk7N0nkUbhTPwjun2UkIjI/QCUWorscTIHxS49UJHL3HXuGzo
8ivEOYDH+pXHhJ1ukHgB0OKiOqPjL9EDAjgq8gI/BHeW4pDpbZSDuU5eM/a4AfeEJKfxZoo6wtU9
NpLg2thla2OzyIn60YRbLNeHegk0Ru1iVEHtmgEjnNDZ698kj82yWVS61zEPtliCGIkf6b9u19FS
JSGyMD7uMPR8Pb/d1nuO5COUnYmZF/ACKFEHlgq30Yo0mLw3gilG+BEWwOttAaORKzCq5uc0837k
gsBok5mGtgv3WPHyNYGZp4q3WhWrS7+/FNH6IFsZa3+aq1LT4nioYObhC2EFtZ8Kene/Fr1B+ZtB
l+AlvpvYxjB/2jcn34S7SeICL68IRJFyGVJQpUfzenpYerATEll9GsgwTiPzKkU05bOAOqvbADd7
i45vGBFbKPsgkOjMBb6d5yytstGoSlV077PS/t5sx3h3l1WEqzatHBRig1TbErQ5UuXfNIcPYs11
WrjoVYZeNodXwj5fi4h4UdhX+dvsjjkM/w66NkZ9vifzDtewmm+pW2pl8epmTHmWHkpLCb7Qtw64
owU4NJZgUYQQSVZdakyr+xLUKi/Py/0P4psDeZyUXtkscZUjQpibSyQKH3m72okqJEIJjZbrT6Lu
O8nCX4A8Ftnsok4CZA1hA703aHfvidEouA2qfXllFk7qfWfJ8GW5S9u1yna00XrshsSmBvg5NekU
ffwKEkqvKfNfkv+O+PvzUymcAZGhip2MfepzRAREOym35c0jYe6tyEOl9QZX2Gh38PItsJo1weUL
YD7S6MkxLMQ+XYIfm9KRiJSgJcRE3TgR6CHzTPgXLzalHt0QbelB7jbtWg6Ai+WgNBTOqnXijMIt
IoMNvPWuqcf6bOi6ct+hcfJqdZIFSJ2k6mMzZTMtNUbjGPFvkZPfOpUDtkPBYUmf4XuQicG8IpFn
IrMLrc7dP9jFZppzsYvtoVxvpHgw93N/JR0yH37ynVREmQgFkQ15E+HF3dnPru3Z9/c2PBI0t3MT
B8MlOZ898nfnyBjTBEFPbkK8cG3z0a8CFIf0/4yhJrzeK36V0R/Aza4yAmL8Zi8u0jvQ8ZDCp2L5
XbrTIul6+7ZRGLOzvVCRf5weSApn+IDuqW9GFHSuWkp+lIp/eYx/+5hZFvpIn+kg2hh2V9uYOIvO
hMhpogJitLtVegPV2FUKTjiXWnRFtVse6dBOM2EDpbBNhvrG5HAPG9Z9cPBLQrSvLU4SYdTPxrcJ
yAw0HhoJCltnzaLqIR3QxNDfH+U5fMPOgANCViZGyYtpCBoPsuiPO+e5BpqQDufuXqPBqgVS51Rx
AROV8lpdPs/4YKgsqxXkOIzKPCz+EbOOGmpYtyWaO6BVHmi1sS8cSJibWeM2fUZ0lv31TkCLlmEG
kpkZE4i510aTQlHBqA4el638n676//8Fu4PRAHACvc/g62uObfY7T1lO+jwiwha8j0johP9Az/qX
XuGyq9jJ3UW2PkPcamv/uibZWkZYf4qudV3KNp4fns+a3uJKLzcZrYhlXrsz5sg1uWUJ+bzU8+AM
cWLhpPXdJz2dZUhr1glg9eUGJLnSYrp5gXel2mNDOSDSqWO+ygNzq5MIGrUIiOo4GmajUZA4bRHY
yWN4NX+9oq+qtvJysJjykC0giuj49VIzH0vbWwZ2MWp/OGJTutYgkKbmgXU6Gd93DQVyxcg1HYta
8J5lxBprejvtbVviG8xweYu3FBpeZD86YoNpAGF/s8gefaz4fZ4qP/NyvmBoKi9edlT4ctU9E9yR
gcAj/Mc2epNCffE9YaJNRlmzdGRMqobkgwp2TN23VoZ1DAOladXbz0jGF6WISLMcixRMKSmwJZBY
fqgUvi4YR3wsw8qGlTv4AhJcyl+GSnVo4Veru4+7zIM9wWJIMjSmXEmwgkAeiAwv8TnaLzOtIkM7
zq6RPTg90t0Lvy/quNQqsgfEsy9ZgbwjIqXStV0eite9TLqsJg4gUWuawEsQgA/xxf3WM3frBzXz
/Gnbd3i9kEe54x5KgZphatUwInpSYDAw6eR0FryJMydxjibSnuG/t8uanXx/qHJ/BfKrr+LIw7UM
+HfrcAR1xLnBEJqrMACiohNMYo5Px9ANxhO+hktn1P5uDnlgvSl1YsJ3QDTHm5ggsdEJ9NTRYMGz
g2kmX2wZ4gq55JdWj6qeEgIpe/vjUWfN1FBLdddhIGTWRlQ/rmD3azyngbv2vCzLrlepzdCGEeco
S0JwQaEWgq1TY+4EfFLgd6WJU0dJMwwE35XKl8TANkVlKKWNxH0y+goyIfYpA0zvgBRY9XP++5Kn
NQuswL9Wzu1NhnvFtRiMHFBoL0v0jjDleL5jRWxYa6IhtmMj+Ax2AhqjLZSRVZaVRxKrPLzzSYop
AY5Iszy+OxoHDelglJH3o9YtCG+TqNXcdsn6+6Ng26YDHlqsIHQbPXW3umggwlglwOGEhe8OvcVT
muupzJ6LlFMp7JwGcQZFPHXPzIM/uJ6DFIzoXBPi/hhl3PbbNwLIU217SoW46uKy2w1x+tEfF+Gg
OBVjIZw3npDbWNtRpylA26TRUCwGZjB3CboGGo7lo4MHGOYtKK+LrHveHMlANPc74mQLZsVxqfS5
dzP6etCXauVqGaAQ0D+6Ru/UozxDg9QD4+w9+Nc0Js8g2NSpeB4cPpZm9VefnLCz3CQ1gCz9tkSq
rfbfZSx0fISlfPk7Q1bR3Sry2XKdc9Ic8PnUaYyMNvsxecSXvuDnu6Y3A1aYWoKK3lUbmGUhIWSz
qsclcfX/ctZcr/3oNw0jxYPltfqEtCBzi6ezFw2G1xBziGDc4a+mdeCLR0WHw+RiWXBU3hSaB0I5
JC0wLhdUYKwU021LZfEQJAcaqWJqPy4izisJAzk+02JOgK5kZ2WIrt5iIc8yFJJ8+kc6PRgpA6po
IPW83baJASxObjhaxzBFBDoaquljhdUp5zXbLQLrsOz0njYvJCtZ983GuN/PyP0jhCrF4Gd1s9bk
NgIygNdUvlakHiLKMvKUl9ADgk5MzWwZim8JmOSrxQnrufyKnBvh7KVMbjKB+YjP4X2Pd0Jls0Jk
RRbyzDWRE3EVR7IgNnwTH250ISS3OJlGjRSZdEjVn65NC5/vJUh1Pyuv7jWQhYSMdb7qcqUo+53K
nPUQtATzVkmiH73QkLr15tYSv/zCc2oOsV7xkGuTsJToeFTtR5PgOKZZ3J8zvld0QzXmtkVnPqTu
2VLXmf0LdO9B6HhIrTjZ7ucNRI8pb35VNxItiASXRuLVYmXyhtqeRYWDYPvruAxDZ91lzpKmET7B
w/efNz6n1mG1f/XAFj1ZvE+DBz9LOjL12zrLydwY60LzJCqnfqoyksqGkkKU1PLFSHuI9mh90cO8
SUlu412Uhfn3GUyIBVqn/yZba2auIzru6/3FAxll9t3RhpsU3xe0J28oQP6RaSB5yDrlXaltxiQG
0a1fFW0rFg4+WyaTyP6Bhu2b0tC+yTl6F/X4gljsxRkLHvA0pJAVqAmAvMa5XXsMZlY3ie+/m5AO
tHck9uGsi6n3fsH9++N3aF3U2OT57KrtrdWVPhdX4tdlk0LDpQIUvN46Qud9sNJ/ixWZLRgDfift
5srFrAW28ZF7y2QX9uOOjvqAaWhrEFIjzAruQ2Iblrmtkw4ltxjYq8cRfqdIA7qMp4pTaCGk3kGV
CKkmsQjdMU41n484tUUCpzLDdm2DANuYkyAFkYaqtUr817WmfrOeszW9YK04Xo0rtCFrSqHkVXwg
Kd4RLq0BmXOO/yWn6xn0J3MeT7UHxihHpnxP4aS6esv2/XnEfNMZDXMu89EgFsNeDKXqP22F82jK
9B146Qny5fkqyp+puBNvdCY+qg59MQBKOB9jOiJCZUu85xyCYgiZW500PKswSis1xEOfz/ROTdiZ
LLKr7TDxlRpIfGeEULgXZcljvEPKKm/ymVBvl3tn85ekWyn/p8lowAKblaLOV1Fx6BTbBgrSIc/I
QBqS+dC7rCmGoiS5E5G0b1fe7vNX+6QxWY92UkTZVFFGsfL+5Fy7/Lw4pIpqyWIPDOas/1o+Gd8w
CEyTxjlNJGC2STqJm4i4ekbNE9bLmNGkLqhN2/koMk0+w/EWWBCxUxj03wOSR50GX9J9ssWiJQcE
ClgEVt09KV3BeXM96aEk/1DyZNlxk/rjaQpaYjqIO30+xwwzuuJlhGh7XTVxSsu9cX45U42qfDuy
YdaSvSMj1BzpUcX6FbJj+RfGozSYsVrS+NxCg6LsDZ9UbK+z6+b4W0B02TP8YIylP6MYLMZ4NOiN
MwkLBdn6/jq+EmDd5PZpjAk8GjnQagHdQD1pf8UVUSpnF0uuDqUf1YO43TsAkEJhxfCzsTwQntcr
mQwKaLWpA+bo1J4rx1JEHYKsmjkqtG7eaidCbO3PjSVEsbrmIFeKnycQnaqTH9wabFVsULcaD0Op
p5Dsq89eVDdBVjN0x9Q2Vf2g9ipeorCkrJacnMD2BWHj6JRDbPjm3nAn1a64tkLUjD1OFhHGJCM+
gaQhRqxSQLQJ6Z7XPqMzDIDm8fH1RYBL3iPLUf5L3jjBsBRClLg9+6YNp+xoZ0mEqz0SSFQQZSvm
njDJzAeh0S0idgEtFkv1Ts86b8/iyQ4EVA20huO7uGzGXGbM2xeTgNGIAU/5V6P00ZhsqPc1zk+v
pE0jXSpxarP2zWKMj/x1sKBAU1GXMJZoTxZ8dTs8t2ewj/1aHVMgnOUNcRZhc/5hY0dgWzpuV9fQ
yZ0f+k163RcrYSLgFwQPlGyJh2Lzq5qu3C0WAPWs14yT06OJt8ZrAR/tnOSW4hw6q7gi/dnRXVJd
VtQzp/KhRIz3jQOKjjlomQrYP8xz0O4ckrePS7u4+WHAkrArsgCn+7ujnAAlUYTxBjSqeIl+YCnI
LIiTxF/7tW8UK6iGkUTUC1H/Qw5eOu2djo4GaN1gvVm3PnO/bhPdRUbQMm0uA1byXxcbEVZzUlN/
O90J47Q6DJY6wLNNGBSg5+FMth/cLCGZjmoj8dOrFwDq8+qoNl8xRjRk9U8qqoNZ7hTK1WIgyd5c
6DettbxCQT9xfwKdTDkHhTotq4mFBrlo7GE9s7Lz8e0HCaW9WzvplJBB7+M7+JSQg28WqHs4C+wd
VRwK5j7No4diC7xIVr2LqCXnrc9bIS1NQ/u0WV5hfigE0LxY/lTki6UmZj5RfyTt9lymDKt1HxBI
61b6Srl0S8/SDMi8VPQWKUdh45wLp1yV87qqk5LM7/A4G8L8qCfjS5tZ3j9N2ZuZxRaU6ukP2n4a
ECvOR47k905pafldUs4/L3FJivtI6ICVjLgubpjXbq03YYG/1WlwylgIBHXJ/4ijB4OmkuY4uVbJ
AUnq68HxC2BPmkwd587kPIyZWH3iSkDY8iNf2Q8+bzLqV31X7GclWF4SfHVzBDq30JnOAOC+dd7f
V5gK59wMUqdR84My94wJnPzLgss20TU31++NBH0907kH0xBSJr076l0TJgSBEqnZcY0SY3uS5Kqk
L99fiFLPAJ1GhZoh9yIR5QIlBRGt9l/7eeyKXsxSvmT+oBQ88KaKSie8946qUQ0fbeQkdI4UDYW7
lWyuIY88jE32Frp/w8XpeW0Icyuo10DGjXGTRYeCF2hXl9JcYcj1BwHZIzgMRYgpuW9VicrFviuc
4PuRjBPm9+qcHHNMti+2FqyHBJQIcaYhM/PVADbQPk3ScOvIagOdSTrnf39jg86QPBJyxRuXBd35
e1w7kVPy+AlO+FjGKqNO3jqKprM+GrPsg5spvatEbwwdzBrPdeo/T69D6ICYyDwuxWa5ttHTH9//
lcR8TpTp5YHg7CIkOz+Z3IxHDMWi9+zeImgvZRpHU3PYoGm243t2KoibPZSjHzZcvvObjnG43Jrz
0nqdN+ZixdHtxc6Y6a5qF9cisPZaS/Nw8fDNL7pcQ0ljVK/0LRXG8SFSo9RqNmM406NZnwmBLWn/
ANYhYeveD39wbBiIS4nCR+Dqc3TiHriZJMY2jiMCw4Vev16fFPIx/fK/TeoRLKmi8GTHvAi4is8E
f92A9elulNqU+4zM9i/G6bQ1vKi1jv7SRdmVJxfJe9EPRWIFZYJpnCRynRUiL9yq1h1YgqBx/Y3R
I1P6pqfRx4gTCnxRn/kzHBkZ4TP5q+x85P1xqt1MANuA55xO23ncUJ6evgX5UI1liNhD5tKe+2HP
swA2AsG3UbUe3gieezvtgq/bx7VmFKEb4U2U5pQ3NoOLis9C10UZ1j1jAGsBD5gkFYQbn6rJIm/1
jsTSvSYrjQVJj0O+35kCa/h9gzZYGyeYGGZMObFjfu47Jz3wIWRM4vNBCe+qHnOYuoAgwymeqoWC
SVRdAbiIRh1JHMsQuyraJVb+YVFm87w+9xu/2HM44qTOZR1SKIHNb4vca10L3y/dg+krFroDQHCx
pPLqNp/HE9KPWBm6qn9HdNvD+9TwV2OGXQFoA7Y67lhODlqy4fLsd3hzPcHBn/QrE64L2ilZyeSr
tzv5+E8jA7b93por8VT5/MblVp/T+/gVeoRfwZk4pxSkqGndxMkM8TpUruuvRutTf6Vki2Xwh0ww
FLPEpQAbBV9OvG+YM728r9H/GkPFqTUT1472Nnx04QSouSIyz2ht47KTSbE96WBnwYSsyQ3Yy+H+
qFckh6GzkAAlHo2T7ny9G5GOIu7cXMo2B+be6h/xQk2jgwC04oKNfF4mgDVY0dgMmvhQ+DBgse4+
oBKZBdfMRy452DFQhNla/3rai4+ksCBpk8w7arHBKZgklP7xKRTsaAVpvXbhl2Rnj/0l8uJbkmBq
PrN/zyPVqIb7hjGmQoN/H/1v/YUVt7tF9yNQ4BGBRZUGrZycTiDBdqEln17w72vlF5g6GIxK0DzD
xP1jLm92dbQyYpgQKlIdg4z3r5VdbWx02s5soQf5XcmpMqIn9DRwmMvFfuigCO3mZf307AjjOfUX
7chaNhamn8YWlsOMvRjOE46nPViOFX+iXTqlRRWOWy0RzbvlHNEGuoIRCvRl114qbfW4VgIkgUQj
pntqxzG+1sXR1R2DX9jCGE/UoKyqL9/gH/BarIzPakHAu2hYUUNiTaiQYzz4o172dZg4lCkDQMqw
QpKZ0mLIHWOfGPaqGPZdRUkXqAKEd0RjNab2IVt+dQ+dqENE3MHutjgYUOM/Xx6KgRl8dYECMSM/
IJfiooyvm+eGV9MyKSQvCxx/OSgzT5V807YVCrJceOzZ/hlnqic+43vgVMMc1TmmhFRHJZzXsp/M
3K0Xlmq9zuHhLErFf1ZrnHZNvdqgTasBzTtCFG4nU2LIglq0pcY4owM1zvq+kDb9eoY9i1Eta5Cs
zMIPg8mZWpGJm6MtGPUPziEit5DkUxuTFCl5eL/jZR/8Te7BFBfxersT9gYnZXp0od+bMr1ZMK9b
4yAjBzTMKzHpD2vPZe/aPqF+/9cuMZBztu4rWngJzo4PXEy08PWwofrbilOX0yH25+iZBwGmYNvN
fjinD+PQ+4SJfddNbpPTiuQo/XOGP4an06PLjZScNPIaKtyxf5AjOVd41qOoafZXijJuIDI+fsWb
p3+wPjugse4jodrrinbv2teLDjMM57UHmg9rTEyfb/wyjnXnRRd7X4IOVkZB9nL1x0BVNpHiNB3T
hEF38ZYZKRJTuK9OV9EYagg5mVwnuE/TKONwz1c/ul2JyJVGnYgtwNSR5Z3xUBmfJJy5k1Qbs9R5
VKp2s8JbS4i2gjWfaenAEsSEefQjMUkdX/t6cx4vXs8vNtHMb5ucMunVDmQ+iLmgXsV4KcTzqVWL
kOz3IHbqb1ORkvLEQPXHPO/13sPLiqk7TzxH+k1H0kx9KfNlzdWFMLT3FokxKliXD6ZFZAmaXRLI
5ED3Z9L6GZlNPYuXMJdkQjVBWoQWcRCHv4/zPUEo3IzslRu9IBbEoiCMyFkPXJB44a8yza3sLaQ+
YLrYxKBxuxaXO21Ec/KCOFaW8DzoYyPWtPzBipgoWt9YbQ8/010pT+vub90qRrlfjCCbp8dPnnTB
bsvmQQgpxpDiQyhSd9vZkSi9AIH5ZJgGNNYvwajW+vhGU2qe3j1YRuEq378JxQQe+2cLk7lR9qhj
tHetU1Qc0mzOY2QSpm51iPrt0zwS5FB+e6j2muqzaajdbIgeN2t7y+WBykzQ8kwgf+P+kUsuOEwW
rk8pj8MfvZFDYjboaabDGIzyG3X+gHi5OE6xddIKMkfNlDAQXeLtpxt0bHb0q213OnIq+mEuOtbD
zT72kSAkGoQx7NikBJXr3KkgTE4PcAbedO9Vs+0HnBf1f5spJLOj98QMHJxrKx0dFQJxYOWNsk4y
Dx9d0EsFFeg0Q1Rwl9umrQVPggDqjZ21NU4mwAaLE2v/gy8BjYhEp/ogxRU1XIrCJhf5NEmZf+14
f7fC0iAJdiAG7oDYXhEeK38XMiDmrLmnk8ZfGXT8gRyKSJn2frgHrnamg6Iegs6epHnRO+GJL55N
EzX1x8sV/AzDdFUbxaOT79YZiPr+dIU2A5UgcAqCwQHaHG4XyPdlb9og0hHr6qpWofvjPd6d13Jp
/XOxU95mMlr09swlTTV823rU0l1wN27ALHq5ZDZzRa6wvKL2o/W05klCjGdBiV56Fz1n9/HkFGjG
lpktstXDCbiSviCQkoMrgi7H7rSDU5hqJI8Jlw964PTfB5nROm9nri3U5C40cRAcQ7n2a91AzxqC
D4zfdWWGWZraUFkTrpyy8kqEiAz4Fksd+LwoRkIwkI1nt8Em0FrbDGD86Mx0GISf8Ce/T2sFdQ8U
wjN8GFjfFua69ywB3vtk/knE+Y1mkTyiUC1Lof7tSeJwwU+CT+lK0aKCoNcSgyWHziLleP2/6B51
hVcNMzvglJ+ghvgwouAgPUgF2ncvTUcprGQQBVlkmJ/0EgMGT0QkSFAEV51zVgLdvunJnfkV1H7X
YPvCircnOI0a+xv4UKoi5TG+6Q39TxbMgkv9UDlkDszu4Zwvo6c/KEH0/NLe2xghO5Ye4+9cgK1Z
gqgZyBbEY4MNtCC2uBw+u6m3qbmNsABjYopMmCJZHrGLQtDPXDpRUVFSfoBEo1iFvddwFGYlTAis
WzX5YrCkk7LTG6N7onu7mxo2H16LFleMYWxj72nZUaKcpJw7cfveksMWvPVDe14j9AxOG6yIL8wR
eZm2xz3d0RIdMFdAzloP6U8pmnGwG2U5FDECy0JZoL0RAoBsduRqRviySb78j4mDac3c2CQZGcLk
ylkuDI/HHU0Dadw4JAkn/cyLmGNLqzXBQDpw4O48317NEaaWl9wfzkdW+1oK5C17nD2AFiJZbsgZ
yq5U745M3pvfZg57LERt1tWjSFJ7flDlki3+77bbmNSCawzKk4iptQeS/snr44E4xSU7uPsfugXj
vYQov6GYri/73P0fTpNf2c0O0dXPk0MGJLRYyH4UGlEEayTjUBPJeR+Xs+asZtpQ7qNZgcKazUIE
hdrK/eb/apNj1rKgFDdPuh19cMuP310sKdiZlJiBT+QV+9rx3J5mP777DAWjukOMyDoJDNrSKK5L
dH6tpM8T6lwcxTkaWe8u3RIQYGibaYoOGOachpT1xkYWPzDxt+c3m1+QZW+aFKZNQyThS/7yNED9
KzV1Hba3fkLeqVNkWbt52/2e59PhyOMZVHJdRQz8iFq1TyUHPU1m9Unm+hlD31W/YletthxrL3UL
PuK/ITD6Q7o1+Jgq6tLjKs66c10b/B/HxwIbbFm93NKM8gdyHH9GWggoNw0g/zUice1kGed8KegP
/fynzEzdMoRxwlpDPqxG1IueBT6j9DSk+r3U/xIaFp1sJ5VVmZLT2KhhGWXne4lg9ZXGwvbWBDYW
Tq2Cd4pMtZFKJRho0SqIecsPPvKAFoJplcc/GHD1CBL/SGiT9ZDFO6+vaLL5RA8Afd8PbAG2l5i1
f9lb5zUXnaOEYb7x48Xzk8PuGHXALSN8r9M5Yk0YvVrWY/8upkocsTwX79hrKEDYQvMDkc6ZRYGY
Hsm/wD8MnWqD8ayx0IXnRifqrqjKCF5ZMCtMJ8HHmhru6EwDHaYj9AllpPdk72Xm84aqKOblpTPu
FWVRVFyOrSPc6Jt/ob/5k1P0zfmRIWpz0921s+SrYYkfSvWdr9c1FTRzCQYUQsoGX3u0MgAvwIeq
usZ9AI+jXdkJ6gs3FtlE08wpThqQO/ZsRtSezBvYTuoPTCqsu0pCfHChvzU3PwItZIx5QYmlcxV1
h3NKMkLGngktemhWYXN8xvF4JBLaNxY8Qkps5v/vq8Jn2WchBF72d2ddBip6eUBPUktsM3fsTX8n
8V5uwK68Q/QXeynnMB1fWPpNiOPk612duGFREbwONqTWeFWr5NijHIq2k3dhfV01bcf9R8Z1Pw0g
jCXpl8GJnKQgtI789sE6dWlDa+qw0VN4Fx6pVzGYO8wv8d0+76DeOGENbkuIaRt2MEx0/vi03lO+
kFqzdrD/FuXlYePfptrQZzpYNdJlDcBKCF2ZuzMHnOuoa3T9mI9yAqqcwBQtFgb8sCyAKMDSY/ja
5LI9dtW3whJMKlOTRIToJ/fKeMf4PiRfPqOx8iAxT7C/jndZ3keyX0JROVBSUyfvokMYJBFH/KBc
YimG/YI8AOdayYx2KvXvKZMFNWLqHSHUspLwN8lH0ogbqykM6+xkNiU7+5d4qkimd5SWuxgmlQwe
TnzWlSoDdxKX9PAMenQvA+3/mYcoOjUwxb6YaP+mHGIFl3sie9AEOqNeyUb4S223oczqDhtQDsyy
qPRUMTWDbpcuCsFlgQLVGKe/d14fwn7LgFRVwwHpTczPfNhCnj/0uG+By9a5+o3PRpzTi7nmfbdA
CEs9Tj2VQDxuPf7t5OfejMXykhlWBgwsazqH+vH00+uQMBL1xFBDwkmra/3ppM+curQhpwLvE9Af
JAo+r0x9oTdXYeYwJ2716ZIHU3eorvWfl52+qgZRAk5gWVbxqcbqGmUZ0lZMk4j9afG0JJGExYin
qouQlRM67NxI1VxKRlzRdGW01akrHXn77iD1+xf0CSgFw4OkixP9FQjMTl7lA5vtDwh91OYJYhSU
zCmd9ogKTnzKm8CB2SYafw22NG171IFpXVF+BA+0FvAMXXUcG0IPakhcrYkqljCvKKWn73s9apeg
n6kCHPdwVxl3b+xrTiCB4My2f81Ov0dXyh0xhpRUTHFQ04dtBYs6PBZVLWWAxedjEkNU1Wd8MeCU
NPzfdhQZkwGUTshul7dJ7a37Cob8WKKB+0IVcTxDJEsEW4MHRevplwyf6+fu6G6CNSLfVIXcEcd2
+ZruMMPbsLW5xfjfpvg95lJBpYwF1VI9x4gb7EA4gVJB3dla3IWjiAZXMKinTeFCPmnti0G3HWWe
irHocmFBsYLvdKoYLQ3Zu7iUAWbLo7KUXeTfEfTxUS8qb6uE/Gu1XOzfuGR0a1BVbH+ZD4Ya+lSO
1Xz4jlb/B+eSdcI3NLGL82424/xOngwG87xTga//pqx0VtTc9pV0HF25qSTOEnJFBkYMio879Cu6
4Guj/Q+aUkz7BPMpBX48KTjnzWQRzRffVcHezMhM3DDRTTwHV4Nxp/0LC6or/xFGozi3cclSfCLS
BNH80cuDppGwGNzUjLIyHWBe+40wxhvtuSVgskDpuplvU+edwsRq6mPZyzfFpyo0vzhzVGAFXPGO
Rv0P1P4A4mglAn6ys/WjfCvZUQ4vwAJYcqqoZFqeZSfSfWxoPnwRETaJQQxhWk8NzkVW5Vsfeeq9
HbV5F99DHy4s78k4+5Nt/N6b/jfrtOy9a/TzuLQKV9Z2pVy2Vu8qSu5UzjDtsh6Cxopvxa5sIupq
Ww4lj7hCr6Y2PdyQDtTMVQJPa7cQgDoK0ECJ14pKYnBi1LClk264u0DxQO3y0k0S+4jBCYkwq+a/
SniUqTpxXxJb579Eqt/uDrJsxXmclzy1P2XCkrNgZtvk2cgmKeNH7BDcldVmthKgTgHZ9Gkbjesg
BbxAV/lSvV78D1YZGRJOGmmaFZzP7FrUS94mxAwoWaphUYtJFzK2WLN5eqAXUaqb8hS3IY3aX+kK
ZwQ1+gF+Y6ashr47hr3AuinhXheJ8O34o+TDvFaxUZswgtZ8J3LYUhOd0N2R945Tfwgs9JAIm+v8
RJD0oRuCQF3NEvzY8XePttU9lvYhjOtgW7hBRuI2VxyzXb+RcAuSFyUTnlwynzomXT/vr2AjfLoz
ovEUcYdEexxrofty90jtYNpIU8tiqyFg4R5cMDDEPXevJVN/PlfMRedAZHmGZD7kQFkFmFYFe64B
AlG2ei0mvd81nnsaojVtOyej3HwxBEUOyAxO455dQOoGFl4nG0Rp6/6DJMI+0AnGicEk4Xi0yY/e
in4Is85moWak7kOeEtqwnOV8daYqNOrYYLKjFj/5Gwx4jA8M0+0XiL9mQXjf6D8xrjHSE01oDWiT
ny7Nwfw+VRJIrexPCpfcj3GIt18Eb4jE71A8rLP7p3vtUSmcNIdI2u0/xcqRR0i9NmYpv4yGpBHs
FxGjcH5+hr5MG7k0qbSIniegzTJ4UzlqWvirQq61aTS1T8xo5wVgy0ilS8lY3yU5lAV7iHL0/04g
+mYjPHbjDqHxI+tp3D7lKf0JuTB6M/M1n+gty4wSbgiFctsIUScSh45lBJ/bRqmMroZdM7h5TX6z
+o2qZSEguKogVKZzDTo4T/fOSc4q06U7PDJeDZSq0wwsskZSW+nEfzRPrLnBrgkHFU4iuELxUawk
nODgoEBtX/hStfF1S4yhC0tZyXtKZbmDXvQZZjOah2qqagjgQndBvLaCvz4p/B7S9co40tLfeiJw
vUnI7yRIMxqcQHgteSzjXk/03khu5VADodqHlE9cGrp/2kckVrpmjTnCXkGzD+IJB/nMC8uN7eQp
vAz72fVGqXxRYsAe86pYmjcQzCaHjgI9sGd3mX57+BX0ObgDysq8IHrNHyI8p8gYfVGqMUFSFI+a
aKdQPb72ZtN8tHPgyQWtYwKy/0GviBG+uSnmIEdXkvOLgotIxwaBcGwrvZaPpYhxRJgSklYtV9ok
7DvsN2Wz+HZ6Z+x5aeIszMDKwdxOBN4P6BpWRvHWHI+IEE+Bb8YtIPcew8nZvcVYqjx3qvn2+njh
ra956V3rMnvo6ZgXVNtqC7NrE4PrY6O6BKP/CgmIhnOCNQXC1uJaNVRsfOWs21L/IMT9MnwNQ+EV
AjvaNjGpWY7NYg6Ky4UUNCvoU72sx6eLruBbOMa1wZH1og74qYgrOqA8K7kcDM2Lp1bOGqsG7E99
3lX/7J5CkxO7aICV0TZFC/n5WeUXHzDfoSyFg67yuC7TJ3XIuCOkpEJrvftMYWlaiu8zaI/3nNW6
gGu3Q9lLzISZ6JpVsvus7jXQMjNQQ2Xlz+JSRQQ794eiqopyGwRqRV8GTuX+cnZNLchO5rQOGfFm
tQMh+n6GFeM5AuzPEC7zNR1pKzmCtv/dJX6TaQ0xQlDGX+BiGz3l2qmW8LhNqOTPPeawMJx4w/cY
jikBoYoE9crI4j9jTeI9LoyhdfX/MFVJtf8DzeRXfBSqfNC5sWMtpgRlrGpJOPeuZxz6FN+GaAlD
wdi5chZy79Ocd1R1lhmuinQzxLrUyHBFOTWeT/mjXFDTSbuFDl3UFyd8DvqxS1H355vh5/n9il0U
p2R4ZGZm9dHtYmonW6lqD1kShgdxmVJIVswHv2yoSurIaT/FWT+vOVTQYJ6Bn7Ek3lpTvT+DYHNT
WauvEarSlemBa77GMREQD5Vhjcv3Ik+/fCcCOvWM6HLIQ2kYnTgB90aTYSx9idN2moG/tkGOi62x
Pe9/ec4Ii03N5LXE1VRKV4IE3q3pMnAIL9gaejX3Y9QsDV4nja/3SdfOOMobbLBgnBaSyjELQx3g
x1TvS9/ErZtS/BsNoTS4yu7SUmIXyKZSdxWvmCqw4xOJEW5lCXBpG9Nymr1Ak3eHv+nNOu3B90kx
P0Soi+c+OnmayixzDnpShqzbhCqtLvYDLIBfICWmC4OWrykPN+XO8YfRX5AM3APRN6JX4Xp73vCD
4ArzYWFuxA83+R9itPNlsAVu+TUGDNQ/oS8idOE6+uQoBGVVxOOWN/RQlZJvb+p9QOlnVNrtCYkG
SGYh7TfuPC2fhXmIPbFJaOppK5mHCqI+/IWXGLwgoFmjjph0cNeDBYGejaaeUpEEIfH6Y04QUOPU
F0apIVLxTnAa8m12Ze7sRu3ZZOBSGzW9siTtQ/Bo/PwJtxN6pJI2dYT3kaQ9yvvQrc2HTqHxI5+w
KY+f6Wg72HMtylDvn+QJHqLbS6Qn6CzTPRdZcANfQfuXDvSWbs/pO0sUxqwThj586zYdbU+5LrHV
M1/ew8iZpDcRX+Fz+kcpW50kuC5CjTnMHk8kHaGTX3F+BjcnsoO18u/6fILJUPMFkflFD2JjLpo/
weWo9vGyo3x2H93toAcNJGaJkoeQTVa68amhB6fo4y1WMaq8h2TR414WAwtc7y4Vy9ScL81fKPmW
c13FybYkrA9hJ9y8O5k9z0fRdLf4UUAe0ykWVbRIRhWJWz/OxS8Izx1JgXpupyP+PjxizfNSBoNQ
ojs9GgsOszOBKoDXXAJZUCR+fFCBRmfzYWEYQySC2rXNm/FltjXDq4wDY5mbqjqS4w+H6FQ6aUjR
Hq+1b+I30X4ob41FBW6KvGOKg4JXwBOtARUm0swQx6redV4mKl6RgdpXYYMxn7jFENeRYXnd8nXT
p6t9Ls4FzCTBQmEbNH1z5lm5jhH/4iXYdqq0iI6h++OQDdpKXxqfhzv6uKZivfHwy/VztTezwltg
9nZpY2kCKqd0J8zyITY0n66LqmYrBzdvuLg5ro/OEHLM406k5jtgaJQrkl1XoQ6Nu0op1MxmHe0y
j4OqisuZvri4WwYKHwrqHFjNHEczmR+/KZVepw6K3hL9T4IpACwFR8kYtqcWpuFz5gb4O211Ur73
ZHqeQxPF9dD8/Gy87Js8N854EvdfOoYMUIxmXgyshKHuOJblWmjLrtSgPMcCNu+FtnRi5CyDlUWo
lX6+kvdD+37Jh9B7ayfcusCiQjVG46wHlVBHJMxM9qPasUH4CC15bVqpficnxh6weLtPBNHrzxTM
OiFHIkODJltCUtsNi3ho1q4xFCbCqNs9IuYN6p2Swkk0i0UcOBXsfHfNt+6GNvDLJi8xCv+Y78pn
YK4O5HxwPC/edAPBoD83QCY8gxyReQglOAPkDR4Pyw4w+B1blJNpXZeD1PKWM8KuJuigE1NqcMEf
U/hrvaiMKgdMATSSmSMmMFSRDrpkXqjRwiZN6aG5DMBAVRoektbaOPDRk3awIENqeSWVNnMHdtde
jnLLU8ZQP8/+m/nmS1fxW2UJVKxBBq3+HsMIm8GAZ7Dwz9ccwBRfaaiURcAg73flQg0wl4m2QcOI
HEm3VYUjG5Txqk0Mr4p8mEraHmCl7v9m70VSUre6FCavi4rTeDVlj20co5qd/uMxLggeOejr5kuA
UaEktF8Abq03DA8tti2Bh2paZoEkY4kbmxvS51eXRS6XOBsdaTdaEdZB15c+o59IKU6KbIqLdTOA
uUvduhAUHbrG/13GsZLbu5zxpXql0GZjvluuRCYoNFRJKa3luko3oj6rJ4D/VEX2YVvJvSUeTPjB
4R6t2Hol+il6gNzCcORf3hwKXySm4LaUP/J+DLTmfrUFudeZSeRBn/3krmiP6OynHZisobQU31Fm
wGqgYd2y+gGcyBci1DtQe+KwNCtLuwbrLHCEos4fXEx5OzEC2McMrzoeA1LqlND6FUDIfszbRkpf
NbfCTKvj7P7GjTOA+o82Gg3r158Br5gM8+mqip1oN0mQP+x2/hAvHm2WzG1+T7Ei7D3hqfRuMauh
J+ZWFFAhlLNbeP0/hlrJaFmQ+yDCwwrrF4mEOlzjIooIqTfZljfwfwOgVFg11/LH6ArYz7bpwUmS
uu+JPfI01PbHSHmlkRz7PFui2kwMys6Z0Q9smLzfmyUDY6mLiBOk6LDOJxQctEl2L6IHxM+hrMZ8
E4C3rwxoYDYM6K7JLzlPcDYaCJ4UXMorjvv0AwXUUDQaHqSQnowAPtp7V+tEWOpXCCq9emx9GKMN
CNuWMpgUr2iPOl2K1d3HyGiJQUp6DkICvSBB5NimMRxNieNIDb1Pfph/op7ud0rl5Kvs1FkqndiZ
DIGlUZS64zH73qtHVUxzhE3RtNlA4u8/XGydbLU7vymZriZkLC+mq2bNooP1fre1GnGeU75Bccwh
8XJeOhDd1s3z/MzYzmp96GGKwsqKbJWeW1RtXHiwgPetrD2vHif/wdDx1ypQDYnYVEdMfE7OBGpS
6pdNx7XZ9mjW/+0g0h8JuEDsigTMICAxGf+6YfGzirkHhbX+EgdB9SSl753E2s3GBI8xuNUH0zex
QNHJ+Bd4SBoVo06YIhfZp1HXE2jf9p9l8CctR3R2JgBfINx0sJwg7dnEbzlryH+Ie4Ychyg2yXAf
p28E5ABqq6pvrjRnS1pjR9Ojb/JQ28breAnFJUwFUPamg87adwePBGIiD35zk4b1npe8J9loa5hX
zleX60N9xfnrxmK23N1Kag0erQ8CYtZIBnP75vC+Vn/Rr3yZXpx3BGQv35M0ruZ75vHwxgx6KIMa
0lTLzf7pn5DUTIJ+TEUX2O+VGuGaIpX4eJudERSBU0UVmGtX61pPYotut62wQ68p0Y1K4JIMB6uS
xXPOSVYnkQtX9/coXJWDaAFFgKxvTDvpbDwNSoDLVIwZ7pcb253mBN/6DqA+qqh498rt/3BzzdKW
g1OptM2+ykos3l0I/80xgPtDx8GgzkMsWRoGpR1RdQv/iZbPkfVhzhwMjXzlFwsBMycd7/JON0PW
Cu0qPlFblV97lUwqt8uplkU1ZP29Uq8Ae8edcgES+q+ep5l70acXqZLa3gIgfkNMSt3TnJ6HoNQe
HMaSfc4J7kz1OWtXCyksM/d4mi8RDXoeqV/PjvzFtjNhpcXvm1ZQpP+POavzrdTNWyhlFBMj7egQ
vXuuJfA+o2x3xpphPqAl6Nt/40Vv1wG7Zi7drspkGbZUCcdcfODukUlacjg+O7lXcUYjFaT2A6ym
wo/mB0e+xpzsmzLS1HyMg+rROwAtR8v1gIAxkbdkAA/T9bA6WDoA8B78oZcMfRjNVIQR4U9k9vU8
lh3EBD3XXSZFglFswehWxJhQx+eT3pQBDEC45AUf9KLp/tEN/Eq4/ces7puRUzl9PL8tpQq+n1Mg
vCgZQH25UU7yVGBl6bS1F0fv6+sbcq2gr90PH6HPveWT7G8rvjVU2LbYqF+Dnvq5m09JuCO4GB6O
uCGe+N6UVImsCPAIpyZUBGx+MuosRpzxeTJtVglX7vG5y/dRaO2hF86y/gallFrgtTJbaXgz3QuK
Fh8rOUnwok6M9Fh+elKf8C7foBiQnd/NtgqanBhWzmTtwCHNGg2Sdta8iMYo7xwU05CBmOw9nlyV
sm6vXS4Exnwtvom8deMYM7+rNoWWjlKt3LLJnuhhBpRyxmuMUsKMkjpFT/CNaEa2/Hh/UeYWkOjs
WgcqKul1pI2IthbF5TZ+ipQaeTFaOJpu+BLGDEH1jO4nZadZGaRL7nRP/5q/dVtFgY//7DfvrngS
g6rkGiQ2/TIGiO2PE7NoIMgtoXbgVxFPDCzVLRm6ywb0bIhWUIbC5NOh9hgcuzZ8DNo5VHa7jF84
cjL1aduAT6joVrUKwzzvoG87iKeFLgnrnvR+pP/PtG/tLyaq5IIS7zFy66F6gCQf7IcR1ysSF6Pw
R6Enu5IQeRmsr4+7a8YY+sJxx89ep7YnabQQOn90/atugqA5EMMlPtZb6aNE7jBOBXeU21GDURR8
0Ry1piEkXQ+NI1VmLoIGp29UVYgAH9BQDRPsPzpKwgs28vKseGLl1B4Q43wgLXhVf1Qf4nbcv31w
WWqj94XirGunZ0dSHkbrDEkNsQLaxwkm7Aez6U9mEVgMesLe2QaciOe8Cf09u7UgC0HXWFHs8uF8
VWbJ7RubGP+oB9aYBpkBFNOCfGJd0edWpI+e011EQF7PqinqdNAV0DfU2iSCV1H6mOMRxbDFC3kT
Z+7ZTUeKzBGf/5uSG1SHCh8L8zl613Y8fl1mUNuXbhXIPwMlTyLamnYdJHI5L4wZ85TO0GSu9cuu
yxy/atb58zz4QhyKVW4bt1wywPpw/YfjqQWUN7sJo54Ps6ZifchtWDFG8ZPbmBFMJm6SFbSir1rI
X4lJaka9JS6NB5jLbXmbSSSd4LaM8GUUMpToR5jWUgFfFVccKQqHhmNcTm8sdOPsVVliNApzZuek
mZhqa+6V4up6uee5sRbIkoLzVH5Coyi85x6LJqNgM8bSC3qhTQRagO+kt6U5YP+g8XTCdTQy/Q/a
06iJFl3MYrishTYSphNsSqujqtqFSMhfSojJKmJgUctY5ntL9lCEGHmQL/1IW8A+2jXfXIQnWIHj
WxAcHZVtGauHvw8I1dSYN4zuBQFJ/ndJ6h+L2V12S+CzdcdVZGfja1KkAT757NjhywsKgk3bLoiD
WUbTDyBLV1HL0ofxPu8UEPC4Q0toh9xJr3u6DNuFHxYfDxmqcV0uxtjjlv1qMq+WEAUfilE547CX
yLoRwgA1Sj3V0PFFGBet3MG/6o8BBV03smQsWYqx5nqB1L1GgJQoTbEud2YS6YNvB8r+sPAD4mEd
BUFvsQlB/Y738UuUpwgDIQK5rcMfWJANJ/esoREvu+inp3z2U+f+yhD5dnQ/qog82yaDynABKng/
9hqnrGjZFeeAlfMa+SgNI3wjXjZT0sey/SFbzQ+bluAvCVieIBXGkBL5ri2H1PAAsTATEN61zjLu
Gy3TqpcEEQ2PJNIbTbzyHNKoaL0UB5cCV9JaxKsFlkjQT2TxGP348y/wnKQaxV30GIeDzzNx9fpV
g20ECRTPci8Z1VfWacascSjNdVCAhb2rv4icc9F4o4p5wtjB/XK1SagEncFjaPE6+j7kELi26mqh
Kf5mNKYAKzayzfh50gyoJdHnsg70gM7CDQXApz91n/HiEuwT228WFcoxPi5y2mKFIPFrofHXz9aB
01FaIU/FDxpLuYRh+vl9nFZ4k/UuLRtb90RhKCf8TcmdoxLioEgGYsjJg/fCuzZFZsPjbPxNSCQg
2d9SBZyxzsGSLx2xsw4Rt73Y2RNC9pnqOJl2AMOgQlBS94krtCU8fh3vYER2Cu74IR/s0siBRm9r
nHsrWmZfzMhgf2IxzeUHrPPUwa6Lnov9EOU/EpZpJ5MAFNMJCwyGh4tYu68wmdq7t66TP8kDx4nq
i6VPdzP9El2Wzusv/hf+wmOc0cl0R796AvVE6TPnK2pn/E9k1w1vWP+dTT9Y+EfOyg05fn/u7eQY
Uf1fVAgc6rko6nEpKEdExC+2c8MvaV9nyooezj+lyz1ieUROPtcb8/oqVcH3OByaO3CTrTA5fHLa
UVAz5QZKW8w8Hw7wqWtZM+9fdOtCimC9WcbNTEd51A+H8en3AWlwOic3AWxJH6bR+nqaHYrX901D
2njUw+CVviwIMKAcTslRIiboKc1JKd6IiFBS+KTgXwhUuyEHWZ/qeS/wADWEzM9qzOAaHXM4PTgJ
qt9X2Da4RoR60RvnLD3m7ExqgdP/gbBtrI7urfAvnRimibw7WxSnWleT4c5eKL05BcW0qJR2UC0o
QFMBC387aonbBxEpjRH5qe9ELnzUyhajL2uRARE0E6T3Rca731tImKxuD9Xs+IQsIRfnWIojyte+
e6IBbpAUg20HWYFagqx9xenWoFeXX2zSietWWOlSOwVIPZ+6fMWHivBOIv3c/wPAW0WkSAD6h6Mz
5AOF+J8S0gbgiLMoGAR6CY6/IcNKHq+4ukPqbEOwKa/MHeNCBfpmy/wbCThCjOqW8/Sv0exKgvxC
cL+zI6mRnQG7JQr0GGPzBvqXGjL6QvOKmGGodATIbGGRdBdTgsOSTh6UGNXQRu6yZHRE2cBQjH4I
ACsTD/b4iP80ZhC465gT6b1ktJqWjrG2d7nR7ojNvfLAeyN82V/ysdFAByXyngfBBe6ZLMqypT9T
izcpjd7LKIPdNM+WkWL1OnOBL0WqGavbKsuTxwPZzS4r6twxOwZwvfYVg2zi1BD2S//VYdllbTnR
K8qvZw5+/nY9uWjyACj85CtTW5QHADgt9lfcMdIdsHPaz9GlPqF/0p7Az7W/4bdLVn7tKlHt77E/
RWdHcjcMrscje6C9t5Z/UjlWRZ40MA4eTRX/zlgtYMoS7vBwksUzWVt94FuZcSyw019cKl6A+G3N
T8TUw0KXwmByuepdgJ1pbaDDPDSLB2nR0SuK3uxBZZCX+88uYnm/sXKlw2/q+pMjqVOaFJa41YjF
En/Iax6mAueciCvKE+CPBRjyEKuU+jWb6o5ZuKLPyy3UAYwQYBOLak4Uzsj/wi9qd7/N6Ajhagpy
g/oNDucm1dHknCnWTaYoR2oXKB1ZrCYFz1D/oWqz37/+Pam6IQfhqr06Du6I5aqDBtDoHFW8UjSI
nM26+nbpDRcnXeUN3Njxzf4XATNM3xbz0kJMOT3NLakuB/EyFtvgyBxGdso1oz4IV1DQ4NQjsZYm
Qg7khfZCz42piQBXwW/hCxCCFz0qYmTW9qn+L1R8dTWo9Lsxrd69OFmg1Vbg/MoKx9VUkHsxN3Qk
QFw6Y3HbU3t5MEypA9tIqyX5+AvMBSmRTc67K7nCduVs1M4wDDQR3II7+Pq/e+I+pxCf+fHXNqKW
1I3NkndEU2HdIlxRavV3nFltd0D049jpq0v0Kjn5dXbVuAhVhUQD7nAm0MiKcKc/q6z5WQQ8mNLS
K53hzZ7kutjEmCX6GOpVS1rN6d7JuYpBNIxli7/qBHb3lZTqMoRNnLdNvNBZ4XIlJEler9v4X/ow
ThiX+y7iSDEIvAdpO65vP1ygpROFwtniMWTPiRjtajiJvUxuykpt69jI4wEf47bjfFphMLtwqNR/
N2L8D1Wf4w2Be2buMOBXMmS/3zfA0vKbKe3tXytRmrzQegKGF1vVtp7u51sOpI/5a04Az9JK/lt6
8408TXH2R17DmDuZ+40v+ji/65xeI82NBd9dEZSnPTq+os0XqrhucrkLKtXtd8PJv0D1xDXHBZnA
XGUP3IO8NDqfZJe75S7tDPjvF+jkq57ouFP1aaAnPNnFKfrWC9tltzfDaUoJxy7idSvXQjZk5cuc
jCFAa1y3Wekzbqc3AGpuQGSkHlI3/O9zIFTd/qWFU1T2GLKv7kcWjMlgCaXE08GpuREXRvqJVkuj
9tobSmHkRO+u/+TVyhSrStgk71+kipwxnyn339GoWqEzldqIGpb9/EM4pI/c+CHwtJ1fhLjh6atF
BCEqe/mGdadlbr7jTez2cdWyCUwvXna/LZQutaCM9Zd8eJbjIQ3ZswDmYs5jNE1stEJNPdAKNDLS
bzdJGbeX9CiRrGQZCE0aA/Y21f4Il7h0TKZUw3asdNZtcqHUd9uCPYVxN006xOIgjxoumZQsV7WO
llhjQseDfvqvU2ZCPZNMncSwla1xeaEicQw2XACYLsUgnuxQjaBbzQq0xLgBDO4te+c8qmmnwquN
kpPNIaOHT8IyHBCbETwOrmOIYz4RabP6GKB/kX5IQCoG5SABFSDZYnL8iDamzu4pOA3iZZmr7348
tUa54XcIV/qZpCeSEFBNqrUGPSqLKzFPXvG6ioOM1t4OiejiiVKkG8w1Q6kXXG8XQI1+PH+rG53k
EeRjLsLidaseHFS4WGePNS/JG1XT1WVwzxcwyYAwVOz39Bi406omYn2SyP7/cCNYbuyWh271uc3K
Qn79+wvZdjmY4egkyuo0NpfhEOMTEfiisdMZaPoubLdLGx9UBG5JRMrOfO3rhWYss2vA+h04JLlL
LlShGmfQMAapiwNRCRiSdV8LdOGR/arObuno7+Ben/vPvhBE4BDA8zV7/Jv7UYumoPYuZFlkGN6G
xyilO/mWx0UTpaOjsgtwLeUh0QjJeH7eIN6yZHwURIWKYSmR6K/9LTTenbKaZsIOdzJsD5i2GaB5
RTNXWzmQnHdw210DJMBTeN90ILMZqs7ZdKfQ3DOgma2VsjoUm4JKmua5dpSIZ9iIi/oJ6v+uKVvT
pfCDqSYUd1JujfYU0YR77tPgQaLwNpl/4ZFlb6SoJ4zVNUa0P3vKn17YXnKOAxhlxGX9L9XZWozL
rAHrjIe7/Zc/Zzar+oxoMIZvEAqGnYtk6LSfmayC+rEiKm8D13R1wvotjun+2xHW+xb/k5YvhEqy
JzRB7K1TeymyT4Rxtc669B/YpvliADmYjNFlXb9cpKFk1miqofa1zyy0L5rHyv6L/gTP8HWrz4Li
db7tEHc7X1Rlp3AvNSuDe0C7ZoV8eAruOfrKz3j5W5ygDvoaN5DVeWV8lvmCiQOSYQ/nSaiNU2S8
g2DauvKxXzHJPWE5mqeQl5J7aKLiz1LF2Uu9HTxagMDWbsJnXnQg7iMG5uT2Hj7M4O8ITMDJixNd
KTTiEBDCzJtsgGOmvVn9M/GksMm2gtrE7ElW5E/1X0kcxYdv7uwJQCRlil665HUMZLLFU9hqDVGY
N+2uTzhwuv5/zJB2PVvXG+rEJ+9sj0jbeIEPT13afFKgCyPQ4VCMifQfG6SMpAlaa73MW1uW8XCb
+vz2+VcqdeXOubG1HlSJGW6O1AZ77htwQQH0oCMh7sjZ7PFZDlQur1WByTz7MoVqAS7cH4iLX616
yalWyi/SGzEmnfM6D4hrNT7fxcv/yhuGqlUGkIFdDX6f3k4N7Kb2y2RxYl4dxfi2VDQR7pT/RQDk
9CyZ8X7VUFE7C8Xh6q9qo1bRtprqRgCPVOkOhg4ueYH6qp/5bz/eO0h9R+vcEhaZ9FeFpZ9Me1ur
48NtNejKN/ULz9Q3CX6J3+QuDM5mS31HHi30KIVPdgxTPN3c6DVxBkI+CPnpy20guWnU5tkjY8yw
RXI+gCwrp7SigPlzo2eVq7aN57mE0aFoYM//lBYS7RcXLHR+xUxxlC//5jJQ+wFba2GyNNMHwBJn
ywytQ3yHFBf747wbj2+lXYsE3rHLsRVWFv8NPfq0C+Py/znPecuWLr6Gq55XeJFLf91dgUDiyGJG
LKkjjAdg+K6F1ZstRzlS9IPlJ19wGjE/AWkC0Gbjh49sWF3YGpg6Aq2QisDxcII9zSr9kt8rjzGe
H7TdQ6jC1kKx2JEd6c8hF37nRHckLDI6098cp2mIMg5iqzKx+5NqT4PTsOW9iSU6RTUuzQ6PxqCZ
Cu9o4zKF6pkYbiRlcgfE720ibpGJPKXtDzdibQdNJTo5DmUQzThztFZcjrrIk6b9+EtMZ2W3EMb4
p2ZcAdbEQaGHYQtEkUEoDzBTecvySoGgKz2Wl1r+qxyORyIACRL040WxztP9TlGdcLHXhib/Dm63
L+3Q7cStPcjPchuV8gcwWRXMM5X5o5RDD8StM9A/+3s1i5laFUP5yv/7wtaEjl4vE9po0Y53dCbl
cD8R63wzPVZ6g9TKV2DVdl9vwFEHVnYnN4XjK3/HtnHRXAJzxr5mDcZJqK8yNqpEPkrKFMC94Fcz
c+AqCg05rzLi1et+WK4ipag3fLHVDx3fPq/IK9gdWRer1a8uk4+KXibX08jb7YfW7sD6z/D1+5+J
VRsNX9VuLatXdmHXLY64MAejker6QYleAIOe4bhTDYRbzjIxJJCdNfPMU9XfYhAZK61ZtRwsv7At
s4p18lbxS73JNBIu1UK8bdnDjhHGTBRMfbA2KKoYbSBhYqAQHbGU+gADh4s0/5oLE8JSlOz/stid
5gHl2Vb8j92HyujNR2JCePIqpBPhp0DbpGsRiAN+7E+83LyAxQWd79aCNeVeW7oOdbMvXfYXEyRs
ebew6t2f3dQEiZmYFRiqTXzSEJbH9OQ4vnc68tOac2TVIW5frPlrgtfgts9hRSSqEiHv4PkHXjyk
BnGSY2eKCqXVCAC1JQtZ0ciYJ8/fdGiAoePFZmWs1Npb5afReYwn/R0o2DYMMQejpOLJG5Q+QDIv
fBi4voDFANXC+Ztypzk6flsGm+HGrdIrUADp9Bgo8li8Nv1iduKEcYWN7a/TI1+9x7O+hoPQ1O2A
bwO6UXgKCYKePym4fUoLFUbiWLJXW/wZg2PLGSPl178lYJRWAHx6x7JpMjKBSnoB1XRLr2iReaX/
d4Ogn0J14nWy43Iz7Rw0UTDEElXHENDPj5ItWr95XaMChjmKH5bSuZcMV6g3Uv7RU5YC2datsulD
srKp+oNC2eGG+hTzXwlG528oedZAyGVjSQMez/7cyNxMbM4H+kSJFi9fDailD0lYabdP7JMbyfPG
fXT+hBWu0Ik5LlLMM8mtqk4LbqagHTaTU3oUBKjAc4xAiT2whCbx87TVeqKEayoR9aJo4jVKj3HZ
YggXOWc2xn1LeTEJRjnXkIzzODXC9zYD8sakTxizwTX+VN23+Bcdmduf6V/ZVP3hfUG514TX094K
RBYQUZw8/TRUXHWv+yIKYj+deSKrztP7svXnVSP8epJYrzPVjny6eA5OkQ9Fx307H0ZfF0n+IsTj
Nfs5hQiWFD+Dd9RP/nx6x4AiJ1yar4noCq8E3YzJ97hwzuYjDupRGlyyfjKK9dXkH0BzwtGThsxt
BvjfbYcRmEZz2uCOvWHqVcPWLOqk67pMKtnKkZm4RKLvx2eIcv9fZkS6QMB+6hC3ou2YfqVFtT87
m+sRQe+wgaIdj05iQd2TZXWYZ/2oiJq6ordC0OlmcF7wIeBs7w8xnFDit2gPw+35XmDIn/DUwvcW
i0n6gDqYUiJGoQ1jX8YGHV5H9yvjjgTOBgc8j+P/RDbGW18wZtNM57VadW5pcr4B2ZNV2Jzen/CV
8d5CH40oTQpsL2ay5m4qihMPxcN0097sm0aN/N8DbdrOTEa3C8Xr4zc5sBmcuhFwoJqvT4Z2l069
CXOY4IAmUd85PDCpQi4WJwlicEt8XFFiWQWUqGf5+PuI18oT4ZjDqBpEx3CSyliP8vYdsO6xg0MR
A+umer6Pz/c9FyDY1qFkUXHnKRoKHBZI8AF+dONmDqW0niSHPvrcZvmryJlqG28yslAujY0eLQ5C
77CP4OdJi3EluAjQmytH4W/Qojm9WZ6ZHM1jZXvQe9qThhkXGyCoxn0dGlMEuvTjI0knccxQM4yB
YT3MOaZOlVxRSBQLeJYs1ve67h1/YLR3TTLKTn+amU/Tb5YqfaVTkMYdHKvH8xS4kzi6ql9v8s/F
5HWN2kiFCIWfqFsyz7aVF+PQ1VDQYLuoJJu02Hs9HDn8xl7X8Z1MVKeTbgJmvXCIkFsqL+U9I7Li
SrPvrxYfInKO02045o3eUO65tcAVuFzCvJ082t64PsVpYDCY9WExmOEp70mlyW3qeLPaPd9TC//J
cG2zzXr3WWt6xKaIva0D+mKqGQScADHL257rk1AuSSi+G5yix+aVCXlkaBB5P5LhNQfDxuk0DV7l
OKRvTQfscRA8AKU9Rv7DZzJpenRRGwhKKIvtERL+GnZUaWi6tkm+LOgkUarVZ8Lte+xk1otEN1vV
leNtlJlDcZpCzSKHeW4AUjHCiOR1ZclZcnq/eyv5iK3GENQJQawNvWpgciHPA0VHSEzM6+91fNGi
aR2px0tRBzgSIkRs4miqC0RIfDoWLPuZZTsT905t2CWVJGAx6VurdJ5kWf8sUyznCg3ftWTzgkt4
liJB8tuEFtejwmlOVMjCa1hqAIjNylfKe/OXUAs7M4snIJqhbl+Nw53ugvo9v+DQ1NujN1c74Ec5
oEbDS2A0lEJtOQI0Mw3XoqYqAUUUqahpmBsshSfyXTCRpWsNCm+FA3zOXSbZEXz6sqzkUqwAz7YF
9nGiuXtavk6UAq4JRKqwLQXqcv3npPGcINW7hAJ1g9c5T1tfUmXYGsWpybec7Dg1ZkRPtkScijKK
6P/KZtE1N4P40gnk4Z70i/KFBdAAxK357vxpM+TuIutK6RG8PGtZ2Rus6zcDqZakwLhqe8pOV3tK
4Safo4umPm1exTogzwsybLor150L4MFPrvPcio7FSsFXC5jwpXYHX6Jwey+YDNxnyTgPlbSgPRYy
y0wt6WuRNn4LRoF7okzdwg8CP06b2D/HWWWKH5gc/+cnJl8XMUMMVrp+6ewZIza5l9Us+RsAnBAI
3CXEJVA/U8hinFEo3nU/bod4G9Yq4g/Kb1dy2C1uUWPDP48IXIu309DOyYfElb8m1ZTm9g5pEiwb
iBSN9z10Rduuzi21snFI7RCtOp6L4nhoEBgi6sSG9P8XxCi1nsFaJ0xR0zZ/F7Hqmszvm5xefPy0
H+jjOnVqzTrHgXKkxIhWV1SoHFwwMt4uvCvQqa9lzcRG6iTMmgEmK00xcFp6+RjaAqvMIJHDPVcx
bq4TPjcuMO7IhQgXghcE4axHkM0+/0LJ170CU+950f+jOu8CTBp4E7TCgtFBqUMMN/2kdjXRE+cp
tYnpvfbCqIvLlWZ7KpeXeUIGRPKLNkUjoFfBYS3bcyuEhVKuUP1hqI3ccpyIiJc3rHDAa0R/6viD
esUxRMUnNX6DS8IgPxfPvxFn+33sU8swOUuTJr5OofmLf8aAV4VSeq8Vn+YGB/LLCDo0fZHgf+rD
xCHcrcHsvJfOdd3Ox63zlkfk7A23Gz3ZJosJ+TknPN6jBGgTZ8Olutsi0cgfL0h0LkfgIBTycHO/
R0NLY7Bc9Evp5/oqvMSYb+p5iSB/8ZGe186mXL2RwxsPqQyywaEOAT3/gaC/hvvZvyhS/jNFXNva
QdWOB0dBhIqiboUzq/o0s10Hx6201zhLgZKINI6akBurMsPSXcEOCW+hKQnET5cYCs7itPDsK6Nt
mv0GYb4oPCxlR5Ng2qdVdA19rPpJfdjjdEHJ7WOVaIpYUDk//5lsuo3GkXbJO+sjhURIjcIUtxyk
5VUMhQjZJvri6eyhdNTrT4YNBtQTmACS5y0E49AUUqe5kGR57ykX5Igo5QL1K16U1YGQ6nSFFo0b
0rCix0YYBZVyXOdRetnBlE9hcrRonD7D3PeQdjznq3V4oyZ2nwUO3x7a/PNQWdZw/L6rn38g1Fef
8KSGB/QVu+CQE6PTvYGMmz25NCnOIMqD3VupeKobWg+iKvAXWobzl/kll9673ScEutnsn+XzN+u/
MBEn6iLQwS5F6194/vZ4yNxu0/6cjGVlaRZpLEOo2AeDncvsyLpM659U376c0AN4SRBdEy5eEgVi
8hbwJRXbFw7iDCMdd01Wg6sI8197hsOTwyeSjXZP2hQwY7WbE1Lp0xwVuxZzFyVSFd7p6k+u7GRT
itQzfdEhXm1lp5xQxm3M2uNTpBz9Hk9AM2H9iqxs4Bh1mKYnm1y1JfDTinIvV9OxH7z+lHilq3VE
y9uDhal7Pw3Fhtyy7HBXnOZLgifCmTAAsZaGnYJA9lCBViei7ROnIFTcqRW9nbae36VCaHwDtBL7
i6EaGs4DBzbO/qhh/ZmdwYLHZqIkZjmO0C1pUyPno2kM2EuN1KOkwoATTOE1QUrXGZTdEg6qd3XU
Ua8OPTqZgPhBTq5RqJxyG456r6IAhcY7GlsFT8a7X6t6Ykf6RP6xkKspDRK7o7slXS0jTdcbAZio
Jzr3qkG1q4vQPYu2+M7P07oNpThLFOisjxnZB97i+ar/aOAkXXjbngTIml8mIOIM+pNwdVb5ZfHO
EZaFRlPQNU8hhZDqJwmB2EdAQSoyTBMrUMUnXt8T9tayAA2wX7obf2CvrvQgvJK8Cb9Par0P11L7
1+35XB/twNbv3An4Vii65VLAVhlsHKp+SNFCQJI2O+hnAgmGdZ+urUofQwVbSXsJ4gZGtU+rSX+I
CysydvXiqfb7MyhydTw1YeVTOxQGtllEISDyFSX2uwZRqTK0xhUx49vp8n+QfGVJq8WZt6TVae3c
qILZfwSmu9gDDvQJQXjaTPCK6CU3AgkzQQA06hVqK+bkwNuUPmydOBEdM2e4BxePp8BEqFdw8tTI
WRDTEjjamJL4o3vIFOrqPXPjgQv/YFvDu8Ew8RzOsT4B9r7ngHAFkrqSMoTFE8El4hl+OYKBaS5h
7DR+LrNJwC9348X1qXPpwvHfscXX+Ckgrl5tbLxkz2XDO6HiHBQSfAswNLIJn77ctiEQ+Rglqa33
gdajKgLAVV6G6Cwiamca7K0lkOCNj1XS2dQ/mMPr4oGlzZ7RK9aonclGWOj52iFK/wBnS4VFGm+G
Vs7cVmI4w92uDC0LRzEZZfkd9Jyc1C8L/gkbBNkA860EHZgP+95+pu5Q+CC9tatrgTVvTXi73OuH
kC+Xf5jm324xeV4QaBGczU3lPU03ojeMbyeJSpVzWgq1fXiY8nDZGmXCX5jZ6QxD0afOeQiAhuRq
REdpSxVR4O50CkgQ/NeFL8Op+tDwk1Wd2ogciS6x6jHrBkWEZrqSCw6gGPcBTYbuLpZla8LanhSJ
GW6LM0EeugG0c5DukTvFMyCHiq7qszeT23v6w1FKCz5t1AImREZqEE4lB1Xhzv2GCr/pj6EKINJ+
uIhRHLzs5WYupHvi3BgZnwSDiJ1X4mqfX7DE7o1/I6qLN4q805gZjsM0wuRWRjL5rjO9zSkuywmq
bDZt3CeJU76p5druf2w8HmTrTxTBKa9usG53P5GqQbnCh7SxXqQVlwODSkt9d5VMplyv4cKUiMTr
011LLyr+43ov1gwGc8TlS8PDVfyR6RJYDLipg1rioC63bCR+YmVF8OOzeaPny7OMHiboGkCK5o9t
NbFDJns10UCgjSn+/rl7UhIhMZUSFSADnx9dP10dG0ppLdAFTB8C+FOnVWwNTQjCq3D/Rztw901M
EvKFBlC5KLdXiJTlgs8sx6Lyv+FQbL+NJl8oul5ePEZ669/mDjYQ2ltlRLmacvQjRLJTLs9Mr25B
37RAFTFLaCAUgFZARsl5179QRYJWamsLHxXfY07Ijl65Z5J6lNENBJbh7yIV4whgPmIWP2W7IQcG
0XG1PXIFj3yNTy2VTN0mktCMyfnMn6q19yCWXESyw6py08/ZkIVyolaKL8TLnlvgZNublzw9mMbb
tOqaal3eMc71biFHCIH3lwDgeOICi7GipmsjVMu0IH5FFe6FExgWOR1mxC3bk9vDC53GmL5RoYi8
iKw9ZCfujl44rpU2nUGZ2tFkPmb49SdcZUUQTMgu3r/niz1dTbEVlenOQjEfB5se9jYx9kbhNKzb
iUobL5px77OhJM+NA+3LgF8kMer6wsyBJlaaBLn/KiZWhV/3lrH30PYTR6oMWer5iH06ez+HMr70
4PuVQsd2PMi02WTmXiSOHBjs24hCQoUqhuYnAtzY1pgdbsvQo6m8vex1S0kWgNTFxbGkB6LLRZIa
b/Kxi3LFkE2pwO9rnpp6BngDeGgib8Ms393OmDml1BFeuEreq88nbktjNktFpV3IlO3L47wqhJVz
s1dK62/9Qh7HyVhH8/wfPr/z/EL3T9ip9thN4me4KdpOWmdcrTVAm0LeIhLr7CtnhTqBa5NDRS3A
ijP/ZLS3rpE/J2PEAgWfQa57/AUgw7LewxyazO9mO0j84Hu65iFkOOrcStPQXwbZ9k7E3XKxkH7x
TyZpGFy6Al/BuwLfa8U9xzLWwM0uqG1FNLYYuMpL8BeDrM0Bygy9B7l3KO/w6zHUq4x5DiijEGHf
CrofhYDYkacutuAVaCGeIAOixuwl5lGJUbpFWm6G5V7Phu6Sv19bG0d/qyqI8bp2FokPEH2KWjHG
VjHpqO0JwKh1lBYFPB/lDdaykugWOiCwwdokYohkb0L0Id65TjYQXcHEVJE+U5GrakHCy1iGXCOQ
B0aYVcluhAIk0GQ/JiBDnJN6Dgmn0St4+U0/dM/wP+S34/aVO4twJbd4wMwAvDfZ77Xzj9FsUhn9
niIP2xyUsZIMHdxJ80GMhHuxDK8y9ylKrP0ro4XOkjI+DwpOQlY0qcD4/Ux6fjmwyiPaJet7BwE1
LwxjMgRampzQfy+PXZqM7grhU72waf5aFXMwg1ffTb96xOR4bBgpc5w6EIwPwC8CjJeuw7dYAwCa
+feQ5yU5RKx8wec6UsL3XX8HQMrqrHoL9FBBOwJgcAc9dYz582p2n3kxiJVjAurFFpzGpTblLPPH
AYel/FJlTMgUxdGt9T+R5QIKhPP7OK6WZAfYxFUIi2GqjogvHxHQG8meV7W+CvX2ux5hsn2KZ3wZ
WQ/0o0lj9n+zCFrDoKiGVSFw7QwiXIvxDE4Q/hJeKZDfsR6rdCNmL+s20vz341JJl0rQHbMiYl2i
o9ruv/yU0dbwyNHqFSKnf6IPHlXmfC9i0h7PW9rOUAniNG13QxxOf4UTp9O25f8NV/UPLIvc7vTg
g4kIClpiY0uZAAJsi2f7NEDK4iwXBSFiQG9+qECyZqMdnACq/hNg/sUZHhvc0NmuABiMRNky3p/m
Je5EyY8B2/upMVkGvPDLow/xW4MdBbohdUq6yjqGoNAkWB9dcLHTLXiB3gB/I8JNsDgGJ/UWfEOW
iJrLunMX/xP9buV9lGk0xZr72hXy4AGlMGmJwIYuTKssq3s9QppTVo7osbCUQS01ADcHXBxondsB
fcihPMiirnAww7vOpWoRbOlstdxiH2cSdUqjXEsRKzvjiunqQJOkNRuHSF9uQgI5IMK49er8JOY/
cH3U4DinyVeQUDKWSpgYypjlpBIHgFGmSo6iXtvspxRxU7YbBZ+zxC0dK6tj7u5eBctf7KDfK7Z5
zVGdwmjN4tNMfYwxDApf2HEWczqL4RwYenTmKOyqCP3dhnuxc/IsPuka04cIo6zVWicYE16oJKgL
/S1iv6DHIkJyCvzYxiXanAc3GYVtk70ovk0EHpfZ1MFFQxlUqrkcSJ+ybcwgRQQv3S/9PdOO2tOE
rXg7azsz5GxZDu5m4KO2RnGAIU/Tk7VAeAqQtxhC5mvP7wZqP0NEUs5rjUzd2G25WiDSW684RedX
zAgvmPpczXOwTL6C1uTVCMdvyri1QZBmf7H33q38qYtHJ47lnRZat05lh605ITvhFGPRTqduYbJf
ArO22DyKH9UTsRqgzhHl3bYcH+fsEpLIdzAMJu8BcSEtU7Ac68fEksmmtx/ek5k6zh65h8czmeNx
wbfXeTvx84VOaG6+9HM9AXgf20scm6IxHWvRtQYvWzJo5O1tc2NvX9TGibB4Xl6gX+JEtQgv0Qat
OUy5r5Z0XrpuBPSAOtzaQHKyyg43FV/OqUa+DpuVmJXZLbEa/pb5p8FDZWLdodJGpN5hRGCSJ88N
fEPPOHbES36jlchG3+nDknxwl6m8GJnjPwn61HshQ0vL+TwYOXQcowLuI2SecpOgVB6g6WQ3sU/6
AkoUpDKFkpKHwylSGNlfxX24p+KUKEL8PNNUWeE7flFUvX2WczN1secyFac1FJiAHzGcaLqUka2j
Wcks3wRR24XkhYU3jVnRgpf9ImxXt753/GpKTuminOMokMoV/fLXgz/eA0laAEOJZX6gXnCK6yRp
3vj+lnyLulYb5tH01b40gr3g4GzoHr0xmeNlku6CNQJCIv62w0/appmwux/YIteKfnCUKc4D4OLu
mhgLsFSmOwUMd4DxpflyBqe55Nj71kBWhsg9d3ZCZepP/OSXgojJNTJJ1koCbinDUmfxiUZtlyIO
ARru+w7FqOvOwIic0MD8IGX9T2eRCYqNaFb096Va6mfT6lPMRZgkrolNukZBt9t7DQiyVJMSwUzW
eygiSe4yvQ+Xib6am/bx9DrO0oKcAeCRGNt3jX9D9A7gh/yBbmrSjyMLl6Dx2n/m89ZoG+vmeXzU
2YVtaPCGfD378QD59Nou62+L+Gp+tues0vBZPtHAfbBbcZlG9IE38dhu53aU8iJilKQLXOTmJGBI
lGhvICMuTxE+WI26kTM3bdtVbuPVeZ+S0PbpK96R9bfP9iAAyERZT/MdsicMy8G3kUTzjR4/SJYo
XLVVGkYX30jq+pHFWgQt1qkP0txDKmQiK2yvk5plzQj7lo5BaONwBGZ8/eREd8cAl8kwmrfpotdu
y/Pvwe3yZSEGy/1e3hJhQRD9xk5ydK99IzJhYhOgHnJR7cfc9vqKChCtqNSVhgli/DRPW5gLkxSd
gOc+LCtAcbHb+QRHDRQNvC+r0bgNfXnK62xeRU69yYb2Ii2lOkBY3Y74q9JyDqPriqjeuRmV/jtH
Xp2Hbi6ubxnhqjOl4ziYt/rxB7y/n5FKpBAHUwCtRbvD2II+hsiLWdIN2jPtm3S8bffJF08LkBt7
CwJIpt781QwmBHHInRGWZEjct+TSV10PYKHvUh5zJTqDFuveNHuhb/nIvbRP46A4FmkIqT4OH0gT
Htqib29i/V0vI2KYLY+seGZs4OHwQ2Gjz7+EbpZr26/9Zui5RLWbmH/s+4SUQidrLAO/GCM+vFkn
GuY3/Mo0fkUL4ZIcrz3PANgWyv1Knao2w9FHSX0JQ+wU7DsK55lgMpqWRAUScyZ4Og5sfmeHMQSc
2GwCIaaJn6krQTA0YdFkzitDrKK9W+nnVBgNhUHD4j/Vl3n4qNhXEJxYzGe4nEr/QqtS/9tcW2K+
MO2csCWWlOdjScJMN5FBdX6S2/okQFIXc4uyQSFTOuA90RgeUICmX1zvO42H0ZTQ4Nfj4k7UJReA
HKx9JD52Mz00+ox2flhsI0aJA5GJZ4s8JgVZ9IRkF6Z8q3aIHrcSUNoG71Xz+ot8t18qnIlhaEdp
h2vbrlQ6J6eFGFRItrDlr6f55Ns+i+WXb7tyADsJxubnDQHFCqqZyfyMTALJpAZ4PGvTjjG11wCQ
KjWXJDNzj2KZD9UyBAwbd3vUkuPgcm04VNjiHQVWPV7oQqNshrYnoPsS2hq2mvIlLhlg+O5kp3AE
n0s/JUCNZ4wg+mw1ChBxv9ENxnYG69UHfl6OY2+9a6jhq42F41x6Er0roPEWSkJsAKnet9XintrO
NdJRs33hjsIyaE988ENeMRZ8FWariro3uGNbl/m252VBLqU3vxz3dXttxRZv/Iy9trzl3wW5A0VG
pSgPCppEs+yzkS9rVSccPGiyopS/irK2nNeqXKXFJvVCu4I4aBdPDOK+p2GXCcRdXjuWkh1WtHSS
WWmZdL/deEV+bLeVEu9VU+NMdDCyQnzh2PT9UgTqXYRCiv6ZWMiYV0qJ6YaatK2foFdrzbYzTSYb
5Fw5tupP/Zhauc0UEeSfr/mSSXldMiRMAbBgFukhXHXP5DQ4/3Mw9PXbgwXk/6/hEjbb8dAgF8sG
R5b0ohl5x0rHU0Mv2XLr4E20jdCB/s42boA99+GJ+Vk0M4uotM9M14+fxDNnk7+Nl8WE7DlB+wlv
/nTei9uR3FNjrIKjYgsWyXnHbyciz18fQROkuXZbgeFvAqrpEJ92ieT/FrpQqOyilKw+brv/xrPI
F7Lewvu9mFwuM0eSmtDVLRxjEuOBzXsXF+MmqIwd9dW33Yq0ej+ICAUKg9yAw/zr0sHide2yIyQE
m3bHPcRh0levY6bqL1SYJVPeMYyG2AnZy1JauVhOyUa2zTDjDUNgWYP4UKT3i0yXoVY3ApJcORWr
3vFoVogmps3vp0J59kNhZVVkBguugFWs9UGQDR3C9wiWEenU77B7EGqNeAIwFDOSrHmA1FwNmpMJ
Ws1+xnSDQI5CBkCvoWXDTeLdGT0j4Ro74j6GbL15LQWVil1pnY/AQpCoMqB9zSVy3UhxAV7kp5ym
IbVKCAa3qq8zA/R+BWZm6Q3GURnzBUGUrK0Qv3jhux5AB4QTemg9SO+tJa3KnfE6p1diyp3XFhdl
pHcxY/ulH5Z+/b1QO1hSyWr6yaXfhUX5i5AL77Mh5TFoz2V8PjW1ssXJZiI5IVAxQuH9G3B4V+6B
mLclnp2/D+wV0clqgzxrIDX8MpX8Og5RoYe1vNzC2ajnIf3ueKfIOB11PrN63f9vEFTyVzMAQZQC
CPLpwNkA9c7mmDEPmSBOeE6uwZMqplSfOLtklKKMBdt7iJAqLPGnOpTJMHZLw2UwtSFgaRofrCo8
/YZmmmybXRo1yQwh47y543roDD8KZDwRvqc0fUrXcgWlQSzCD/iDsOEgyYdgAaWbxP/G9oGuALoU
lCO31oDI4upJqSLhjhRq2lL4qv1cf+y33HnVX+L8Gz7U7C8hq/iBJbjEOY8SD0wu/hdgAuIg0X+0
zwFeEDo0OZ4aIvCgG25VLRcox5BCy9k6lMsoearxgl/EMpHRW545ISlFUFAeW12YC9CqL/+jKCWZ
5Z8EBJvOSDN791A1FCzIjzuILBwdsrPg3GU1wmZ71+TEMFna8ArG2tt5Uc5pQ68JG2ylDrELzJsE
EFeuaGviw6FNF7YEqcX89ua17gMP1LpFYAoRO7jVvQnj/Y7MVL3l12K3SHbCIQ0Mr1L0WJAfjrRx
5d3k89UPyNVrYv3dzA66GKHEbKFWYzZRN7PktUdsR+8wmHQ+pKtKfyJgLQDde8wDXcAcHwKV9GhP
eSm2Coh8WuyaW1t8o3SQ9OFYecYCHGJJ00Rwq/kL/YtW+3wXFoN0WTC+KQY++8DuUgOEe+bA+bmU
J4u3PvefRW49HqLxZYSrsd0NX8LW0TmvKZ64utKFZ5O913fQMPsS956SfESiUB2OTsPk9bZSwd2E
3g2g27MY7xHagNjh7GEuaNVbUEWVICpJ1Q==
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
