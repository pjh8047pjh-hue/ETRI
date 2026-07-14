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
	, input  wire  [31:0] bram_rd_data
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

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)begin
			bram_addr 	 <= 0;
			bram_rd		 <= 0;
			bram_wr 	 <= 0;
			bram_rd_data <= 0;
			bram_wr_data <= 0;
		end else begin
			if(bram_addr && bram_wr == ADDR_TX) begin
				bram_wr_data
			end
		end
		
	end


endmodule