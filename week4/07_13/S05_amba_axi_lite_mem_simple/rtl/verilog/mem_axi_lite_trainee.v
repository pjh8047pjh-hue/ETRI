module mem_axi_lite
     #(parameter integer MEM_SIZE=1024
      ,parameter integer AXI_WIDTH_ADDR=32
      ,parameter integer AXI_WIDTH_DATA=32)
(      
  input wire aresetn
  , input wire aclk
  , input wire [31:0] s_axi_awaddr
  , input wire s_axi_awvalid
  , output reg s_axi_awready
  , input wire [31:0] s_axi_wdata
  , input wire s_axi_wvalid
  , output reg s_axi_wready
  , output reg [ 1:0] s_axi_bresp
  , output reg s_axi_bvalid
  , input wire s_axi_bready
  , input wire [31:0] s_axi_araddr
  , input wire s_axi_arvalid
  , output reg s_axi_arready
  , output reg [31:0] s_axi_rdata
  , output reg [ 1:0] s_axi_rresp
  , output reg s_axi_rvalid
  , input wire s_axi_rready
);

	localparam MEM_ADDR_WIDTH=$clog2(MEM_SIZE);
	reg [31:0] Mem [0:1<<(MEM_ADDR_WIDTH-2)];

	wire awaddr_recieved = s_axi_awvalid & s_axi_awready;
	wire write_recieved  = s_axi_wvalid  & s_axi_wready;
	wire araddr_recieved = s_axi_arvalid & s_axi_arready;

    // write port
	always @(posedge aclk or negedge aresetn) begin
        s_axi_awready <= 1'b1;
        s_axi_wready  <= 1'b1;

		if(!aresetn) begin
			s_axi_awready <= 1'b0;
			s_axi_wready  <= 1'b0;
			s_axi_bvalid  <= 1'b0;
        end else begin
            // write
            if(awaddr_recieved && write_recieved) begin
                Mem[s_axi_awaddr[MEM_ADDR_WIDTH-1:2]] <= s_axi_wdata;
                s_axi_bresp  <= 2'b00; // OKAY
                s_axi_bvalid <= 1'b1;
            end

            // write, write response 신호 초기화
            if(s_axi_bvalid && s_axi_bready) begin
                s_axi_bvalid <= 1'b0;
                s_axi_bresp  <= 2'bx;
            end
        end
	end

    // read port
    always @(posedge aclk or negedge aresetn) begin
        s_axi_arready <= 1'b1;

		if(!aresetn) begin
			s_axi_arready <= 1'b0;
        end else begin
            // read
            if(araddr_recieved) begin
                s_axi_rdata <= Mem[s_axi_araddr[MEM_ADDR_WIDTH-1:2]];
                s_axi_rresp <= 2'b00;
                s_axi_rvalid <= 1'b1;
            end

            // valid, read response 신호 초기화
            if(s_axi_rvalid && s_axi_rready) begin
                s_axi_rvalid <= 1'b0;
                s_axi_rresp  <= 2'bx;
            end
        end
    end
endmodule