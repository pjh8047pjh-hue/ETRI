module depth_top #(
    parameter SP = 16,
    parameter DW = 16
)(
	input  logic 				   clk,
	input  logic 				   rst,
    input  logic                   start,
    input  logic signed [  DW-1:0] input_data,

	output logic 				   depth_output_valid,
	output logic signed [15:0] data_out
);

	logic signed [9*DW-1:0] weight;

	mem_depth_weight u1(.clk(clk),
						.rst(rst),
						.start_r(start),
						.data_out(weight)
						);

	depth_mac #(
                        .SP(SP),
                        .DW(DW)
                    ) depth_mac(.clk(clk),
						.rst(rst),
						.start(start),
						.input_data(input_data),
						.weight(weight),
						.depth_output_valid(depth_output_valid),
						.data_out(data_out)
						);

endmodule
