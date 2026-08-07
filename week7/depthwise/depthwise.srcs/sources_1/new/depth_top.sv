module depth_top #(
    parameter SP = 15,
    parameter DW = 16
)(
	input  logic 				   clk_in,
	input  logic 				   rst,
    input  logic                   start,
    input  logic signed [  DW-1:0] input_data,

	output logic signed [3*DW-1:0] data_out
);
  
   // import depthwise_pkg::*;
	wire  signed [9*DW-1:0] weight;
	wire locked, clk_100, clk;
    
	assign clk = clk_100;

	clk_wiz_0 clk_gen(.clk_out1(clk_100),
					  .locked(locked),
  					  .clk_in1(clk_in)
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