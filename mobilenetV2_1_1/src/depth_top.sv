module depth_top #(
    parameter SP = 16,
    parameter DW = 16
)(
	input  logic 				   clk,
	input  logic 				   rst,
    input  logic                   start,
    input  logic signed [2*DW-1:0] input_data,

	output logic 				   depth_output_valid,
	output logic signed [31:0] data_out
);

	logic signed [9*DW-1:0] weight_even, weight_odd;
	logic signed [31:0] bias_even, bias_odd;
	logic [8:0] channel_even_addr, channel_odd_addr;
	logic [7:0] bias_pair_addr;
	logic       channel_step;

	mem_depth_weight u1(.clk(clk),
						.rst(rst),
						.start_r(start),
						.data_out_even(weight_even),
						.data_out_odd(weight_odd),
						.channel_even_addr(channel_even_addr),
						.channel_odd_addr(channel_odd_addr)
						);

	always_ff @(posedge clk) begin
		if (rst || start) bias_pair_addr <= '0;
		else if (channel_step)
			bias_pair_addr <= (bias_pair_addr == 8'd191) ? '0 : bias_pair_addr + 1'b1;
	end

	depth_bias u_bias(
		.clka (clk), .ena (1'b1), .addra({bias_pair_addr, 1'b0}), .douta(bias_even),
		.clkb (clk), .enb (1'b1), .addrb({bias_pair_addr, 1'b0} + 1'b1), .doutb(bias_odd)
	);

	depth_mac #(
                        .SP(SP),
                        .DW(DW),
                        .CHANNEL_COUNT(192)
					) depth_mac_even(.clk(clk),
						.rst(rst),
						.start(start),
						.input_data(input_data[DW-1:0]),
						.weight(weight_even),
						.bias_data(bias_even),
						.depth_output_valid(depth_output_valid),
						.channel_step(channel_step),
						.data_out(data_out[15:0])
						);

	depth_mac #(
                        .SP(SP),
                        .DW(DW),
                        .CHANNEL_COUNT(192)
					) depth_mac_odd(.clk(clk),
						.rst(rst),
						.start(start),
						.input_data(input_data[2*DW-1:DW]),
						.weight(weight_odd),
						.bias_data(bias_odd),
						.depth_output_valid(),
						.channel_step(),
						.data_out(data_out[31:16])
						);

endmodule
