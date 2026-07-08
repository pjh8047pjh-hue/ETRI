module top(
	input clk,
	input rst,
	input start,
	input hold,
	output [6:0] ssd1,
	output [6:0] ssd2,
	output cat_1,
	output cat_2
);

wire clk_100;
wire sys_rst;
wire run_en;
wire [3:0] sec_1;
wire [3:0] sec_10;
wire [3:0] min_1;
wire [3:0] min_10;

clk_wiz_0 t_clk_wiz (
	.clk_in1(clk),
	.reset(rst),
	.clk_out1(clk_100),
	.locked()
);

assign sys_rst = rst;

FSM t_fsm (
	.rst(~sys_rst),
	.clk(clk_100),
	.hold(hold),
	.start(start),
	.cstate(run_en)
);

counter t_counter (
	.clk(clk_100),
	.rst(sys_rst),
	.en(run_en),
	.sec_1(sec_1),
	.sec_10(sec_10),
	.min_1(min_1),
	.min_10(min_10)
);

top_bcd2ssd t_display (
	.clk(clk_100),
	.rst(sys_rst),
	.sec_1(sec_1),
	.sec_10(sec_10),
	.min_1(min_1),
	.min_10(min_10),
	.ssd1(ssd1),
	.ssd2(ssd2),
	.cat1(cat_1),
	.cat2(cat_2)
);

endmodule