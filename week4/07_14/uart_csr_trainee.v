module uart_csr_trainee
	#(parameter BAUD_RATE=115_200
    		  , CLK_FREQ =100_000_000
              , VERSION  =32'h2024_0810
              , NAME     ="UART")
(
      input  wire         reset_n
    , input  wire         clk

	// bram style bus
    , input  wire  [ 7:0] bram_addr
	, input  wire  		  bram_rd
	, input  wire  		  bram_wr
	, output reg   [31:0] bram_rd_data
	, input  wire  [31:0] bram_wr_data

	// RX connection
	, input  wire  [ 7:0] rx_data
	, input  wire		  rx_valid
	, output  reg  		  rx_done

	// TX connection
	, output reg   [ 7:0] tx_data
	, output reg 		  tx_valid
	, input wire 		  tx_done
);

	localparam ADDR_RX = 8'h1C;
	localparam ADDR_TX = 8'h18;

	reg [7:0] rx_capture;

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)begin
			bram_rd_data <= 0;
			tx_data		 <= 0;
			tx_valid	 <= 0;
			rx_done		 <= 0;
			rx_capture	 <= 0;
		end else begin
			// TX: CPU writes ADDR_TX -> latch byte and kick off transmit
			if (bram_wr && bram_addr == ADDR_TX) begin
				tx_data  <= bram_wr_data[7:0];
				tx_valid <= 1'b1;
			end
			else if (tx_done == 1'b1) tx_valid <= 1'b0;

			// RX: uart engine hands us a byte -> latch it and ack
			if (rx_valid) begin
				rx_capture <= rx_data;
				rx_done    <= 1'b1;
			end
			else rx_done <= 1'b0;

			// CPU reads ADDR_RX -> return latched byte
			if (bram_rd && bram_addr == ADDR_RX) bram_rd_data <= {24'b0, rx_capture};
		end
	end


endmodule
