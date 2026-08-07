module depth_top #(
    parameter SP = 15,
    parameter DW = 16
)(
	input  logic 				   clk,
	input  logic 				   rst,
    input  logic                   start,
    input  logic signed [  DW-1:0] input_data,

	output logic signed [3*DW-1:0] data_out
);
 
	mem_depth_weight u1(.clk(clk),
						.rst(rst),
						.start_r(start),
						.data_out(weight)
						);

	depth_mac depth_mac(.clk(clk),
						.rst(rst),
						.start(start),
						.input_data(input_data),
						.weight(weight),
						.data_out(data_out)
						);

endmodule