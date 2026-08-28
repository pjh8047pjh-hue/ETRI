// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Aug 24 12:48:18 2026
// Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/user/Documents/JH/project_mobilenetV2/power_compare/ip_netlists/dsp48_last_point_funcsim.v
// Design      : dsp48_last_point
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu3eg-sbva484-1-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dsp48_last_point,xbip_dsp48_macro_v3_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_18,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module dsp48_last_point
   (CLK,
    PCIN,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

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
  (* C_HAS_PCOUT = "0" *) 
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
  dsp48_last_point_xbip_dsp48_macro_v3_0_18 U0
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
        .PCOUT(NLW_U0_PCOUT_UNCONNECTED[47:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10656)
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
bO8DhipY5QABiKO/sI8RYOGIpuIijFiai9YwcjrDDBwaDbeCDvOVKGncISXpe/1ubOfr4Y9wtut6
TLiluXCpApepX/JHm67PFUcudVJlTzkV15YjWpZIszGsFq2PXob04MAn5rkcbKbss20bXVX3T57S
RZpmeV9PS7dqrRW0sRyaFeQjjn+ZqbJSxlj7OvmYMMwwBlmupwfCFKbp/MiZBjs1dunqMpHpVcxm
3EMLw+nOs/Beu1+H9495YeKsLqwqPU0jSH19VKEpGlxZxfi6G5oggV12Izart890/gEKC63l5YKG
0CGVy/y1CLJ1GyrnMjvkSsrzaHjqAfFz/LbJUA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
xmzmKz6QKPY+9scEreyCFi6A1nVm9GQz5HRvVvoV4AEKpenWZmd3ZkudrtU10sfSDj/elG8Dpvmj
QkboyjYAz5fD9JbqzWnJF37NP2tdZZv7DRerNufKcwawoNRa0JnoXg/+879yPdEZRZVb+0lloO1E
tYQ8dyufP7BzoPLiNIxkcEWFHIxLve3KtSfG/nEWJM8BJjRfPDuk2ntKZmJUm5Jh02TxKCpadtVD
qVHK/BNXdegWfnD+ZyGDt1MeYZ7zTIHCoDAHFMb7KWpzR2Vr1/k4ynW5IUcdq1jg6ZOds2p18Jjd
ZTrdUdKjYiDsTPOd3HLnlpzREbFHi3g5MXlgBg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 36272)
`pragma protect data_block
EbQV6VHZ4PeQsr4xzsvjqb/dqH2b/uGPtkt5tZJFwGr1pzE03zZlUofnbkEHNpy6O82cHiEGT32/
bWI+AkYF2nMFdZiKxawVGepkmr0zRqJ8QMYiuQEYpeQ5MpyfkV0JYwrKrizzvMx1t/y8TaBExwE0
wdJu0m+jI7dMlAFwSe7PiJpTCg+npD8WXWItfN5qtJpWeODMciXh+ojBtlbqrTydzZ1FXFLdabEM
xwd5WSDaTCNL1gHBEt7dncvvFGetHE66l1GLtkH7Z3Fo5yqEEaClQso9Z6i9LuX6QWUS/bKUwq/0
SwmIgaVEhlXQQe8JS1J0XI0itjVHbENP4ofIz5t9kqukmmYOfAwQLoWOZtnk/TRi37to4d8q4wFk
s7RxHywAPzDrXh3mpwGsSpX5fSeDMC/PAHt7v/9oXN4+mUi7RNnhlVrP9yawVT8OZtz/sVBcK4/V
16ALZxTQa/a9l7u0sYsXbycSv5yAzR4LLzl8B/JBKlUMrK9/GGAeCFfAgT6lk4EsZ9CLt511pAUc
sOFttTxJvHAL8TFqFxPm2MIUwiX2UcUfALrtfdFSj0z06h5eSVjmkNZYJ72dYIIjTUh+tupc95XQ
ilp7ATx4J4dcpQo8vPAug4QkXSgn+ke7pWaIdtUzhkRXZ5YeQMUz2zluzwpatCCo6iYjAuRzoku0
sdSf+Fu36oHj1TXPXMk4coq6FxMVZStSB9gMzfBl2ycYBkPa3JGE6sYgQ5R9xV4nS+xk0E6GeclC
JKzUmJQDW1WaK6R8IqAh7+04PnvMc6l4zs2VqRqdnoHji4wd9+wAcoMaluiLtOOI2PCxGm6d7Dgd
JgZC8SjKNPYc1bREMPMhlWKF4jbzGUiznISGbVjpfyyUZdXLNBoiKPEe5ZREyqzjQgDbQKciGvPf
N9hn5WLuKnqoUZs+m7GHiDUWNwgKXTw5pcTiXOoM9cHpw54eWoIIus2queDXtxruzHApOUmbXSVO
taaI/Zh2nXaL9bmFI+We/a1WizAv2rcv+o2SvlIQXcqDHjK/ByomIfLRmYwz/qcY64m4xqq13sGy
t4W8eSqYr/uAHXNsRbWRcOC43C3B9shUqbin791rq6aIuo/pPmvr33NUoC9hDZ9nbla5MIJzaCe1
NEnzNoyfm04DUBz9MDx7cXE3za2lKSVva/JbK+BqKAu6qzKlM3WYhv0dxDkU/p7+NFyooQnIWnAV
BJqreF6oApOATM5iVbxpVaszW0tKw+nf+KuLSXqGI+zuiWT8LYx/bmh2OJz55KUfOPt/cacDX9as
DubSrhU7goAAEK8KfOhZu+z/UUPnodSnO6BZj77d/uiY6xdOzDL5Uwkb36HYG7xjPpD44OCc/7bx
ZWQbvaMod2YFY3ymERMLSxbHqpnGG0L3iWZdakNBjJV4tmqzyKRm11ajAu9eYOEy+8m3PPtD5LHu
VtOglutPaGP0nvBDrJA9W5vQZDoYlLpGj6vmsH5SfOZNjfawtvQGFW3UWizsRbGe1el/oHoHclxk
XyNgSo7j+zcN1gkKrlIKcankxAiAG2W0N9WLbr9StO52zReB8t+xg3MIyHht2WXkfuknvvBBFhQA
9oiw1NfgpP9nsS8qwn++Ma+h+5V9cpySzONdYflpLOMXiIbQiNIGEdds9RXHUlUMCpQZxqXSJHSY
Ft9wzUt0ROPNfKkAmwq/WNX9V8xbYC88jyeODgS8AOxRb1/OytVzZZWJWabyHAUZ+Q2+wrJEBx68
tbE2NhQbJ6J+FIrErAlZpZYoghgY3QrvNziuIpNmTBMAsDjWLmm9Uz06Lwb5OFvu6ujSgACcwgrH
OamA9CwydACdfZCluMI9PizCtTGPVaXQQV7E+qE/mvOaz3OU8ctvBcO4uRr6D3K5VGHXGFEXPTTn
DqooiBRdzOeO+DC9be3ILJhWIb4G4qIu+v2nL8Koplt9svBetnPGvC5vuT4iJT1wGCZxZORzEUCS
IE2oy8byBEmu6Dh2Mm5ltvr6yCbDdbdJNHuOV/GZVNPc4RRwh+0ItZmU9hac+HMQ9GGw6JfoKzUh
fAjQrMXDxAcgC1ctZPXSpBoX4Wo1YSwMBhTlrorwE3VYQ3q9GRixiW3Q5QkGogioRTzVesG+ppF8
FNokoGFtFAP1X2S4e2DCLBcdcEJ0YF26qlHn6Loi+uuqmQ+xxUT4aCStnIUbYFK3HkW28uQBGWKl
onFZoJD12ywFE6S1TNxKIryifRzqUDh/mSxMx0SNg6snU2q8AG1ezSPOEgP6jmtqdQZfokgJLlu7
+qlBRItuqIlUQwIajjUfG/SqcTkNuZMSaNF63echtKYJVsOQ5fRi+oJsjQFpI9s7wVD7gx9bWP55
tI/pCf6pa3GPT3AQFyDNUP9QZd3SXahiLOOU8qjiuiJAR7XSgf496C8Q/ckIlKV7LEMLkctkMUsg
1cvITqtxE1tFQTKmGaU2E8IPcaIOui+Obb2GLJkOwBbIYBIL1zybEDfHbEYTPitHQX8KgsYkQRWQ
qrakhFc8eK6qFX+MOS/xDya8e7qYcF1/i68jxwPjmMrUX9pSnezqjpmK4MrVaK+wVCtZLeo3soVU
+Z8hc6kowdE2aFyD4W8SWELN3tu7h9FO9ULpB9sUV1ZULZIH9w1DnFcgA0Z7pgYq/rP6AXdE7PAw
T/o/wIwym5TITfaVtLJs1Sw/wCnO2t/p+Ol/Tpm0pgJAgqKsb1hDPnUeQm4QyYaIdhJ0AFj7tHQ+
UnxEb3MjWMvCCSbER8pIfw+k586+k1wUgT7zmjAnVeyPPMjoGSqLU40EXwiVZkb0hTYbGy+avvxF
rrCpXazx8Zmzxhoyw7YCkB70GAQzlxfhrkRdzj1sQsCj9VVxtpuj/8xTm+Ihk7iN45ynRasr1iFU
9QS2YZmlbqdAXE5s6u8YWxJDS7jC2KcBm41pJ0PgmK6leAqaoaAmpfsTzpCmtVV6H9k9Tl1XiEWK
hDT2yHZxcIDEHZIA7UJbKOF9R+vzeKXnoCL2u/ImPluk2W64Mip6CZno3wj+xf9lpekluh/L8nP1
fRq3E5E5Qogqpep4zI2Gd2oEwQu/BV1e3LW03u7gGts7NTDlKXy1yeIPpYr3/DeeW7uHO2zT9PTA
kpw6P6OAmGxCCh3hXMTtlF9sLmlYmYyvj4IA4/U77+twopIoKuxzkvg1cGLk1O38iSULsp+P1vOP
RSv9Wg+yTyU+JYU0hRgEqiXFFT0g5UITj2xDc/SwW/uDQi77lpjVH/40fHh36NZ7tGLr+GRUo+du
DXnUH7p0uEdIZI+JaC4tgDTJzJ/l5ipn/ywvBxwpAU0rss2W2XHHrCMW1pJeVx4bJGrR7yzC4xRf
nz/KSfHELCPV0I9MbRcYRLfgEhstru5YJSXw/C5pXiHWEHaAfTrOl0PvyhdHJtkEAOg/zhoPqHI+
x2qtsII9CT8kojwZNm/l4WHjXhQtezYPc/3ds2GVH7rqa+hHY8AsWyDmehAsokyBBzaXkDpCWe8v
k5ig6Bt+K4Iznw4s4OSfxip6I2R137jT7bCb7RVrioOEINkRBLiR58+0UvO5Jz2riCZnNyDFVjbH
UghznHWwrw/9RtN1hHohFSGsSrBbdkO/BwXmILVtgYqtPA0c9RaHv6zPcGg5E5J5eqCVNog8kSBj
Vy2zcarkzSu4Lj9TeH1qQ+OxWYUqgq8TB55N0wAfgnZIIxYr/dOy8NEN5k9oA7SnP64nmNP7w1ec
wT9//lMsHKBjB23/vBe3Yw4bD2nMmlXyDbBtHbXbwYdJGdRyqZpFyQMU4iqWol2gNbRkTZoBhFCm
C5fd8IMdSuL/nADxuZHN2PBUIpLIMKzZrx2SKLWMX5wSKdchS/5Vxuq6rKTQ3vWypmmgK4YzSh/a
MZEeEwRW3NEyh2Buffs3VqQcKsPWysPZISJIHzTRJFCu+GsPCw09JqWqwKCdkwwerESXBWs4In7G
Ql4HIsSiaYGmYN6ixVe1Cu09vyy7/vrUVS3+tChasL8IJpXcrQijdm03JjNOu5NQE9VC7twFPFHg
MT6M7RCu7wxkjxsQfqYitWSU1/6vw7zICn0+zeGfX1hh2/KC/JlZyWyNuuJ95yXunV6TyeVmE/h8
p1Gfyzna0eakjLcs3+gXag9vOxB6P7OG6O82QDrJVkV2wpXlIRjAH23TPDqgI78Lhzu26dgjX00m
drIbkKIVpdkwimiASRJmfwkVQMEACh5rczQrx6X2o6oPQBpQtBNstg/XuYzzfF5GFZF4HQdOp9Xr
zbOj101yimDDEXNLv/SKFJIBcYHiMQmDwMoluzPrD8rGMoPAmK8l28VULBqCVnFMv5M1cG3JEE30
otUMOTtnokpvS58YXtCE3upwU2h8Ky5Wlo8Tk1Gvpc7OFQsXfkRMU5HDPQj6YC3k/SBWrAYgTIET
QoUYBFhSwiT4uIgOw7V6BonZy84jMu+g6r+CViE98OIgzZiEEmAVNlx1GnKfq5C7L6A12p2GZgyb
JnLUEeAmus5Cmfd0VrXkaO+mzF3hI2o/HwNAFYduFidsKKpOVrB1nOM5jNyLXwuKCtFB1ZnIBa8l
wmQ5cCAhJj3+0MTjZHrAKYsbqLpUZLCMtBwzLqnH360pnKkdIIJazeiApSsUEYJHo3zHA7xkiyA2
BvWU6W+a1bI1ndjCB7mjoPa20Yc1l4/+lW1IUqh9OKFedt9EbM5AyFJRU9Bo4W11DlKtC8P6w6ij
DO4Cw1fDqnMGRizdX9ivmDNZJLWa/Ch6B+X7wArt+ujjjAABRur2uTx3WY6Saz6gSlWquWXToasS
+mcuKbPR8KscnHRcnBky4Q0OrHcAzmgWbg3vJ8VYwp7H8bC1R/GTWgJAceBxuNydzX8bUYHKloiC
wT7873Yb+Rxm3iKaAMsfCWLWJOdTg+U+uSJrKYFv6m+5rEQuOHYiY6B1OZm/Bx1ZKAkRuSMtOXb2
IcN3LAnaUVVnFjuwgGfvw3S0dHCsLtmLafNPx5oeoAk5XnVNwLOFnBEdHxUaZaNCIMTsT/56+L0C
Ii3aKrUJ+QXhqRdMY7C1RPElFsTTni7zua3E8bQYy0vKl6UN++D9jItmI1Mo/hScRpTnvNlVydr6
2xXureY18ffyA4EIq2mp3c5swWT71FLVrH7G2klhCXG13mZ06Fu+HITj/ghAXoPQXup3UHtVEIty
aaNokCyY7stCpFNot3VPZvuaTxG+SrYa7pPyStDR8F7HcSTANlS1FBRwMtRFYggK90KQknQxMNtM
RM5MxVGjMt5xR+UGKIdv5nOnFJxoLBFIqnKqXcffHI/ENZgNo/HhgWnrrmjIznvUlr2GRv5J9p8B
NrKBayljTaI8NwXL3+I6lXY1C91QoQ1ejqLLPhw864VixMN9OvRNQ3yxPHoeFGTP0bd2umQ3xpkS
FxU4ihkFFcjY5+FBUfN0AFYFgkP6IrC3akoE86vSi204qOFpMwRPdFj3FTqJ6EaOTs7hC9Ggp7ec
VZgebBkudrKztrJwSCBqu2eGIfWA1qdMyjfNoZ7RNCvUnOEMrMOAmUB7jdjbuLPyXnDqor5TdctR
EufbqmL0o16AdGM3NJqQCm/mFXal/DVniS1GcFMaxVlb5r+UoxbXSRscl/gw5XIpWSLnuO4eQ2sC
Fa119owFo7LIMIKOgST8LIpEi46gEKHZVLjEX/EfbQQYl3MaIDB0bKkJKHcJy9rjpO1ATeFj3WkC
Igsa8C1LCKpWhY40GcqEOR3nJCAByGdiQjJgC+tY8gIJFuv/SDC97nGVB17pIbzSK7Ah7Qk0UEw+
ar8RNfqZ77TYO/F+tw9/RdaqSMWQQSJXfh5uYrLygiIGgI4CvtX8561cuZCMEzCYCfXySHe0XBAM
GVI4++Nj5zGwBi463G2GNZX/y+gQi/gSes1sjdQ8rYpp7Jfbc4li3RPJJD4Vl2viaxsuxr1o9UYr
QkVIh9EDLhxFIj7PSMy33nlFZftAgWvW6GUiQW/9L5log8H9gfTYjk/K8bSUU/zMOBKCoAONPjVu
seKCbmCXKx9K4s3D9Or/E/fkgnT1m+TD0jnYUX/5sIrNH6dl2thXYZWIvVSPmRXAD6hCB4tgCWrb
/HyWx7npPvlJlCharblpuhPazfHPzvUEkpH31tsnEj/65Bjh8pumwJ+NLg6b5UcN0GmFjbE8CiwY
KCLuI639l3cdnC+CUNDmszL/tBvW8P5mZeKOz/79veMTIri3eQ7YVG52Nl4S4uiP5vO/WP4QX7o3
lOwe8cS9/mC302DCdTLvzo9J9Mct8B6TNgJpPIILfWPIBbS9M1DEzWAHLapjeNUljTGwsMbPYoIn
ahnJsAX/b3jriSPBIkF4EMR5LNIjMTTWCCRH9IRrTbrz8oLwg/YRrVL2ObgDBottDNuPTwIX+RqP
CqOyXknAZcuY1O1eH3yISL2bAi/uKyOeHCKBe68DhDsnNjqrivi5LH2CMN35BJ+7m2t33LTCI1i+
AmvmYyLcEY6d+dr4V/ns0FtZe4TpnnrGl+80N/X7Hfjy9BYv0DBX2s12IIydw2MhH6YNlGCcDDoN
4BMn0jOOMp7YjQ+3mP6Z7krRZeZlJNnGurHtLnr1/7SJcV79o7vPHZz4qPqUY2ApHlUdsMV2Lqo7
j/Tya/d2CK3nMZ0yH5/ARbVNj+2dyyhi9yaG1R481FrwonsbfwPxKbkEVcc2abtRm7y8NxLOyZfP
ltac8fjG0h0OP3FK9pzD+WR023P1V0ES6uj6QId3Lhgew/lotY8adKl9pdO/wfgAqueFW5ReHiZJ
7CorUb5ecS7Dq3eNIhypWAvAmzY9FDz7yRLkZNgMH6+K2+yyGotxVab3pr779h2wBYyRoB0aAEVu
M4Nx6ufTb70Z57N5w4WZhgn2qcy0Yt2pl7JoyEkUruXFrNPD2U18Lu0igFvk7MTHOxC9RncUnrD2
rXsET++iNbKrB50WpLPs3UsVhlX3jLZc5JfPQljpmUihji06sgakbhkuhcjhZQ3cOHYRkhonfRNK
LuVt8BJ0Zz4gi/DMuc/hiGeeLE/jQLBsWqSW05o8GVju1mmJs0IhyI2obpTlV+EddvniUMPKOfxJ
5SMeHTDp2YZHMDjMrCq8nknADyHpnFTuJSEQzdXG4krpHGyrecnaJKqyuV6yqs8Eghhh/n0RaBry
Vz5OBCQut4Osazd5E/q6ovqwp7cvysq0laLrFcpst+M14vDin9UphFkHnPjP45Gyd/z3ac739K4U
+QnuShOkH6Z02rI3X4Sim2dRGNkq/Tmtzxb4KfTl0AHq+MT8lM92e35en4AwmapE5b8yn5IeXAsP
wTQtJnQNjHFdgQrpnfFQCu5XvpiHviqJj/2XKlFYFUkj2/vI3rkiN/wd54bgO/se/aa0OmgCOz5+
b/q2hQrtPmUIkWIoNtt5DZ24bR1Uh8fvq3dYxf4TOXySerODB3BQFVMnITRVat3T/kjrZZqpw+BJ
ZIFdp+oLdH7EelPeT9UU4O6V/6yNFaReGYHGvaK0+zHY42ISiRdRaV8BNoS65vME5QVuHxIwHSd1
qmpIhK20yCmVm233c7SE8nhMhVGJ4/fIngAGiWwOz6XDwVbK4Ux4Qnbb1rYAyzPZCsDLwo4dTm0t
OaEAoUkeGk/xPLpe98LouiVoTrB+9UjjmFuRl6OHHtFPgCCTcIYGFTXMF0eJ1DBb7aXhv3xgSngZ
YS/8Fxw0dSWgySIOB1rCAWu/4QBJH0/m+kNQb9WhmFISEMACw2SQbSKR1dBubyeiKxL6GQlmNpp6
llE/3ci/OW8jxnEDrCogCuTMwMM31x3gxNVW+eo4yIipRr/+pYQki30RX4fVYQEAsdiffFYml4lt
upLQt5Ik7/YgRjaSx/lgKeBlrySo04M8V+9kif3qHgiAng2znYVpMBggEONXlNtFFzbxzSnRuhVm
DF7OwlKD2dVAaPijsYjsAGzUdppt4m8OV2N5418hUE0xLMebrU5SdiFwjQJPIqZotDbl+qLNZNfA
Ej9c7Sa6iB00Pc7PlYV1O0jb2c0rlCJSsdxydekOWRPa3ggUMl6X/5/dg+qPCcPJ2Qnl/ES3CWku
P1s+01w+r9Pazu00na1CH0WtPpZWoDvj2p/pc3/RVCeEdITDsoJwm2Wipf+es1JKfOoi4hvtvqEJ
0qcE0Wkxbhmj9l02juR8WXOmhkUFtJAaWG8xBC/9A7CQ8e+QTQI2K3kR/oTsrBTJu1b9G15W1r6A
652TRmCS2ywqRMf6SQEOMKakNYeZpLpH9O2XmNvvyX0vwms8YF3cAp9D+UMH9V1WM0s/WYQmBw/X
547yAMv6NMoyOkLWm3GXNVrwfL081VPPckQIXl7ZYR4vZhrTwYAg6KwAa7my5IgMLBLEkzlqKe9+
IXzY0/sk+9BOREhCMrwk7NosB59k+YV1NSZIiKSBpUPrlfBq6UF4joTG2tD6i4R6qeeP41VWpWMm
Gytw0+quWTKLNsJ1XraXlVHoXetVKWHe3ipBfen0GLuSXcZX1gQ8n7TY597XOQVlLC5MMJprP2A1
f+OS2kUurTXurT2O1PsAfy3N/BfLjiHmE/enXdB5zwhXoPW2M4SuvRq4qH3qeJYG/iEnZM2VIVmc
0cb3xbY2GIWKjtGC3Mi69uB/BrpXY9uKPLEW4ycCf30CVqT1YGoHuOa14cGO95mFnZP/MIkTaatW
TFZqELHxevV2A/4haZQ+Tld9mh5/e21F1uiYWgHMl5/lA24ZssePYXxSi0soC+duAZ1RcPnY5Je0
iIrk9BtNyrSKRSwraxSll8+5zk/8CYwEp68AFozQRbyZX0z/bfg+pVbx3NRxHiZYd1etubN4zQPE
HudMu+eS4WFF+E75SNyaTHZX+RN71StFKlCSXEDjSLVS9ndLjqBwyiQcJd2lFBX/j0R/iHrzkecA
XeBkotcLs+lK14DasuD1PqlQWdcGbEVIp0gCxhY0k6ldYCYqeknXDYejR5+5WGqUc11RIF7kVNpK
FZmg/9Gc4GYrkpCqGuYkV+RC84rUz/4V9uyTfUDrsGx/YK4MMrw7EwCPkbXY8Wt8jzCXVDflKZgv
r0ITHEkXByCLBq6r+236MLPKNA1vWTi4vsedng0Tjv7lUgE+GvFSo+mVONPtX/du2M0X2vT09v6c
dSWspKThoZ0IG8/E8F87d7vlxRU6CrvMsDoWbQfTPvDtbVPcobfq4l5imFSswdf/fp8Of138ZaeH
y06hGpAJmypn3V4Wr8hUARh6PwJZGCMI1+sazlCUWBlkd4CtkspjI93Yty/UTB21T+fgTxKf2W4H
RmKVLnamOQvvPC/kftCifGeeRerILjFKCrTd/0tXUdiC/CmOC3pyxDhj4kRkH/YUnW2IGxkkUCe8
7ABicKFX62DX4YMvdcJqbjXEb+35hhw2HZP5jk2z+BW1uKsaTpRVvt6our0QieD/4PwFXE50A7Y8
77vVVhqge6O0rpPGcxdyBDc5ykneoC+PjaZC3c6SsWtyVkMA0IbWWVUqGp9iutAA+m46syfWKUpX
o7SbfulcLPujNhdUdn1jXt4L9YK5h+qWTojQe8/uXnGLKZ/bd7A3eeN7ShsZbFr75fYVxt5x33/D
q7XfzIu70ycEPOzm1JT5hH6XSWYNzlBaTeUKbhrXjw0mCmYvCNJY1nQCAn8NS++CzW7bSI9BQFy6
IXMgcmErSOdy0MatBOTdjo2G5Qou9z8+TVSj4gXXDyusNXqDgNphYNZCCyeS55CDzaEdHZNEIgJ9
FTfhuEMCQ4VLrF0xtQ2EltLrg9spk6KtHwTPoWmHYHw7B7DuQRvjtf3uzMAnb+fMfTuBvlCYAJgS
esWiD4Sbbt/MLghfwRgkeFF0ssIHBmrcMMOmmZ30JtTC6DqnIlcDa1r6ia0QPMRStY97QN0So6e9
Lq3vIRO66gbbu27ounUUCHQNN0XYIAY9/iRKC8rlfTtVWyco4BjozBKHwyPd0DLPlqnedJVFCxK5
8rzVVIZTvMeM5Z+KEHSlLLOzxf6u9L+eqfdnLfV6iwewM3JKcBwyap6mNFsYmuKP0EuHJ/aAEo8z
EixEf+wg+cYBrd3F9+b84AgzJzliJVfW6cVX55XTP5Og6PcojzBDYhfPph+3dS8fRdaxSFpZ9B8Y
7SrtDxvzP3lsJQeLh6N0rJgZ/Q/sMtg+9e7ZSkptENoHUJHEuT9wuOzyQHH3ebBjJ8HAlYEji0r7
uZDdPCJdOrM0iPRNLKf3MYcL6xgjkjrjcl2DtP/8/xqVLxI3VmBy75O5DMkSx/HWjD14Ti0xKkeZ
+CUovBxM+zsm3JKNZny+5s7QXOhIU8UDV0b+dzB2UBcqOCQZQ89ZKHYQL82oFTIwKLYbMvFkQ1HG
5iVb/bsAwsHYiObrQWbKo4cPYodmQro6UCDsvR8nBgD6Vb1xAn+ATE4vjgOpps5bw/a51xJ3/gWD
UGWz+7faG8YjhL/fCmiZaA/PsAYe8ScgroBEMBHhR9JOm1hbV0wMeEzsPFu8NntEgJp6YGd40FtE
H9EQL1O8D0MNOyeBqhHLHnHG0co8glo5YlTfDhMQtis9H8PZM4LkhQU7KthXXYGnJdi75Mp0JN9d
It4r0M6W9RnHD9O3acEuaVD9xZXmN4cESSd+8PfOYy+hlq6ODLahwCiU1V4qm4dnjYaXhGvNepxC
hUKEkihHI0skmEJ07t4CD1BpRL0pyg0dsnCmJMUr8vVaWUk1d1jtZlopTRMs00gfzeWa175Qb/7r
t6fznsbwq4kJnNfYV555IqHqofOu/wavub/A4of5LQy4aiFVD++PJ7rd5Rupb7T2MZVryKl/LRWc
PKU5QIScLMlpiTY2u8w96Al899VEKvuoeDS98a+m5my4PbdD9xFKjKEOkgs0TqrZURJgm2Te2+LF
s8/+cG6KtiIiVsj+ZgHxneN6C95IJNBWYKEhqock5HuVueYwz34dbezHmW8hSDReWcGQ+SjanCop
IEi0k8wiIhNzCJD0f5fcIYu2D9hhFaB08UW0u0D9agttj9MqbfmL3T+CKeT/x6NIRS0k1nrtSp29
fJDYH4wIwtq07yT5wVWuvZmkMi1BfwxXAMyBqNrlv3fb6emhPPqwM6xq33kOWCT6UR1zlWxAm5Rx
Skq2SehE5iYKTanxaAA7WMtWpy3gSpsea3ka+8YsknUsaYmSohPmogaQN4+R4/7Jb2UbxY4IwUG+
Ed209H8s7GdjjXgxT6Gffdmkr3OJ8iWT4RVtQq919FGczAtLXAyDvnnzmWTUcRqqcipH9WSll1eZ
xTnOB1cAlJCvC6na6Q/aM09eu4kg8WXfYpgVW52E39yHQytft2RxyNkUrr191mYU+0s+4Jdzyvdu
dKzleb2oYrTUM1SCQZYwyXGOtXc8owy+Jjuclchue2vCdKQuoM6vad9tnjE2qE3/50GoZqIZS4gL
g9YHFMr5fTPUqZ95fa1bNARidafRw+mgmBdBKWKElMcOAfFzu/LrxwbskMJWiPRx0dBz8MuD7fxo
VWWXpXXFwjsqAixrSPwXflpS5Gb4Qm0iFG1duONNAwRpXMXvWlsQWfM+OBH+SBiYI0pkA7IXTn8R
tv83P7J9IOIN614DG/m75kXGFcWDvQYYmnTR0TUDX7L4vGiqmk5uA15/+0CLP1q73Y72PLXK0h3v
Punfw1CZNZhb8MANZ9oMIlBnl/NwrWRi6PdTgw2fyvh/DXVhi/nf8E5/8IgK/szUxsFF1TYJAlYX
amVRCI8po2PNEuVr7XNdBYRpzegiowVrN3K+e6mZEva7/AoPBxkNhzwP6j21TbkKKDTqx6qhFDkn
/Ma1LX6R0DGdMvz1lqwXxDj478bm5dSvLK7vXEC6uq176oef7IVrPZbDVvcIV91fuexo8oDjG8OV
QpoKH6OkkdZKUHlxyE0hpTeWIDvZMZQZgNz2FBGZ5f6NrTNVsGlI0h+GQ87AOkLNkQp2aeDlMlAh
NXf3At51M2uuuzTNu0kLq+DNJwqFXIRxwgjSOayoz4cZuRJcrdSjQQWNG+dVCRkrLXhADIyjSX5W
zqroBg50TZqn4HsWgrRXPkMxSFvqh69i3voI+WlGnXHhnX9l+zP+9rlwKGBQmswKisfAU9RxF4xH
hkTikj1cVm/Xg+s6X9Wdgq186T7/x5rcZpQlPDQVNRX0/h37oEt6ftKlwMSiCFQ75R0+C2hyPH+T
jhNIhJ6V0unNhTJ7ris615irojANn6O2ISEbvFGxePH+y7glQlnil38cMVULO7F4fEsFcoYpoRlF
dwjlbBQfSPXZ40g1ZliqlIw9EdS7qgaRKe7ep1A4+rRGIYqMch0y0R4uA1f/RtT9Uq7bNHX6AjZ2
xlx4tuB6xbkK7elW4opCPwiF8YcLuynARLB6U1yyQH38ink1kGUzo6LWbyDBS96KevldavCiPh0z
6/aLegmXlw2CZMb4UTVhL/mQML4cE2qBSBNWdTqMYQ1V2WcXQa92syeIK80T3YZaIPrqSn+IKs4G
CtAtlRq6+5ddFE0YmXghEObVq5wPACvrIhvZLmg5hNIdwiLjBT8GM26fQ2ea1KapIX7sqqr6O06i
KOZe0YC+oHppqY0sQiAU3ED7ql3deZsfbPEFrkZlyEI4+yv4Liv398TbrLjgz3oUziXtktblwuSi
I7rsR4zykEBLy6Me3p5BT/cbWXzmvRQB4tpqruV0ob0SUFR0CSEARzwwhCpq+79G8TLVgLC5btVY
G4yn6aWp0I+Q4aVlqNPXl8+CH/wyBafEfHSK2uYOlxHc0Dq517LuBNuPWkP6uJxvQlTMQvv+zHbe
aJLAyeKhYA/NcfSJjaSm/cfixsHanGWmzoTe10xZ/1afV+fZUxe6UCY2bVRKrMUaL6HJnrA3ukOF
gb6ztklXR5RWwCAewYS+rdPafyyr7OQIW2y/Kzu9CQpGxo7yRZYKPiJhxIihphYoFzsgzPCbzW96
wvEHIWJCLhtMV88z6emby/NIGX34WZz5BLEFmreRgrOSsN0AvIOjJX3Sf68YeOYCto2RWh8IXAul
EO5XG//QMqKfqQJWecIh2tPC1mx1GK3LPBNOvsyV6nWsgJlUB6gxSneOF+9nUSFG7QaID/RMP1Jj
cy5d+4L6tT7l65n4i0fkxBG6HkyIuEgKMm+01Mm6xJTzEX9Pi3eqhI/Xt5iELPbbpZV8WoKxKrui
hTuJf9j5AVISQhkYZmli19elfjBTXAHhmHzPpFFui+oN1yI48mB3Z1OL0ICTDXIn4ZmcfX94fJND
lfN0dmNu4Q2UrDafzkKH1MKhLOjqSMpbzWYgaOrvdKDUNgqd4sUrd3L3Szerd+Qgq+eDmHxPniLP
mXEQOLlqFttyrGCsIA+yNbxgyvu/k+6bADwGc8hKFMOBiKR2pAU27OVyO9X4UngqESdfgPWmDx1y
Y3yUwQbmOht8X1+mSwoPi94O0uRyvzzWdODubKCHgm1TMGkPbEpvlN4BjPhVz8GAvHlGrP3fDnGJ
lZLPoY7JScgFhiRHsDU7bpvOkC0P2+gJD5ACHAYr+5Rs32Qu3fbulL9ectjj0aQKy108Z4hZrf0a
qRLhEmVT1iC5Rlpke3PJddm0YpBLQebAhPI8hyG7YIFDqeiNp0ahpZRubaZh77rL07Q2UHr2CCdm
G/2V6IWZdBOP8YirB4Gqwqt4OW/ymsgGknNlwSInDwCPMlQKtVSRNc+JV9PqbWiEVnWjdHxgt3oS
BR1cyPbC0DyoovXQ3EfgHFxCfjUMXiHpU6iVPNqidKLUJtfTq8wZiTpxxJt8PhPCMIzVYX93nUU7
YiJs8CTDc/+tLqwsDpjsVsq9YUeZbuGQZAAGUpO+2Fby2Mhu9BbGu1ezh55bZJpcsDiduQob6ABd
kbSWE+foDcHtzYcNaFuCTFBb2SUzqfXyEIBlCzpsmmAWSy3GsIx9qr9lp6lNSrCpPIjPSdcLf8iV
pjI/xIwdmRkL7z4ZhUkae4qHL834eSVj78oUtXwXXmBsOaUSbnfyP9Spf/Mxm6Eedo2KaS+Hw1gQ
HfBsR8Uf50OPXMmNUZuWLdIrrZUyPl5tnDuJpVgC0rwmuvhGkFzBaq/F4h/LvgeqG326Oo75FlS3
mJIxzGsbQ7kkOfo50zDJupxQuM7gsJTXPEIZdmxHjRCKWdvxmcKjctWkeq3cpZf5GMaVHJybvmyD
zDgT4GC4GRMjTsJSAq41FU4y43h/bt/UNFd4trdWc+oSzeAAm/ptndoPhzXgV7BiJfndxkH8ua4V
O0Q10pxAmqsggZy92qEFcMqRPCBI7mAuLK8L58SvAQ0cEvekVnNeeYkCVrPjfXjJZ6veuz/D3wic
I+mCxYWoxBnYVYIVJHwHNqSDyOC66IFaquDl8tJLnXMpShLcs4L8c6PmDIwf+zCDaVLVzY5AO8X7
9+/cWqtLXHlkPyjOPKJ8gnsjMCMPncw6y5Y7YfQtUhepncQb/gqD0/0yVbR6VANdGSCag325dh5f
6bzDDguBID61tN8hOg18WghPCUiqWKQNDaxzTf0mCQBrmt2JURITgQHxMgQOYMMXdzzen1FR+W0C
jID7XPqEW5BjEd8ruAK+aNO+1jPKuthY4DpTYy48/8TrCMdKrh/2L3jBg5dWgtnixmVT8BPhZ4TV
nJCSgRN4wd7EuT5b8KieS9bEpSpWOiJYojS6WKEXQyqyOqOyf9H1vmBu4+CBleSmGzbHxL+LdqmJ
mKmvZ0kEPyWvKcdcASEcFjuzeprJwKr339VXq+F2P3GOwE+pGgGi24RI78twe/4uakaSBt5unvN2
xS37E2gNI62oqSACsll/HfvRm5FLwsADZbDVfq0yEO3S9MPcCdt6Uho9q9wVVVvSoMoyOrWbNoxE
VzEiHI2q75STMH8tKJvK2YuF5Me+oHBRapQ5W4vKtrALvMrznzoXmZ7k/tOK+9XT1SEeY095sqn9
H7otsbX8ADi+2+9YcBuLDPaeyyZMi9CfTRFZ2HPuPnRhILju3n3YjNm+wNu6pFmSG5/yi0Jd7lIY
cR6IttTlg0z5BJskgeuaSUdzhYoNgc+chSU2BP4HYvGLCKsNkHxW1QTxWHjYGCTf6aMS70Q6Uwgv
LAFjva7c2WxGq4Vj1A6ybWbL1AeVLCHdZC7RF48EvkoQ2yyWWh6mOs0NC1R7gAnsNx6thwwgY395
AvKqJv8BsXbCI5hEDFLD6EW2IscFFMxQpP+TCmS0icMOxfDCGp/doMiJ9HPjIulbevggR1bXp9M5
gAoSzgR6uaNkkDhJ8GaJkB6wT0ZeyklDN54HmeCImJDl5kAkIbZftuacFJvFwCbntQ0NNfKzNGGs
BzmJgw5qJV/0jWlBpsg0IKH2aMvjJpIvOOy6son/mj+B+D1Db9cVEJu9oNRzNWAXKFFSiORA9UFv
52jyMOa500if/Vu+BBs2fSEMnNZea04YSeYK5x5U+RKT21nljBt3eKGo6Q06UDssSHfQ+bfShJ8J
RtLW62D0uJjGVnk3VRD2TGspz+Mdp7a8X9CSCUHOLKP6hNfUerHCo3amuqQp3PyKPVOgb/E0Mh0L
TuR6I+5iuEmopXssugW3xiemOhGBw/bjr8V4VSdpEdwlTOpsmNSnTrr/g+fq5vNaA8xpQVBVNara
wbu4BOl7GvwT2YSKGDl/py1JuaofMHIoFSCiOcwsL2Utn7/uROdvIwFTXFzB2h0BC+QOtxnzhJWi
XjdhJdzxtL8+xLqfMGIIW9aTDwWsDF7Dqoaq+dQaCF3dp/0JehpHkV1QdppPfuqxGdp59vm+/dqg
1sAqtq1GpexMHsgoJE6XSxFh027g+fkX1Ep71h1OdkEACTcZiuqOSZgFPXcXe1rpKqoiwqI0LuWA
y2xyipmpFVdIF+BczNUJdKiiH0xN2sGx2lhBNUdzDzAPSpCA1dY8Jk2lU6vkF/NtLuQravVIteqX
ktB3dZeVLODvEagaEiJe64Fy+YL2GwAli3E0XJjjHjW3XMMc36DZhhLSEZPAFpphi7f+V9Rwsrj/
p4FKmOT8kSWtJY5mg/XKkRpedFYtOKN6aBCFi5TjrEIDTv5BUJugU5qKxbRo9xejlfvNiBehjzFN
sFErO1aoDAEmZCDQhX1S+WHYlk43saQYG4VIzgYDLpcfKaf6Pr9g0Gt7EMk9eRtXcAtFLOQUAP38
ueoA2YyYKy/s4aOga6boxJUC/FYMV9Pt8HbCwKQL0pQ9c9onTFWrT5P9B/wPtN2qM6qdAO83Qe6o
7U2Y0AsRNyw153NL2/7VVaEPGJwDxAQaqM83xAdQKaohaqH0mlOHgwZHlzzws0FfrCplqfFSoRFI
d/AwBHHkOSAtnMtlRNnr9h7TeBlcnjToQc9/XkLwB/apz6iJfWdKs4r+9oLHiVc87OZBpt3ga4cB
iPnhsbkankuCc+IxQEzipEq56VHWgsdJGmF7TYSutbPSpJyYDkc7vEYSmQGh9fnrOmNJv7rvnYht
lUFAqVKG+5HJwLVg93kaI+WLlDNLUIMEZssGJxOodF2mo7yoxCIKUXJiGglsWG4csGVfUtrMXoFG
EJop+1uaID4D9vu9DS8EGLnhztfqu0JiJyu1KUsi4G2b9S5y+Wx4vJfgaHb17RMrM9y4Ic3eqfcl
U1DEJqT1Htmq7L2K9yDtJBnnFQyLxEkeR3P8yv7dIQIHPJbTpFeG+WP3KsMB0UEwrAp0Nx7no9lm
iG7KOTHEH6q91eciXBdSOMtmD8WPBKHB1TXzjeUQzuQknhGUAn4X37P8QGrSZQjT3K1SWToRrssV
u2yaoU3/vJvRg5Oc00rMCwnNYkmDU/x0HpJiVhCl2xM67w+1mU23rb3nG/UxqN25B1+ZLb/SfXLi
nt71EPlWg4lqmDwIwkeG97j6jdIaGlqA/ovm3vTT3FZ+SJO1OODf+aROi5I9ZTw03+WYv95tTioc
3uTdXXUI1B2qhBEqnDbQzfG0s1vUmfTZy5Cby5Eq7tt2yw+Q1lhQi6epu369/Adtczb2l/+PdNil
jwMvn9ULZ8w9+/9TXcvS/T/p+Cy9wLgzFuYjoITvRpXUyxfEgS+RACt7IHTiywavcSflIZdvanG4
88LEJBGM7CdTj0ICOyIH8bRtEVXkQIe0HLdpaf+WYkdD90KrUwXmnaYesIrIig9W5RXMiGoLNzh5
pZTdUedG0ueytDwsjxi0G1VosAyoVdJl7F/tIrdHhhgSVWT6MviLVzrLOeSjMXFnBAPXFOzeqqQk
451POLQnGq4rD5M0VmYY5SSyZ8sYyGBP8Z3O1nN51gPKtdOlHrjkB/GjX2eyqj0CT1Jk8i5U901g
6D/AjfMj9BieOn5hLys6kt1mg0PMIefVAPtJsuiKI83bAv7gjxo7UdcBwSqJzyJeRW0gQ+pivKGt
z9QW+9y9rpzZ9zyFq9H03pwwonZ5wKU6OUOLyMJF4OyuN9pDj40n6AxkyYvkTAi/AMO2SqF+awIf
d5xs2Ybg0F8REJ4n6jBFwXvg312GcQnJspmr1PsBoTdGfMfCNdSERTW6+ATs4RrcK2D0ezLWlX96
QEa+iPImr4phkpwCzPgkW0xyIaWXo5Jngjy/7uapB/WGHkhkVjgVPLn326VKosIBJm+akXdJSE3X
hhpESlOSZw1Dojels41FPqzHtwPWyzUyuwMGu693X5mshZFhgb+R+KIW7uUeUqXzATxWPwUie9oZ
1tPjAn3kDIeY3bvLpfBD4Zi9TJAouGohukBwieaRcjD4I04Fg66iT6yhBCXUyAM0fIXzBzTU4Qb4
vukd3ZhYT12glWRrsbGvnmhraQfXef+PNBumicbsl+vko80avfV9VlIcAy1+7KmnuddvSpeMK42S
AGwbSlp5YNy0GlIK1ce0W+TOt1tvYMyY87IGnO8z6sNqfEhzFm7Da1QvHmHMUTHvI8tUgroGHqXs
5Zq3m8LSQV6wOSMbN76qJ63fEX1K5DdZoCCSIVX+bINJUoGcSv66wMjwMn2Jbl+avP5nsABljtAI
3czo0jpC6iXonez+FQ4Go1lPhhvgXLoNMkAG5cm2EEkwI6yk1FL01t4E4XlXmYiORxQtxapNmNcG
oPwxUuozDA5EOO9S5+ahAUCa33cEqiruSLxDU4A+IzYVmyvjc+jPhaCu5ShovGO1hrZehVThZNlU
wmKNccDatY0mSZIvOnc5wLd3b98atwvLbo/VOr8d2vHH5G3kkJEZyieDiC6Qkd5bf0250OM7w+/W
qBjGIOq1AkyGPB6bpIAvNox1bNCIVyBJE1114QM326iyGCj7uU9OQpM0nfmOFJ2ooOGcmciVe2wY
MPNMSB69HVx9QJuBpZlJWLcrVYh+v9Kks1LacPBAKLMyEqbndGHIrKy2tSqQ/EV7ByUDiWr+momq
04mFmPt2sJg8CGwTD7dIiOyxQwviicnEyJGLeoMEAIm7Lt1wG6L72YDdWO+3D0LnQX6R1GocLnWQ
mKosJF5Z0elCtV1NY8K5BSBTjCDmt1IAlTFpPfdgIW9KfKlTmS6mPjp5R5Era0nZTiTCwyPtdghI
aOIT19N/Y5w3TB9AHuA+JzRdLuzaBp3sXoCQYvianKk4fb3QDwficd7Pw453x27tc3I3S3y2DB9N
4XH16SemxxxYTrG0haJYboMFFwKkO/opZ8XnMxFIMOwXYvCiDP2xhukixJIceYXMvQJsDg4IE3MT
oFtKYaFyN0hFPz4jO4vMVKqdZfv07H3tJsScSCMd8hrA8HviA4cEiEeC6i+Tv5u03+D3AZk/5+Ja
Win2HttLf7eHB9KXTYqeqfM8UuaNF3GDe45U7UpG5wTz6C9SNEiVja0bHq87ElIGAgHyweW7WqZ5
gD3+rsTGUTZq+mD8g5fCAUoen0zbi9GJoIij6JwxuOXOMJHlqaeUJGyM0HfGyVtz0EwUv9/IkSs/
bmTh1JhazeazV9z90csK4BKppb3P/wM9pC3YAC4xNr2J5yMy+1F76RYb6uLjjmd2HHkbsKcT8Gnh
+i3adPRh3e8oxmIMHPEmaxEl0YeV6pV1G9BCCblWVoJcbSqjbfbl6iVRwCS0y9y10AvW6Ug93oZM
6f5cvxKFJ0po2Z1Vxe8JhVOPQt9w1mL2L3mGCXzRVIMpT4Bxu+LV1Ybfjn/Y1iFV1huwwg2/v/9r
Fla1bZdv/hF6/q5lHmz2EbTvv36vEIAFc6yivNQUlWNiVikVKpk9fMLCzv52KDXvOr0sQp+Dz6c2
z4ysopXa0MZ+EQ/fp9YseyfkVfoqQPxrIfNInn5fAzd9zlTX6aNmnGrSI3MGS9k8RR0q/W7mIdi6
jRRiQ59ZPKZBcrU2PvngYsJ+GPYARaFRRKiMdND9tgiKhYgFsGgxNkJUmazw7dVyLA6i0eAuNyp+
7t2+Bhf/RHBDjqT6dN6nItTPSssE+PsooZh5+8mB4LcxcHHbdi459V6Eg54U4JAuTRxu1mHXw1Q0
jriHwyO5Z9r3jyAqJ1cfEKBIIrcjYIaH3/YPbyFE7y579L84kQQHcTiumIa9NU9cNdTCFbD3d3sJ
M829NRrDG8RzIx/8HYfJKSrAilXhBo9axwYjyr/IyjbvpWVtw25KicpeuuXqeCEINkETkOl1SxlB
QlYNWiU4cK7MNbbnu0k5wdkf/o8C9n6SA55RxibCFzlXujg4CngBOPk57SPcgHr2uI9I1O2EgrFx
x8l8LfdMGloPXXX0eZLb41IVcDht3RMtEJONYROEju/lHFy1sJEHa3W+0PLW33nFwY9Bu/y7XtZy
UTQzAjwsSMLVsqy8NhBZZ2eL1e7D11jFJppGUJzlridgjHrShQpk2wdz9wCyj+jMz3LQxqoOm9T6
vTWl/7jbNnP0a7J75BRr+oKKdLzp3uihjdhZPZge0NYkQoUJCTqB/Xa/W5wy/SNcZLJqxVoS+nB+
OmHJEWLw0I9b6syF5+K59Q44tWYz1QC3EAF8T9Cqn4gMyviYFm09lwoa9i1XlCRbMeoFOkkPQ5WH
DbIlIY7ACWTFdSJ+fBteIFpkHi/n9BI89/ZFQUPhf2+Q1Ycz7D5K2miCFe3vHcA+UHICvYSHTQ/D
xJkurskFqbhnETrBLK2pUm34iOmt2y6PEJJnNxfK6Xmml6UKxr6voDnShJGzTTbfMB9Ebp86ZXXZ
1Dm8Mc9ly5cUpRmkEO6eiC5min6amEF0YxUCu0fa20gWOEFNZqQOeOaHP4KDx46Y9z501oqb35Fc
TCbCXB32TgmWp9O6LUZzy9BNu2R1K7ZfCq6o8OZRpCHTIgb+l9jOeS8OqEVmUEi+YDWW7HVGmyTb
zmpQo/LhiY+YM5vZDxtCKtC5+Yxa8GO367cEZ2Ksnta4RbtQdAO5SCq0/0CMo45Wjqr+kQnawSTX
TQFkPIIN0gpZyjZ9PeQSTv3mupb531cGx7tLDDnsk2x5XlHUGGbLpZW0ZRTE7LKqjSukLM/Mok4B
P/5WS8y14vxrn4QWg/EXLa4dS46hR+B8/rutJOo6ZjueYZ82HhkY8qIHe1vBDzc8Gvj0LwDE++1M
oy8D5XvA4JAbw4wJ3PmTj2XEFqhBcltyKuwipUbihLYgyD/SgvBJHl/S97AT5dm+mVj6g/eeywxV
Hae/5PyfpNJ20mQtHQ5oJCiXV3Do7lgUw5Rvm4CbpR63c0ZHk8nz6aXdHi9Lwy436DpZBKzeLdqL
/LMiYhaCigAqiftub/Pt1gn6Rpa5HxXkI81K0Fy7r7JdCNcfJQpT6lvjA3vo2yyRxKlEMopLNC2r
v2gDc0JVdMiS3fs1FOFOeJeKb/ZfVKIhSCq2Bb8GYWeKfXC+3INTxAHJAALKhpHfW+4Gd35fQKTr
lohqsgb1uaJJJflxWBNd3sYzws6hrSoR3b8FQL98GNwISJiAVH89MNOhI3bCOHip3yW9TMdbxjRf
4Z8zP7nrL3u0z06M1f6yxCn3Ql/BbppWdALYcUD67Nc22pPrJVQ+RmCB4I4GbnaAvqheZD77ylQ1
aGn2whAYFAM2UohUokIs7nwzFDeq86aBnx20UlnY+RQ1HPLwTqoghPv+ZDoqbNIZueaQ3ScaxSfy
SdDRTKvzqInUJWgrJtIMegPGWebgRoM4dXzjWwUyX9qqBmAVts8aDgV5+sEx4uPcBMHV9rOGEjLg
D7OADIibnMbE6RsAoQ/aotv4q+mtZ/1evltuP3QTzh+wJdoRJPwFxSRXWaM3DGaBbAGAZAGIi5AB
lcowG7PLQli8KBSVtUAHRtmxxYiHAJBATaLztmZRLbfIJ5cUoW011QEpFkFEbNeCYXqDT3SJto2n
6Emu9JbCQjmNYLqg6xKm+x9OsjPMJ24Sa76hXeejRYOSpbGzcxqeiTAsAN026zO6q4zuupQPJ/WP
2+srrFQungkyyeC0lpRSEZKiKmyaVzC3BvYHFhVPfUMmexzr7rTdyRFLJTFeqpi296WCuuXSy3Rq
d7MuZI5V3DyzelAzFWQ/aei9C0lIvMxs6kHGKTumCx4JEcBuU3Fm2W4FyMDumMTCXxL2g5eCek1z
nmeyGkdEnx5i/ZhPyv/ejyYXQpcxiQ9po0B2aFw3RUCTbzdhArYhkAmoNT85xGaBfgjbQIuAMtBF
GaKmJjAhJ8nA9QEoDqfO8nSl0lOH13LVmp+3DjAOpTSkpJ1feNMXUaltW0dHvZ4hfY3sbnZo9t0o
Qo8SjhkOzMmvEENd72ZVanB8lX7YKJddkV50qv3u3T8bYsrR2G7jkerGlPY7RhlhorQIGPdRNpFt
NrT99uMY2U5x7eIQLdeWAXJcx/Ue8Q64I2Cur3/Qk4kRX0lbmEAzs4wQyckzEZDRhL1Xu7n1rT+9
npACDtYzmHi1I8hhYXa+wYZ1+BZJ7nplk0xzlegSf+TwOC2UCna7/1e3ztgv//g2WMUes2lD57Wn
j3PBTOoGqrxlR0SDkTzF67OFnCmZfPthnRA7l2UQ1x0yR1ZpLdrT8t6hmtbTSoJdrTFV0rWU5PK6
7Hb+AIRCbUIoQLnaKZvjwgeipZvmvZYCndGI+35/k31l9YZzkZ6dpgKYK4jnLRHyOJriVt60Fwkd
HKnloyMJTU/gmd2jBFEijU1oWKbkiuUI0PFs+fOEHkDzlKqO++GYS/G3R9pw5vxrg3faJq7tzsxR
2ZwUasmEJcLhulMfxCmRuO5n7R25AIoipnULZqs4VXGdUEhqdRpRzeiJHfidtS5lF6V8B6DNDfGV
DKr5fOomYaXzqm1lQIdLlNIiPK5GYV0n6ftpY6Ejh7ijsgs4XwxPwR7fiK0pfY7YHCLsnITuCL1W
ZiOAtPp3H4Ru/+Tr+R2WQcFzZPZA3cIQqs3smpECZQkN4Rj537hP3FGeES1oPA+Vw+tlmHn0hd7t
2/MSzVM2fXW0f1X6HsdTFg+G0A4PwpXdrJPRVP9loEzQCkSr9v7bQKlHMgVHACI3jB6lgnvrkl0Q
cHtqSACXBmnOYNnNpv9vPmHOnTLLHajZgDB+vrRdUAqAFF46g9NS5G1koowkdPHION9Prhm2iOCK
a0TNO42Q0lmNrCIDjz1gH3PCAfFAwEtT+t3jS87NDT1tSOFaBjLSko3M5CTwYWmD/k4ZvEanVy+A
dbhsB5SG9IAy/zaE46NUrWtF7MitBD0op3b1jU0irDLnkMcjHpwaocI7k7pYWo5dbUqK/rtUERO6
etIpwpeLwIuQYbItBWT+zit76KelAm6KvfH1gkaylPoYJpqVXpV9ltF6OLXPzQlsT7Xe3hAgHfKl
pM8H7yXaF5ElF/Qvb/yj+k6GQ52AJ8Ts2rXu8nqequ/+Pr+xKI3f856FiCxWTArwg2hB7OlnJkhY
SDM2b/uto4lOqWBkMfpbKwGamuECc0FsbEXNtvvH+qh+nwE96Tg3f2p2l9AyDgl//FIZT9EVI28z
2GonSm28t+CLtC7OUKOf6C2dpf1Vp9+XavYny5m/C8GgH7oSmCFjaLMNFK7o0mKbL69VIcpqPHMf
xaZ1t9CEOoDb71YXQOqfCoVxpLG23owwXGL6Ta3xkhxflMAemzjYeyHSupZBqtmMPMJTmFtOuWgf
MSRDs9C7ihl+YwmzkTz/VMy4w98t7EwnPkaFUVQ+m3TxQlaX/rI/uwb6LBSkclPpVyjDVaAHngyq
NBynoodEtBbv+3rAAPVhWvQ5kdPOelBIzlNHxg7J7R2kk7fo4271IBTHhWFxFld358w7enXzNul7
kF+Tb0d8Xy/8kxkrXAaNq4kr7eqJ45hBTTDKcMef9X5MWRa4w2iuqwTPNiZLcnmo4KynnM0i9nhu
ssM1FY/fNM/O7s7PRpRZ0Cg3c07/4QUDcyLsulhhK/KJyBdmL8QEoRNuN0CwEIvfxm/E9WN0PRs4
GQoiiWqByGkKxASJnir24imGbtc6qrvMz/bDECdZiidt5v8RoptDQOF2qqyyLt2f+48CnnS3IYhH
h6v5QHecNYD9T41S7+jTEBCU7ANUoZnUlgdPFuSa/0m8hod5UiL3u8Ahy7B1cB5u9Q1VQ69HAKVO
ouwH1jmD3AZRhD/2Yts9X7wknMxFqDwc50Ntx4UrmKiuFvzYeYtevPQRZITXZvwWQVkTTTrNJk4F
+sFxH7q+c8ejREGQcbHzF2GrOX7XQYw5cc+L1Pqx3b6v9AimTX4YtVrfnuxg9lncQCZUTxuKIUaI
pCIWy1YRjalJzSmdnBij34BWR8hveh6IMWl+huoWhtId0PdLAqflrfd3UC3TjQ+i939Y0G0n6WrC
miKHq5BYMTjBv+8KjLV6vsCw2d/aHd5yLUb+nPK08YhBs4yjkIoees5vci4Zg8to1TVMGfCwIojb
x3+Z/X/wNGagR7u+13I4injjDfyKAmcGPUXQe9w570w8GgzvzW6pqHAT2CQQv/sWXk83s9zhao5o
f1ZQRZTr+8/m6V2+MRAB2jsAR4FEH6wrPLxuk8rDzv9QN3WLqUs6h490jwR641h0ec2kQ10XIWif
/uhAydAl8eSnLlIEUHkey/9x/dTc2iqZhUEzkp1WtR8eBP17aJVA1M3viA+x+CwcBtuHiM+FfAOT
A0Vs3QGBJaPZALbVq7nSm6jIMS55SaVNMt7rt/baNlhUdyTkEpep0mwWdE7qYK1ayyzFnJkciU1U
NrdNUnYfI10hF7EBNIjzyBtrMNXq+XFWSCPTHxrKLgaeDp+ySGBFOnSpSODEqX8XuOhQAxlMmUU8
C3GZoIiW+ZdaRyS8xhDwVqDJnagfNMSUZ8OA+Q04Qj2P7E1jFwFHS5IX33vqmeDgusuG2jNqE+f3
zdmbeHiM99Zye2bn5NDp288ffGNcgK/Z30UEPJ8p9Mudxs7cFE+NhIscZPb6fGg2AXfGbI9nZYyx
hwQFSkz6XBRG7PXQuYGyRrBDEBXQTPyPOxzYsnVvkHDJLFzkmsKoSXr4kMOlk7WJi1jtP5lWO0vJ
+mFLxnuBacXcSz6LpAG28TJV0y1KQWsctNiA6P8O2GrnyJSM9EqORvOdTeZ8tzMZzSWzenGDaaLx
VjFMukcHe51Y9EvNnSrNPSHLPIv3zK2TlSeV7UwSHBObMDDeidDmPNDysO826p/BFXYy44cxkh6R
kOaGmBvzmIMwAB5RujieVeQ2wr8k9vo5OSs6j/9/L2Y8UqohnZuy3Fr+EK7aq+mRZJMhF3bLO2KD
NI30TUUHjAH1dOS87xa/O3qyi0Zo3vhMaNa6n0gpPd0m/wlW2Ljs/86Sm8pzoNA9dhMm+XQAfkHH
sIf8RztX29Ul3BgF1X527eI/V9gBp0KBZ/JXAX5U+dbrcioGtdwo0uBFFy0VMyuoRvtjcMgOBCu8
P/93CvWhKMMKvd9Xu9FjY06H5loiQvlGw4LN7UTH7Ctl6+iFuanKunwxn/6tfxrbI79JgJIWaaSa
TVRRcf8+lJSxhBAYQFd5o3RpGwqnimexNGILHT8pgbFZg9D+qsRXAhFG9UPK0bPwiugCHem4FdFE
913H1NG2bDKf5MvKwTS9bjlCYwn8YqnJJ1gcflABsCMU+CE6BLW0CZmaUkspYzDjZYSN/JbXjITR
/UyGmu8TG+34gXQctEIzRRv0zMFKHR6cwuHteXoIiB9iv4mXN6pQr19XuOKisRfKQF0jljnX38OE
oAC0/5thy2McfdiVhAro59PwkAd0T/KHOBNuaXNS+gPmo2Ds9TJLkPJdcMZ3ebYdqkaqMjqckLFK
h8cpJAZ+0nN6WujRlf28dnl432ZXIwsMSoruUkoZuU6vxnOVBK5cPC02zJdo5LTE0SnMXQ6NLd0c
vFeTTwkj3fcLzDsMO3664/kIDKdU993vaBXDRZd6CG9GH+NJ4O3CWJZILuPybbWTRByLy42rQkyg
b9WYK6EVKH5lRHMxDmVHuv4Bc31NbhZjp1QZpd8djCIA0JR4mxIQq85YcBrzTe0e/sT5CAsPuWkw
nexnFIHfwME9u9jEOv511GU4TO2dh3UXG//u03CrYSmj38SYC9wnJQz9VUyeCaAPCFL60JQodN6Z
VvNjvEQmFgWgXu7AnLpNtaOAbJJ2aeL2bInU9d8UweWf1HZy8XWNUOkNpJ0ZonXKLUFfYNN3dcOm
tyMM2GDCctCD/TBpivcLaYoQqIK1bpB9s9ZYiKMcqSqDbZIbF/gCMAaWJ/Aic0mlc9MHShZw/kh7
Hc58uVhZNm6aZueeXctjI05ATR3nYfQzV+SZWihXebRf3+8Pl86mRvnM5LYUEPCBNVPfiR/EdB03
4joBel5IfJKmSWN5cxlZeHIy/M4jefa5M+oty0F6N9vA0oTdn76Mpa4ClkDBUOPv+1Fa3wd9It7T
hyD1veuxy21M7BuJBEEEQEBButrh3qMaop0wvb0SA+1O3kxWYw1ak1bL5auGiRjDTbY2HHz5RcIj
TDXU61uFbOCf0tamhwAqtOrp9D1RavbbDFn7PiNB4zawqpQYjhZ3zlkw3qxdN1BMvcUCXrv1yd5q
HwKnpkmLX//eiRtpG7BGBItluKvcU4GDA2zY3FGsV5wZOvp7dlpgqnUJ/yihvb/C4CtRe0XYkora
lciI5fSgD3Mmq9mSL1niunDhcXE5/AlKnARpFqTMQNoB7O0SBv91JNPPhUtod1sl7TR+TxEH6pdn
lXGDf3pkahOjCE1B4FG42RekCJ6n+mNvTAMIVT6ppggVKmHwp+/V3PgzYyGqRgFKn8xbE3W1jZ33
X5k6ateMvLi5vWakW/3cqCQCWpvzqILgBP+BAicpgOJYR/jXHWjS67MccxWcfjZ5lV7dWc1ZDf9N
SguT3S3U4AImDVVbfNk6+XRFrETNEru3Le02d/uS3x0x2Do086kXHdrWEYmyj77BKkMXwE96RW4O
dJzpIALMJFhzcU4OSU6F6B6B2UbpR5D3pJri37KOwBdCGmr3uWCuvGIWSFfWkDR9VST9/rx00cWn
2CMzZgj+2C2Kq4fvh+ZXTCXEvPYi7WTrFW+U0+f9rlJOHazW+5L7JQW5rwlFJdjsdv3OlUse0VQN
UtftxEbELNWJ6DKuvCxO2+x/gxY4X4FxJA9g0LVK0enKcLK0BzxEok0sPE1pn2Mka0VrkVSfh9+A
/lzYfWPJFEjcAH1mhMJaVQ8p6NwLHJG+L9WzE6/DjuW6SIuG2uFj3AQnBXjnwok023ZOG317Hjkr
AA/vDS+SLf4ER39D2RfGNULL11MTDBku7TcGeelYZ9cb9BpGGTeV3mmcigQsABy0GU84js5/60Ch
BB2h6xHiy54WKegRRv49aGOuRSGitJJEBOUzoBc31vyw/5o56AWCLLMf9fUbXdb7IIi8OyJP8qBN
cNlj9UtshwdhyiznqWS5e4+3ZUHFhFv1PKxvQlC8Uwi8DcSXDevIs6PFl8TODToopI9ozES9/6Q+
5wtsygcMQ2UnYxNZ926564XRlLn2f372NQDy3n9ZftG/b8HdErPnDUXcxBRugR0yAeeYeOSOavrv
jga0lElOdsOLCKeB2by7g+Ylkdv2LUKXwcxsIKyHEIXOAPYHxDwc5ZggCUnMMM0mxJD26hTtT3AU
X1ooIfW8QMU7tOP/R6n4SEmkHDH/xsywhqxMZNJz9+7JGO+GJF0b50MNqwsrQzLDRfMddR5DPXpL
6e2u/gJx6aUSvfkVd77mwA4iC1sZ0xBmnRoM43XyTVvGrfn9BMdNlqjzavRent9QXf4Cw/k1NtPi
u3Kmu+W3WmAy5wY2BgOUgLvgnbzj05rrUe5JYMOpDZarDnYHGMUfy1SEnwMMw2q1pXL9MMV0CTlm
QyLxOS5IdGsYMHHlWDd4tAVaHVvoTQd3oFH6/3bk1fdBrPQ8b5g6rXt/QtkXeSXGnorEpxEgoZsm
80ntdLrn+NjvQAI82y/3h5FYZ2EaKboSnUCka3biralFd7LZnMWKk5J31fQDMf8SBVBCRO75ESpc
MyktNaQ/GVngwjLYqEU3B+ArxOp4c7RDNv7eZYnwGdDgbjvlQe6kvZJzwfFptoCOhNoQHycpM2Pq
S72avPShMjYUV1WfUx9ersbp7RQaVhoO8nhDc5aMUZPU+Kot6ZKyKRsIz8qkBldUgatWh9aGdcD7
bOlrQ8vfvj0lYIQiptALr6wbF4rtdl8BaHhi+m5ATuDCdJ/yJDeia+bEhnDXsjnQrI1xs7fVVqjY
Akd2/ZJXhz82zsxOQAtOEP2+4EcDNAru40AC98Y4zzU/3Rf+3OVwb3bOH03nxPiQeXKFAN0bTTQG
x4LBcOKuCykhGxTfY/W4+lgu+bAEKqTlC9EZNdlYbtNfRbAiKDjhwS+F5NCOG4JXBeLOma4l+ya5
0CzC2wAJcLAJoX7XJjDqed98UeSV/WPZUjoxKbjTEBXbCzirHOKaAJGWFLtnHei4gbMqgvcTXhql
55LylVSwFr0ey8AbZFAmUpd9/LFwKCxI9NeiAcXLJXz32aEtvL2FrGUuNsZMNsalTS0ceA7+nR7o
WKqNm8WNYBMOZxdCRROOh5YkTvb3deKRiGZUvVjKDfVvhBQQIJW9lsPFCN6lqQHHDCCGI51YdeNp
Ib4jwEf+ZIbaipfG3Vz5BcBb0rmPl7KzELhmgd3bxf+EYRzPnpZ7TlJFGFU5DUv2F9Rpd5J5yfJ6
c03osLwdt9NW5N7Wl2C5TehT/QpblwsrgLSHb2bQwkWe0w/PzDKErV9USK5HM45E33ql+j81tD8Q
sErDRjhqzkGru8QnHWicNFGOHt5+jJY88Ai//RcOamWvq464kXEidKq8ZIg9UlBpzI59ZPGBe+XP
xJr6U0P8XgUiXVYnVaoag+FYvmskVWvwgg7ngT4qh/Q4IPMUwXaS1SL+/S3RMuSjIJ9M5qnYQQP3
XHoOso32y0EbcjY9Q8PXY8uy8Go2ZRiuKlp8qvw9L49M/Yv4FqrWNDobIobCtc/n9J4T6bcgOFYv
2I0SXCYl2WK85RUScnsIEjkhmbVTmKvW9vYKZr8+cyEONcuoiJ52OOdcLJa6mq0nthBrmrLPPPkP
LJ5fPNWCfB6c+XVa/GKHdal0+2qMJ9LyJjjdwTxUeLrlffF5sqK7ug0dt9NuH+lDHb5RRe1YHUdS
i2VcjFwwS7cpdPYhD2uLzBPkhyPzYHE6UijqbcxdzTWp0FzA3jqZF41JS25JjbS4eiKRUiH7ndrR
SWtDlVDqLGl90x7ii1+iMAOVjavIzpFNksSB4Hf1yrZ1mWxtebbX1SNTVAS4obpxx19+R2S1Hoar
BSCexN6p/DXwKVuKLhh6MXT0qp/C+xqM0HppiJ6/Oh0mSemP4TIxqUcvCdKcPQe24CO0bzP3CHHW
6nJb9F0w0gYA7ksDdo1oqYZt3ho4G75EZZ46+pb87EMMtX9DlR2EC4uMJdElOIrbl/2xtxiJm6cr
Isc6Ur+8vqlFQ0sCeETV0lJuJS0e0tb322mrNxrxg4Rtpus8QKzZiv+Xrp424OrMgemnHyGbQkzD
JDEQa6+JaOX6GhfOxL2ju8Riz06wP9eCGESF537dhtnCNG3GgLIj/kwnEDqDS+c78EPTR0pVI+Vy
KW1s8FAUZboxp+StvKkZgChqlW5QbWXrdvhiqpEWFZepNy8Ka3ZMiw95s7OMjedLQdYBJI4nb+gW
UyGmk0KYhFoHsgpp4XxZQjnj+jdqumvdRLdqRtpKLlQ4Lqqt11LRwCyAvbFp/b/dAbcmKBPfQFO5
vmUcj347fH2JmG3cDeaCmo+BgqG4zSYQyCIZ3jlFqEPKyDAPHMlLR5hkd1GJfYEwa2sjOpvcaAPm
ALyAVM5cwp6Urhj2Qs7VWUDWsp5vsLrCXaLmufjybVA0bI0aEQslkbTuNHNRpRDkinR/d1ZPIqOT
mRCIQ2x+YibqXUPvPb5kpeh+rsAKMHwXecL1B4vAhi56CFsAeSe0m8H9oLwC/PI+0Jgw5azQXv8o
D6ihGIvWRzJJ0QuPHBr9SuG9nFMFoDYTDiBrlgfR6cebDbPG9DKNiWPtG2cMug8QA/dozcKlaaMc
owFXkWgbAhbtYS0CELxag+zfoCPEurxJE1SV0Lqjxefqw8PdmkXiMMFSevh5vDrQR+PIRoxjwpy8
S3EvFFPuJENUBr/NAXWVr+VTISFNrukuRbNQqt3x3gJ87JoP/2tDYae6rkYDWBVbjUvcHD+rssT5
tcS+9ERU4kujLXSYzy96wuL4op3MiZaQfCma32tUu2qf458OdVr+Obv9vFMxjUMqOp3REX9uX9V9
QW850qPWXR+UcA/4b8DAvaHCGfr8nKqqCinD/LeSMA5jWOl3/rP3MuIiuqiLJUNl351QXMiOyTed
D7GdH8REMeO8gK8vS2Ph/ejzJxFEM3t29WxtduT2ulMzigNdBmCxlPDRY+Gpv29bEblaJ3I48EzP
FNNf1AwzpLdgNdT7//OixaPBCoInn6vLKhHD6WV/KpdO1uRI7eJFnviG/JL3r6ChS8WDhRJS5aYX
/qxIW2gNMkfvCcfHq9nghl48/dO8wHfNAp2tPGLEOcknrNMdLGE6XhGCO43oazZYlxXoUvhHuje8
7i/Z7Pa23/HFlMcld0PFJSdgsjVyzmz32OrecJuzkzlJZe/ySwfzI5drqYRddtlrGt8aM9gfg41A
PLA8/U7sO8AhtgqIuCfmOy4Oa87Qaq/HQ2RQs9jeevu9tIEaysv/QR63BEMlyZ0+uN7y8kdVwJr5
9Qpur1yXXI3eDPi/0U4W0DOEPE/HbD9D/bG3sHH/u4wFbJ5UMGZ9nVFQUYuuXgDSNI6aWTJqvmJj
sAApeNfD6EGtweGl7T8AaC0wYGibx/Nbbr3oYf/KEnXu3bjBBvMwJMl5a4D2M2Mhq+jMNQjW0BRJ
irH3sjN20wmZoJ7P8LwPcyKs3s2n/2ymiQO+YUDRbeOPHxlynjfYxQ9rVWVIUwltmfgruxYJzPQY
weYhC0Dph3vO8wONvba+Vcp46voyV4wn+BKp2ZJ5amSvCfcVesOJtYXNyqiqkqVMYMmKStMrajrr
5yel4Hh+etwLGy7FLCWCNkDt3ob7BL7FPBjWg96Zg01tp96VJYX9sdSnrauC9636LAG52nuLAUQJ
n5RcRm5/Gx3wql0lgjI+Tw0mUmOTVjYj9p5zD0dHSWLI4Lunv03Q1C8eUohcfXn9Hz8KsI8pvc6v
dy8tRfT8SfN7a6rjT3aQpkU/EiLoWfIQ2l8Zl1nBSjhkAiNkNBmBhRMUydIf8L4ocXglzZrGlutA
GCoZIJxuFHsqJl4WSupCiyy4cinKb+lWLX4kAR9LC/2aNo9g02j139BAhXFIt1VhtHZYuEWazLZ5
3QIjumV8260BAKxR6I0G/ZX4xF78QVi8L9guHWvJaO51GRzzYU1SA+5yMZSGDf6n6cDKqqDALnv6
5wSNFfd22Sun3aljxrPyuvtex46tPgvugD+gRKcfsDV3nMUmUjuFL4navV6QznqOHx7BtzHjxdQa
y+unTZ/KEqIw1SFFc8anpUkvDjwmQ0SgVVS1T4AKL6NkhQI4NIfUhNm5W5iKtLD6B/Jx8tdqwwNA
xijH7FKTQQa5gRcT/JA5d29dVH7azFAEnQvqEHdeEkDlr7LxcnbuRQKFCWeQ5a0aquAYok/zgjLQ
3YdFA2W2ct6W02us0nRlFqWhE+U2We42dzzwsoDuHVb8cojEzz+5FW3CPxXHB+PQNPbG3V7J1Lyo
ll2Ox58Cf/HymaTcd99X2EaPXwJMG5rgCl2WhOt2QMsVAb049QWSnkELHoYXhOj3LM8S8lyrCiG0
WodUWZFyy0aOUn8wBqtZ4S0OdWROD2JpKMatAuiwidJ/F/KWDA7oirwI514Lopfu3w4deltuUfWg
hCENMfLqnHziIALOF0fqA47GP1SUg9BcGRB7Yd4urefL3p2xyy3kmwjJhppu0agGfzeXZevJSg/U
Nq+56K+gawrHcFYqvTOiVf21x4sTrMEPsVVxymkIW8Ac7wXJFmmmQq0KfGK3ZnXeyBSFWlygiVFM
S+Xua6ANJU2/7gST4ONfZUsXFyr1e9LQbHpNcRPS+87FdU0PYY4t4wC6cCyQmbAsB1M9+fWap95J
vCcVa5ed6aLj64J1Bqt1XZZftfxzcVrCVP9l5ufNoYJCnnCHtORLFUDh996ArFNDsA42jcBcbi3w
+RTGYqyzNPSmrjuGJ7j5xyMXGi3oQuuvXBKgnkMKsu0jfzi3/Y6PhbRqKT/Dy9fZAPy50cNkSU5V
r/qReuya04UGgvQFoSZi4tiR4wW2nuU73rZ8HTeWnGiY1nqpEx0+IJ+cdlwESOxkXevIl/kcYXlF
c8SUmmjxbqLy6jmwdslbBOXrEyVBXycvSrVFXngDhPExAXhNdaivA6ModRXfomyDYzC3OakmkhEQ
MTXdtAA8mhTt23jpjANNan9cwE3TthL2z+23gPil/zONDYzgIv64up7CZwrLotblwqa6b8of65u1
VD53G3gomtz85PL9unLbItXYrnG2etlv4Xkp5J78ypwxWmV0aBrQeo+dKnk7y7Va4yWVuQGLXGvL
Zg05MOoPp7Z+dHesBx7djWSmAC0ha5ZBWtctLs2xMmCFmmFYM6UU8sUpGEpaEk2bA56k3VPXpuJT
wh5+fuEPZyona21R9B5WotM66T8zhbd6F3RewpRJp7qPbl2E0fi8heOXYUDBuMZ1N3Vik1XMvEU7
pdXDHFgWd7eX85tvVLpaTczxQZ6beiTbwLqggClrKIrVL5rk4JDRjgBQkR2dfc7jyRx+XaSsvxoh
N1aaIxz4ix0g0WUOqXQvWvagWav7mk8EB8c8I0/Gfmdxn59XrugS/nKjQgZ+0WyFhc+JgJ8VFNW8
vdBUD1vMYLCT0mDkdB5UxtkKTkIG/Mh8OAEat4aq8fxhsIEtJ5K2d3c7z+jRR9lXxMgxrcJtE9k1
WjoxKgRqHBBzCoBQTbfJgRjUuwcWg9P2tQvc9lxNHzwM95UPkBae4Ucie0Ex83ZnkkhLtGa2Dc6T
LNKh82YhCwmu8jINF61jsZH2oJGtwO5WAHdGaMWKMnEDWM/qOaV6xyalMLblIcDe+24vm+UF8g9i
mE0t2M5eHoI1Y0mmwD80Tqm6wVleiAor8nYslQ7NahRVNOpm50EvkjEYW5OcKw773q5dETCCmHdh
tVdVzCIDGkjR+p2b23fo0Efb8NRzXxDirJCtYknvuq+lXPXF0B0RwYApQwMZbXRbWEOWE9i4uvD0
yRZIAMLnKQu4xf1V9s0xtT/tQyvEubCuo2xFl8mEtWcWlYmc5rHZR8MgugsmHaGZsSS8dafXPerb
iBQF50jqJYhhpV1F1gYqX4CCdapYYk6Yd4rW17j6EgsyyZfH06ts/YZqRwDVUDzs6snrQuHVGVqU
yNqlfhGnjJdV7ZRajP447Z87eDOpvQdI7/EYsVhk9e64w2/wRwIH3YA+eFJxwhIl26eZfaA+4lEM
o6xgZG9ehRPcfdbg7ERKd7B7viZT42FB0UWFGq+TuTN2ZWPd0nFtg12G4UoBZ6AnblWuBpZ0P1YT
jUgnOKyjNVrDadh5ThR8pTs8H2WWy1cxyrP+/cqo9A7/PN8xv7KhUDVTE4riSXbxzsFDlBkwKcRT
ZndSkiCFsKgGtxDyKZpzqA4ydWKkJIY9MYIFSFv+nxK7NIKk2RewXQwGVWJgJrhCbrZYEeGruuN3
cFc91SMlJak4MVjusNw1KXjcKCebW8CYuL2MQB+KFXrJKoHP7SKqCYW4zYLB0mUQmn5g6igJBIAJ
pgDYAW4nNJ5Y34Gihhwedyh5IGY3iCCgArJ4RyjEentfY46rjFh+Z6E3thgUBWazVuS5DNl1r5/H
O1ayaZ78J5d2ChRyK1RaBMdxdCQNJrkFDzliUgFpBakACCCbRODDXNlwOWjtvTwHEiDVJHcUsEk+
lI0oR0AzmakUvMEAVZgZtrUl1xaMIuG+RbXB7upoL+E0QLegquWXFv15fcy20ne5rugTcvHZGnwj
pFHH+cqvDgGP0SR75jUZOclCWD+GrFhEXEjFgbAC2+aWFa6N1IJYNCSBgu1NwKox16U3p6lDmnND
cFd7m2i6QKt8RfHBBw0KHyy6dX5JN44K2W/tg/ZQ6R2Pywy3qSDl8Fyo41lNBkPR5HKxqXnU2Yww
36QKEdCNY+3ceebkxnkxttWhSCNVYw3ZxBBcSrM6XE6zYLSI7LLxlc1EBf8Jq7m1wv+q/8J5D/eB
ZL6Cxt95uzeUd9ZKfoCY1Fv8l2TrZ6vByRqzyw/BN+IwWU0SaDkrDJCPPnFy+VyiypnuPpUDyTsq
77cnV587h4E6NOKqQjoafbl8WYXx7sW6QT5OTyS76cwEgGvIGcaLwG+MojomRTuxK5liz9OmqzL7
ghxapSEOmF8VLCMlHMp7WCBh9F5edxd8HXiyqlwn6XooGCeKtXpLI3jsqKS/3GhI0r/nwMsu6nWM
LIbdPJsMTCY9xSMYlCqfNIw4Fy2gfj704kMjrrjGN34DElTDCWEoPPb8OfUHI4D8bRlqO+GgdIx1
rBn3n4jGmccPGxLeQ5HY6VKqxb8VQbGK+xjzmTtWVoFAQ03LsRi9lIYJaeezDeDm/O+2sdDkGFFA
hsNHNI5VBoKykPn88Nrb9xXPYGnpGBwCEYPT8ycajlEJ8OASlmGeLVHru/eRt23rMUne9HhLkYCq
MbX/Wg+b6qQv7XDdiaZ9idvpviGaDqnW6OVfY6S36oOk0ZWP7VfbfIy4BtNIk0RtyjsbslWNxmWn
muO/+Hqq1wV6NVW5HNssqJ3YZWNXWGJl+PHhrJVYqQV11ZCXoqsSra9iuimhGrJuRXl5EuUIkhMk
DrAZqe96YIj7qgKzioOhHIYwW1MBw7aiJMC+NKvsVxZo5EEJ4b4xbMF0a26xht9hZa+rHFlh5dlx
z9xLHPjkXfjjEm+7kUiUsU7N6/IKXWGg2lbatrq5baP3g/eeNDu5epASlBIYq5iI0ZOMgU823ZmN
k9ymKLQBxo7/jSLc4/cFtpzoggYkUnGr2mcDWBdorfDKzt7H7asruoNc8VlTq/y4dflZhVZ5jpmu
N0xDOHw51CFj8TiiccncB2J3IGJ2G1eAR7+rGIv4+0ADIeABHUFhPCe6LPBO2uOqsLFVT+itcef0
ffi8C6kUjF/sLH9CqVPrWN3N6VuoRQ9dr8VncvA9Y/Nhia889rGOT3unv2gPzVbGCbp+EdI0Wsl+
XH6RdwCJdNwQoXNaFGcgDbwwsyUVRIw4kiO5oiC+10O2n2qEDt4YaESWORYzUnUdfL8f/VuJmJv9
0c065p/oYnoVx7ASydVigE8Rox77NhHiqPaR6oaNu2MhxyG8oGxMLIOOkSBPk/9XNeblS3zstcVY
VKuiopdmem4BY+WEe89Y+ZEemq7dmQyMA9Iwwn8uZP++bx+PtTSRMccGQ4fkvm3R4sGk4hyXiYeC
+YrhCvVTgoLPUAkb9FqzUsTpxScQCN8ashVzcIGv2RZe9rZIy61CmOQ0OJhKykjebnPZZc6uB/Qm
ONYPiC7SGcWWi0lmQb2BJ7MOdGkhuZ1JuXiAwoKAIMFIta6KP4EWjGrcOrMJLtPYvTHwz6onvI9n
quW9XPc/NxLBIb8abEgFO6jLv/VkTMnpvmyQg18zu8ullnje+mG5/+deBhsTO457jLRHH2ANkjZy
qYR9oRIvqxDjHOAOvTAlMEAzMDSpEG5H6cDfISzy73eG6zWX5SJQdX+Lnm4x3BgYnmDLC+c7c5mm
PDYMNu15XIA2Ud8DadBk5vflQ2jfKUWpZ9kOvy0QB4uisx0m1fDH6DRUGx3QGQ6xNqC5niMjISdq
c7Hp7te8bmGVHF/3m4o9DuWjrIha5SvW2tP7pqQ6hgQyq6Qet8HOF42vHIXoaDtIy+7qZsryCVVt
NX5VM3+mv66h5NNFgOTyAUZWyS5rKnu+youFv4Ttm6+S4eWAzc3LvfmvmFSSWsd0hbkCFiJHD9Ay
cxR/gNBZY2JG6+Tfq9c+Rd/S/dl/M32V9IAqZfjG8lkiOltbyZIzTavQBPFNWPLDYpZwI8jePiO9
ckSZhtO7NAOX6+hrfrlPmttvCBkIoVQnAfNz8g6QSiLra0kZbV1NI37Lx4yXe+3kA9N9I39MK/it
l4nZd4tJf+trID7DAO/EvercBFEn3zlRakRF+aC1EqrdqIj7Gtx9AeVEo/E0pvoJ14+fAm35kkL8
9nGYv+3vqF8PtsW/HToe7KM/FOR7WtYU0QH6XwIJmrLO6PcmFziqhqIbyewlXdqKuLqfNABr+0gZ
ZBqhaGusjQizuBbvzDJeyXEtjLeGsN0VHZLUmMY6z6iLRaQphvtjpZg50lwbW9wh4BG+4aq3m3uj
JKwIMMSZyLmjmUqr8QnzslUrpeok7hM4o8Jm+wUuHngIdhNZCL5x44qaxLoI4MGmUm7a4VWEG29c
MfgNBhGFn5699MafM4r71jUrTW0DGBL8X5VQH/k/YT3E0kbf9xEeepk1TA4RicSpgA1+yIHUwR7R
Hj8YJJy97BNYCDLN+EI1QKCTu+SRp6euBE21f3utD6d+AL5XotLk1hG9K+kfoUVbgBMWqv9ZVSPt
H+GRYIh20pWSzvG5S+RjIXuK+QDfyb5YCDChCAfZu7BLmQBiXKHomZhauCHMsVuscIvcjHBYYLAN
ZkxFZAs/94IYGba+KeLZ+PMcAzMEBMMpDY5Kpz1XY7XdAwZhDfalgDpE9Cc2Ey8ulBVnszEvtCkZ
pJZaGblm9aXNtGS8jUqFDPsIwNMllhyjtbSv5gFCo7NY5yo7szVHxuPHWDO0HcvOjA61VBpVjFsj
2T4Kl1Wd8JsggIP6uKrzYpFQ5gr04mtlGkn2hi/9fo3b+w4xp3QDQpzn+2/152WUq3ycGCF9fhZD
BG2KC/iTIGeeUeeDd0cpMiduXnAkkGFa27v0EqqXa/hwJKr+FbAeaSXELCxNGJuFOfLmuQEtNhkt
7orbmVbdWmjb7iBPqjrZILL/9V1ALxAtjt4SR58mc2nsaBUNAyMQRkgNjwy7cU03WYvTp5CnEDC7
UuFqh0jygTMPH2gqPhTobuATvxVhtX7Pv76L45RBcG5U+42aV8P+V2FdlSi5xon42su/NnMq/poy
JGIXIx2rowFnR9GuSzgWOAmh7QStrHHI4fC7LqxsU2I3xwQ9UadRlI3snZTqqttXURUr9e8BRV+Y
yHTSdkx/B9wijbATBTdpKmR4t6YcKoCUg7mrbikXIfNAmNF4Kkq1vMyygw+7LZpPe9c3tssiKozx
eqSG9/Gnc90pehMOjjhXHNW13/sAPuKVLFu8pmlkgSpFsZosLMZi9QWYni9+46xS5uoP3G7byNXK
/T4MZKFgkaDO5MqVFG7JF/0u6jKgsiOEHw05XtyAc3s11Q+YO2fbbqXzbc7y1Zc4FzaH/uYR7Ca/
WrfHQD2rxHd3CsGLT7orRt63oE4Qy06Yoe3eVjsirj73Fv/Kij04uX8xr6Dvvzu1kXM2FcN/gtsS
8/1FKWsrW+5VSeJVp6YXi13doT7ESicohMj/9UFARtDlYbAGY3wLL9TUA40WH5yn1emL34PeJbSv
fuRYgjY2ifLctWWiZjxHR5JtyPdGdMlCnnmn6WNlXS40cPUAt7/6iYh48JgIflr3v5M7MhwSNMEr
Aie8+BIirNUBUZh+fjZZLuYIToaQtsiS29iiTOhp9yB77+/LcS7zw8TcPoO05ZATgWhx2fB/USd8
2csaWpIJ7xFWVbr6SIOcMEZs9ChtPcdQrqiLx/1N5VpGNRZYM6BDWLHYUs+EDrc9HlcsBe6MY8+i
Vf7kL+A4MKZRThA13NBd1ZhfjeXhnofI7SMvrXQC4stqV71poL8szgQ1i6peBJPOvFOQqDKcDx1B
uc+4YVY0iJvNH6zVop0bQ6B5hI2leYyJydKrFjHDS2n/7RKY/yXORRt1wQg3z+BTjYf3SosxvV5G
udmxjgV0hwYwByq6bQ09T2IJIC50pWZGhPF2UIil+MmPVbgyB/RkPGX9vR4dqJNPWwPYOMLcz74/
KyhO2EIXJP5EUBk+7nuQ33o1pq0Hu0/8a4qbHnDkJTWOQPi2+f3BoFAiRjY6fXG+knhcznOc2NWR
nmAqRZxLgYUBe4uMbIi7iCi1slCZz1vzg3mtAomxdGCGDkLeHB3nXbv75nPOfxG8C77bsBSSIfbd
tQj3N+MtUiuxlXd31CbZehXn2VLfQzjgsH1WquR54u8X9v4TnIemWRs53j4QE27D3UNcdjB+PTNM
OD7pIFyxs+5ojY0AKWn0Ssm16wA1L8BMLjSG6NXa0ng+ES1RBEe087Ek6GhO6iHz/fhD+d3UOn7I
cFcYAbJSwsczCo3I8cej4Iqg5kRpFGT5FbIei5vKCdnflPyCLg6AFSxe5hMj6I8QaO8S1wMcgE6L
/QWmCQRYuf2XVfgzHrGwEtlajAB7ShWG47DHCngU3SlNieEoSbO4FT/bXtaodcFgmYv9a2z6OsWo
HlZ3nK29rtt/cvfvdO3Y4Wx6IdWPkqmkgQaBXUW470zYWJxTjbvtoyPx/yESbRVPFmo4b74dRlJR
K2IrpMMxaIHLejz5WSr/fjaMt2gyH6RECThu4qgtZJSkoErdCq3qcKM0j/iBfJQYh1t1Ad3HqURT
60qhppYxfY30MtcktS7MMRsq4JIu7IEeAWBnZYcwgdIvK7IXe+N37/vgEJnfJ1Vj2z/pb352UjsT
prS7ZqJ+hcxNCYCgX4skeaGrTrw2Osu28fN6smfyEpsVWhiKE7ezX5NORnWMkzqJVX9xzAa9WgK5
k19xVF8m0zp4wrUGaA5JvphICUTsHVqaV0JFuHhPG3atAeN5vt3WYnrS3DPfFMUwk1KozDdSm1A1
0lQn/KSXTJtPs3CCY3BT8BWYyZnXzNqj2kE1/Dc1s/Ydm92eUK1jdW8Wm8sdl2PdCYdWPn+BeG+2
sq0R1e7PU9PZHf7/9p5nDfFbTjx9JxX2Gow41nlpysRMukv+Pkk8jmK7REzd39TndmnaTFRXM+zA
xA+HSWqU87qzCNcW8TenCBmQJSu1IkbUXN2opSQMlK9OIbh53AOAC9kVxKk+IwGoi7oLIkxkMTXR
GoULL9RSj1gysf9p5zO7kAqLwLOiNhy8NPKVoEBoQ7q91Qx1iHw0rVOFTAWbY2Miy7wKY8eErbPL
TzcTijBgQRzINc+VRqZNTUbcGK2go6mqzHXsV2D83qr2Sef09dlthUZEnAjH9xEEQ+QKG0RHoig2
oTykRq1Uk3e1CRKDeXLAbk9mGDhppTnUxMtQSvnwFAvpjxsFLQCoCjrzxhdTYguj8dSFmabmeshf
SBU0B5AFA5EISaS/D3vMC6ODOF7cbjdMc4MdqRXNuxX3CvUmzrdzl2fPqtrFKgU+EQxpqvRytYO6
1XH6nTMOvKAMNNdZFLQhgUQ/GcnIW8tIDB64D2IDcnjY4QCEHXIdW54/s1YzL+Xkwim/ATJg7+wR
nEz1KIbxVcMNmrhl6S1CC72OkZtiwo6ZwtB58yK3ScuL7jcVfZIZrHJkFKpiWo34dO5nXkuhDpHr
MgOOkXqjlilI6kbU7TCtvYsC/vaNnsbadl/GKStWvSaII+BEwCnuHxh/FpBy1e5yf8IlWS135d89
qL9eyh6wAR15RQ+av1Ns5nQAi/D/jj9XV1ZAP9vqz7jCyEw5o+QBBqcJASCzYrC5aow4+XZhH2tj
ybJ+UucELhvxlmXvmG846EP9le0tTGzMQcpY6EIVLtvBEB2CV43mmc5iD/jWE3g5h4lWhYAH/Fvy
0nMrWtv9/DCqpUuFrlYUr9EP3kamFkS76sVxmTws0dO2TPLY7WhH/YKfyKCGISTgqOdD7ltATiz7
uNGvLST/fWg99Hb0vPt9iHImt6DMiO8WI2g3axsKamwCQRgog/rnBLiaDSOoaSBdrO6Focl1fq08
PGwy4VcEP9CshzDKDr7Dzd7jXCPQLnkJijbrHGJUv2tDlCjt4LQVkPi4HAGxCKNkZvAcj7eoH5FS
9mBz0Dkduy0cdOAKl0VeRfYNoS8jPrWcAhtjlmKc3YeQXqFWy/lOSagOJ1tWv2mrMfRiSF9bkvpP
HnB2ch97wXsRfL/1moOjvJOr7jsQxw0v1s1ulqd1DX2wg9M/2gzZcvyAJpeD9PTsrTWIhnZmCnbS
TSbOGq8+E94ga+QRxVZrd1fDqKCdjSNLNQg5vTKQOqMjSWcWgj/fc/ry8UbUf+czgh7QZ4m+2f+r
zboulP1SlnzmccOJ6C+BWUpePDopHyca02kGpZxLTCrdGgSRUCi6GFG2qIZOhnL0eOBn5ILHUmeL
HFXFLlu8ggPQIn2xGD7QppgzXr3I8yGgdpyWYPWSo2yp0f9s16fcciOSA8e2d8ibxcU8nqT7nhze
lifYTtib050E9G2+bSyF8YgB4c90cBeaeS0CSG7gT+SS+Pgvh37BG5jMJrZm+VpC6Sbg6EGgsjmr
aGZAFs3/rr0PZcvmttg1hiVpyy7eGccdjaliFa+huVIeieMZQq1ltRLouHtzyFafDeWke18LqiEi
j/hpJirMizWAw7QEsafKGOkKIA1/b0F0NASZ+Fwjk8qAyAOdOITUYdAtVMfDzVGUnAkhDbmEtwZ0
83OvhV4Cm9RvmUuxU/A3edLUaipJb7hI75jjVhHI2rGXSwlLzz+XHYCdTD7nLq16j6+CHIwf3hrf
yQCjo5MGfEGZUW5WYzSP+H7cCovl6x4yPV5XH/vNWrbFV1PDiUYfrQ8c0M+TskLvThEVzLtVF9ff
WXN8a5LWrGChk1oo2v+s3RvjRyCSCb+34PV0Le3soK/2CklK4no4aA1gkpHXh8nue7mTcevE3slI
atE/GdzYAioC8a5Z2Yj/d/KsLKYdgIyVnd2HQbKi4yFWef6E/PFeoRhS48M1k5dP9zRS2a1J1jEr
IDZa7VURWStiBtE0B4Tgt9IgABU1qM0qVhI7posZTxdv2owIpSnQUyqKKV7bOON5+wq0/IEPy+PD
fvAf8ii0/+onGiKcvcvv7Hu+KtAq21En4gkbpDSbO0XIVHab8+gxYU3/i+5AUrqg263OqH9lCA/c
vI2R5X1hwPYk/M58ijE8neraK+m0GBnsny3Bc0bvOgEx0ISx2RFBFK2g7pXZGnYaUK+EowtzkRBJ
a/W2ipht08TquKM/FfhdaLau2a4Md/HNR4BTHLnK1hG1rH2J/0yQkmTrPUHM35SHpv0QWqGmPmEM
hsXyyTa19qMnr/m8tqUPfqcg2PabXIjplgd8YX7sLHWYbHbBWxlnTRDzbuKA1GlWYBQYIs4J/B3v
19NLWryQEE/I7230gYYC+DKIendCLjq39nn/HV3mZ7BpSXMKxKYDMnxJv4QxTO/Ij69qQnrRUn41
XePSloVBqMSPjZOmVn6ith45+rof4Vqnw8Iou9Y+OLMJD4SSRv14/duZV4HczdpS+cJXNQV3jUyA
PGaRw1qis63VkglNMoVJOOwo8JRQaQ27KdTq+6XGddaQvyRspSpuHlJmhlUkr1KNd0a0LZCrjjjw
0bY4NMSjVNBzhD/pTo1FCJxWID5xGaXNzmxHtHpp+diADShNuF3WjANELv3UI4gNbhrAy+/4uqTQ
sw1k9kWIjk3PMPD+F56ZDohLsKkRirmj/Ca3Q1JguTHQVHyq6l+kxGbtCv9/u6Sp3vnovHQ0cVXw
j+1dp/T+dhuFlP+OGL/Cyelcw73ia0KZ5CmK/s0vjT8KwckeR+MUXb0Jtc++ZaJmGsDbUeoW75v+
ln8MZOBzHMWf0VsHkWQXSRXpvndLhalJflTGZUb/2XPlbZyM9Ia0kn68I9vfVsF63snjZrTa99PJ
iOSuZ/6ULtnC7kaxV6Ai0rOmxXl06+wj+wcMuv0nOkXTk4TsAvvxIA/rdnGGg9gVdxBMkVZ7LKnV
DA2E16DtlbsFhhilXdJejbHabR7vDVGaUzhVUtbsNjn8rEAepMeapQqMIYmgC3lH8Yr/gMnNKrbJ
TsmOOUw6WjE0Fs0TRVzglLw1dP81dDMhbzC86DYdCU9fdeib+FkVyV9fe1Mr85rZBHavvevv/zYp
3fJuX3l64LZWN4JwQM19hxIXyktFE6PXs5K9oGJJCz/k/NjSFRKYBkDCcNAwQGFsjhrtEidY6eZt
jZOpTSUuRb6oTlNZR6uDAvo7oucQsegAySr4XQPZUgTHM+oiOPsqPWhcd6BPdpN4dW49kBtzcNMF
deQ+cPBVMralqKTrHQuOMxCHk02lQcM/wl+vCfosQnDvkO2/aBRJybVqkSK8TtlWYqdk8tuG7MPX
sZ9882jDWWdc+LcfbSZAiEbk+5H+waEAuhL3bDV6ghxfMesg8K8T0a3ge0NxfjyT+qHQUzIUAE6n
lfqSooM8p/so7GG4OS02A2BFz07sxN0WFGFK301fRRkSPX0+uJC5tJDzgD4oLNVqruGfhQ9RJg14
QvrsRRoPz/KGw9ztody+Ff1mq0YZEigyR4yydifwoQbATeMR/0gCP1rI014HkzA13Hw6SQevecXh
QhIpBrg/CbrKvZTbKWwhKM3+o5/NwWRb3EWZSKbA/FQ1k2jFjJLKKeBQSbp3xFnxcnS0rXXyIgTe
KksiWLTVooqe8XnMxT4vltbZmag/tlq/MHwoty4XcePpjI0vJXzPUQqMXkoT4PHs7Ss+QTNH6fIN
nwQF9ya79KT3yXY2VexNyxTOP1aUF2+5FlzDN2jNbH8L23lM9APLbayrf75d45amrrbLu7QiNQFE
QqdvkAok/8Xg4BpEIEw/r16YYJi8k4YhsC2LWGYEUouMc2yiWjBbJoRh06PIFm9eNb1QGDT8BkW2
i73C+T/w62iT8NL3r5WHzqdOmMRTlBSFjLdKAtxlIQUSTWmxfAZ9ER8sdiG2ODFMCvH/98i+Tpw0
dFjpLEEolwWu/RrXRmhHLdN1rfDo6sRzgBWUIvxHZS3X7DH7Xo5qOpspvXtJmXbxSxoHeMKF8HD5
Li/HYpJcWWhfCz2Sq5D29rxNwqonkICv0n8+xWDSD+QkImlAg1M0gHpcmPeitXpRtdBiKMOluOVQ
WxvZ3AvfOD8Tob/CTtDoCCYRRiyNJBDswWoBnW7bWfxiohGmDrZv9rzQbXfC7RhwfkryDn3zVA6K
jNinPyH9j/F41AvefUH73jwzFFnXIYo6HagzQzos5xyDM4jE7Woo3TbCFVfPLnpMpGOJYbpox7zo
oLcume1XpxEEwT7df8SHAwap/OBtsoYfHtEwKEHmDjDc3Vnjh6NygJOeid2eNVDEZxse71ydEqqt
+su36bwB+jwe5CqFPSdeLGoqkMjWQDpbqh5Mmd3tTPybfmaLuw5t+zc0pT30LIu17D8Po1o10i0S
HYexQ6e9DYLqzo3Z5BFFQy78QUmBABteJQs2r8Nyh/47IrCvkIaBXZngemy6+x/hThVkhVL1YQqi
fL+XbiF+BKou4KJcs0d72Tv7btwSSbvapQ/BF/kDVrjw6LNhRnbdZNpH5t2HqxJ7Ex7R1dLwc7Zc
Q8P2m63yfw1t/eRntCJ0QYKvOE2dEgKhffigyDjV1ml3MGkSyuLsyT73q4gSQ9+JqOuT7VkeIp+i
jkpO/HhjnACBZ9xm/A8eCIz34CdXmWXNo6sKPPGlSKdZmLIry4Rmv8h5MVI1DIRQ3nv60uCDGwGU
uNGcWryxaOIvryTiYkUEdSweUPbi6Y6AcbxJjxyvHT17gGIs8aTDzudNyJuHAGHkpW0YJkYUrRzC
JpMjqd7yMU/5P7gH6TStLxMyJQ9iQhDsevA5ZTey2deT/278ZJqee6rfuDNklM0iSWrr9R7fQ8yr
SCZ5Z8JQbX8of8eRwZEXTd4Y80ncVCvBPfntTQrxapAXNVbsohPAfmVjeZ7QzTawAHlY85CQ9r6s
747/8SRgs+ArlBHx0mAyBvoT8ZWvlfmLVlReUkNEjtAgCMclNBYTUZeQuLTFxHVveoPH8q4v1xs3
fatroRy4AyT+iEfBcWyU6hefsDrgSuOcYrGgcWreJxgoznesk6oHPSZE2dLqtn8lq9fEDludZFb9
IS7QZBG+mQzTrT4rDvRN2CWWuqVHKyF8Qf8wZfSHJv7FP0e8HDo+v7uGuzeDHdso64OGIwsTPTE7
4fU8OzMEvjWSwNpOJMvdHwX/eRAswtdcWbEt/qbYmbKsexiQetJ2hdoRFCNF5vMbIdvmnUs9HPPs
frjoBScW8LdL7f8AXRCKZsrg1GEYm43MJGRVYZ+UJQPo0qcuvTQD+3epl8DRp9SvkUYWYvjckknj
90ij91yZg3W/wPO6g4CVMJyZlXK0Lb8fvw6fGoXlKql/N4sKvniyGN2dtd5pBGvUApbyM/Hh/zTd
0nH4yrA7tevohyqFZPP2xq9NBsfuMYvbXtK1yCOA4XZa6PhO+07xO1PlL1Wr9ygpCln10SeCoGyG
vFehVX9Q+5Ysj21+22xlXoNHvdJ0huwxJv6O2cFr/H71wIY4PagUiqBWOAT8RGZLM9ZUjlxvA6U2
qPjTThLOXnJs3N6TbH40QY8+666eXGQUfLlEIvsQ6N7HC9wrM/Lvexxcm6HdOExjhaiygugAjgU8
c04GCqQmj5McD0XQEqyQqRZOyiDQmk6pkaTtXYgukW+2MB8H5d8QIxRUj5pNzZs6VLRXjG4k7qw7
FO0Jnfo9fzRl1wsJf3qAvghGtYUHO80KuiBZVB09D72m8lNvzBTh9pg9MinrLSp1Y0mAJUBYm6kY
kPVKJyypubN24YxfNZQrBOknxlsGQFvh540G3asV443GnkH6xVZFEtqM4tQ2YsDqcS/WW0apb8DU
l748GAwtvpwX+6ZxYD0u7eaEMmq9nu3De0etNRZgTuM8tKE93OWvvD9+xactqYkrTSkuR+1a5rol
AfdV3ItOqJgqefN+Ik6uO6nAEPdOsn2R13ELVu2MOBuwZgyvH/ciXuS+5tL3Z0wYcUpKnvJA9WyB
039W7K1lvzr7nyDBbj7zP/tQKc5L/Zgzokm6EbdGc7PQawCuM+ZTw63r65U8OI00ku0V01HwICOg
aUWtmgrOVQi9GzmIupN26OwBo5z85eFniYKT82gyfBO+oG23Q4JVonhK0JGk7BPpTLDSdY29gdpS
c16FjmwXnCO4D9Aiv2KN8+7oDxcNEa3uuTIPDhd/VzbNdhjkp8n+bFMsw/xnAr03BAdbdgOeKSnj
yO0vYmZAyrCFhhfP2c7ssRh5+mqNdzp5lb/73cjFpWGa+6d/emqDl1KItZCG00F/JYhp3k2XdS6i
eMatuASiyWAs5R+PnU5828TNwpZQBXbZKl4xIKpro4WBbEu2M9dd25hkrED/cyXntbmGTCMNs8tS
2eL7fYpykEfvWHbhtp1CA0FXLteQyP5Z4MnCXZD0oSIrr167JiB41SIUbwNGFzRiKfgdPtHj6VjJ
EgYHEIKIwjhSp9LoW1lnBpUGEGQCQb5g7+oj5E95sGUTniAYu8/GcoNVEJ2zUTgoIKbnXOr4I6wJ
EQ/jxgPW4e6uXNoRGxMnLqyTuI87pJhubn7dtdwa70mTPXMg5p2GP4Is3SrlCCRewrI2ySH/kvY4
t/+kBDhfFe8QLQ7wYBP3Y7s35CdaVPd7MGmf2HYXKHY33uvpc8a2lSRzvhjs59u0Ia3FtEX08R9E
dtEvCGpefqvQ/us5w9BeHyvhGvP+nttyB0NH1M4ibEpqHJ+d5A/2O45gdyXAVuSvIma68PWf6+C0
AN0Jhxo2RCKCYL73MnC/WusSCf0OBdnRk+zOQNWYq5B0LFNN+HzfmSpV8T4re8AHnT+Hu+mYyjQU
hTGd3jKRA4KQ7K6ojhlboBo+xWrghGasDwOAxlZkAvxY4dY9lEWHU0sJiubFGkrPxGpvp4Gy5LFk
B7flW19VV4fV1m3Gv/oxNLLT7B87IpKtuVXhoW23Pt80ssOkO0vU7nrjEpBClF1d9Gbi3D3LneKs
QRTwObHvmZ8KcwWIyL21QkleeURhI9uqvet418ivk6NoCPAzBcYIwCpCSRSsN9lbLAlcCL0d83pE
yTNFBaUSlcBE3BbiCmmO4GOUhZpyKdftou8gJL0BJtaazCj6W+/ytHmFJGpSnu9Q0uIYNCfh2Gmp
ULlU8NSLX0vz9kK2/i9E/4tHPWqKn8WeHSFyzAtKav+CKAVyVUg85jelGG0OEMXRqXubn7xuZNqL
amD8M+B6zwKTOUSrNQNMPwT+JaNhZEQ1FF8i205JkADd9OqhQzvhA03FbeInSHhdK8nxkohGBjP1
3skK076/r00OpHpeo1Hr6OGauTfUl8OosrymzBUxcKbj2N2v3HtQ4A6h+f1DcXa9Lw3J6Ss5OQ8M
QaLA6iGtpsXsGP0PWIkvBVtHNoS65OS/ljnSN/6+yvgXdE9ZP61jZ7+zbNgZTyJsZCuoSBQKROHy
gyIA8sLXeTjk/97uwEV8eMAMaLoiY+4GV2OJaR652wwRX2Vve61nJCrp2BsoE2WIBcxS/GmrYYfv
AThGZwnFbVhetovpP1NGTYtWJFiUcoxAL7QNXiM0kelk2zEz0XK+NGFUONaV6Pq5VOoLTbQMCOKm
C+lRhTujurTthvRLpEINXLpRxMBcXSt2mgNynrq/rfGCYIVdiFVeKuSYS6wkvbtnVzFaWXTs+yY8
0a6FeHiJtQaAYvmfxlqB748eveA75gJU1IsV0Xi8sreU+a7VCCSkb+i0C9egiREad2b4G6jSaIcJ
/LIjIViJsh2kZDdyRVi3CczP3dwgwZveFzgILcX3qT8MOLSn/lbTE0B7aOUNxJB4qPrakv86OHu1
PhWzrUXbWQIJYBfjPStBsGziR2CULMwNfzpAVq+u1Rd70xpBa8EngtlahQIgx8OHUf8tCJjsQOri
wRqldTDSjZsYZ5ilrb8PwPH9sJiClvESflBnSrSSrkKwVRvC7hSHtkjAG4d/OTBmWvkBWaAlzs8N
2bttB/li3ybu05vxYbERAzal8dra3/CtPM/Q03YY2XnxIqngNNIIp42h4/SnTpNdDfpoLviKbuXl
zjc3hEgNWkL7UAFP+f/atyMFYQLsyOpRjhGC+fATakh5lItloO4mf4xlu4SKinrB4gE9BHhaYFZU
TuFs7un+sRlQI4nYdEX72adhOlKTwwrl2aglMh+mjqVwsMJfogjO6Sg6p2dXfbhwzurO9+mEslT/
M5RKn9oNX792JgrWOepEHRK1Bx1RQBSYEO7+U9MQ4XHshHhSFr2YrSQg0gaYFfy21Ohg3C36D0jX
InNh1n10SMJ/NFtseVFua/VB372DxfsSB/Uky3QUkdgh23lya74WjXt3UkCQ7CMLShyUVJ7eUMxR
y0aySXSTD/Zohen0xYpaPdw2ly8HjyVbTYKwIqPsTF7HImIIofj/TqupALpDBnTh1UapwoqYSnHG
wrkVLxcusQ2NfMzwG2Hly/cbGUSgoIdXUEWOeQLQY2d3+CZraTMTZy5knXeAU9Jq/cF1ueK7ihjq
N126n8qFwVEXPfGTo9e58y8y8KkAzw++z36vMdpMSuRpuXSD5vsmXJF9UdaoiTAEWunHBYuL37Oo
9bEYZGINUbBWgSCwStK+Nq30eE/xvzebKiLTFJAaRpz2CqqZ6TAeBRYFBYlXROH7hle8JHPhBZbx
YJwiB49IMDRyOVPcaPxjfQBXhaF1SW0bUNw5saNGPPNlM+aYICLzqPxMwAuE2GC4ixK+Ih9P9ChE
N+UaSXMBRr/dj88zOdUIdlfJA8WvNntqnfOmXI64C1Oz98hbYc38J9LuXfyBqk1+3M8SdJqggWbL
xEl4fXUMkmGH0WNzM1/KZSt06EIV3ydUQScxFEj+QIP8gF3tNeNx6Z0sgqdPktVhNwl3v2INMB1e
eXp7RJfIEU8c9rM+0NjM6Iu2rR1JtdTcck9bOg1hIgXqd6/2nxZTbpHVJjtVrU8WQYZ64qvtKcl6
6ZYHGbwZXIFUl4BnwnbtSnGZyg2iARDla+lA9Q8qSXRLfEyckQ6cMYiObDzHcfMbhULzMuWNeOLY
TiYXDnUNNWhOjoe6hCDUUTMI+7E16P1TLbw6iaEdmNzMYHX+8WpbAvVYBXDX2yPvIWau1kDwuu5i
DMrDl72z3Mt7mCADvjquPHqhSqn06AV43NvPt3WO/xR4J+DQVs7WSUl8Du5n2NkmpW7sMOg8DUWr
FTfk3Iujq54ddUJK20pCTuD7Z0ruqp3FCJ+rKrny9Jx5RhAocyp3psxlL9b84F0SPAAkJi/1ExdQ
HdWIXPHVKv5WtBIOBgOn6fAOtJkcXRJtnwOY5+ap5Jd/YJ/q4hD+HPGKd5zJ2sGscda0sUbiBBra
ux4iqpR05Gp/1yooM4ERTFF1Qz+dj3Y12peNZIx1XwKAlqMeCbAexG3ZhaR5fWalCeCVEJBaBNcP
AX66iZ8utlJvua1jeiYrMaiDsIF/Tlhb4+eTk9zLj24aFaiLUAC/OLFxFWOhQjyeHJjkLmmjRxpz
Mle9CHWN4gozn7ER+KvdGVOeghmwJqnavIIwTXxZWSYKw/vt9ywEdPmr+95krN1wjQ5M9ZECKEk+
WIYjdFBYxGIHw97RafK1ReZ/dp79W+jTlKdbCUJ7XE6ILWKalwW9Lcqf2mqr0bPxDVK1k6bmaUn+
46MzyVGJrHtHgNK2EzIxF7qzJ+MJ9pGHx5llYLmr3mXNPyWAlZcxVCxTQhw8ayXKzWDpioMUpY8m
zmdxad0R2dqKMcFaJ61NeTrE4JbbayitVj4cYH87/9dzJ5SfuA0FJF8JLzNM8CPou1YnflPk2W9g
O4Bd8mioWFPlMq48tOinb4UNiHro/lNBe4pdPg+YkN3CE7Bfx9g4XGrqHOF/GYQkU4Eq9jBx0aR+
kh+WIWzcVRjChj5bakK52OiNatydoCYr0UpjvcNWFegCvIOXLama1BvQs6Jzs1JSTDNnkAicyffi
i+3aIKB6BeNWQb9q8zOpNow0ReSv6ptN1qQp8hkQhF1lFQdA7ZfhnbsBAzKpndM6BrDg/lBLAFH0
uMW0SUM5S5GqgvIrsXJsIiNEfb4h3IbkfKFr6a5Y6e47wKOCyOfXZRJRbBybZJkiFa4FLzltLF87
FhbnK57B1PMpXp0eSxsfeKymCfM=
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
