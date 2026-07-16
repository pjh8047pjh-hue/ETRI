module mem_axi
     #(parameter AXI_WIDTH_ID = 4 // ID width in bits
               , AXI_WIDTH_ADDR =32 // address width
               , AXI_WIDTH_DATA =32 // data width
               , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8)  // data strobe width
               , P_SIZE_IN_BYTES=1024)
(
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 axi_aresetn RST"  *) input  wire                      axi_aresetn,
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 axi_aclk CLK"     *) input  wire                      axi_aclk,
`ifndef __ICARUS__
    (* X_INTERFACE_PARAMETER = "CLK_DOMAIN axi_aclk,RUSER_WIDTH 0,WUSER_WIDTH 0,ARUSER_WIDTH 0,AWUSER_WIDTH 0,\
                                HAS_CACHE 0,HAS_LOCK 0,HAS_PROT 0,HAS_QOS 0,HAS_REGION 0" *)
`endif
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWID"    *) input  wire [AXI_WIDTH_ID-1:0]   s_axi_awid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR"  *) input  wire [AXI_WIDTH_ADDR-1:0] s_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWLEN"   *) input  wire [ 7:0]               s_axi_awlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWSIZE"  *) input  wire [ 2:0]               s_axi_awsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWBURST" *) input  wire [ 1:0]               s_axi_awburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input  wire                      s_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output reg                       s_axi_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WID"     *) input  wire [AXI_WIDTH_ID-1:0]   s_axi_wid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA"   *) input  wire [AXI_WIDTH_DATA-1:0] s_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB"   *) input  wire [AXI_WIDTH_STRB-1:0] s_axi_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WLAST"   *) input  wire                      s_axi_wlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID"  *) input  wire                      s_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY"  *) output reg                       s_axi_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BID"     *) output reg  [AXI_WIDTH_ID-1:0]   s_axi_bid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP"   *) output reg  [ 1:0]               s_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID"  *) output reg                       s_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY"  *) input  wire                      s_axi_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARID"    *) input  wire [AXI_WIDTH_ID-1:0]   s_axi_arid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR"  *) input  wire [AXI_WIDTH_ADDR-1:0] s_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARLEN"   *) input  wire [ 7:0]               s_axi_arlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARSIZE"  *) input  wire [ 2:0]               s_axi_arsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARBURST" *) input  wire [ 1:0]               s_axi_arburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input  wire                      s_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output reg                       s_axi_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RID"     *) output reg  [AXI_WIDTH_ID-1:0]   s_axi_rid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA"   *) output reg  [AXI_WIDTH_DATA-1:0] s_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP"   *) output reg  [ 1:0]               s_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RLAST"   *) output reg                       s_axi_rlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID"  *) output reg                       s_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY"  *) input  wire                      s_axi_rready
);

    localparam R_IDLE = 2'd0,
               R_DATA = 2'd1,
               R_RESP = 2'd2;
    
    localparam W_IDLE = 2'd0,
               W_DATA = 2'd1,
               W_RESP = 2'd2;

//--------------------------------------------------------------------------------------------------
    reg [AXI_WIDTH_ADDR-1:0] r_addr;
    reg [AXI_WIDTH_ID-1:0]   r_id;
    reg [7:0]                r_len;
    reg [7:0]                r_count;
    reg [2:0]                r_size;
    reg [1:0]                r_burst;
    reg [AXI_WIDTH_ADDR-1:0] r_wrap_base; // WRAP burst의 정렬된 하한 경계
    reg [AXI_WIDTH_ADDR-1:0] r_wrap_top;  // r_wrap_base + burst 전체 byte 수 (상한 경계)

    reg [31:0] mem [0:255];
    reg [ 1:0] rstate;
    reg [ 1:0] wstate;

    wire ar_fire;
    wire r_fire;
    wire [AXI_WIDTH_ADDR-1:0] ar_burst_bytes; // (beat_bytes) * (beat_count) = 1<<AxSIZE * (AxLEN+1)

    assign ar_fire = s_axi_arvalid && s_axi_arready;
    assign r_fire  = s_axi_rvalid  && s_axi_rready;
    assign ar_burst_bytes = ({{(AXI_WIDTH_ADDR-8){1'b0}}, s_axi_arlen} + 1'b1) << s_axi_arsize;

    // read state logic
    always @(posedge axi_aclk or negedge axi_aresetn) begin
        if(!axi_aresetn) begin
            rstate <= R_IDLE;
        end else begin
            case (rstate)
                R_IDLE: begin
                    if(ar_fire) begin
                        rstate      <= R_DATA;
                        r_addr      <= s_axi_araddr;
                        r_wrap_base <= s_axi_araddr & ~(ar_burst_bytes - 1'b1);
                        r_wrap_top  <= (s_axi_araddr & ~(ar_burst_bytes - 1'b1)) + ar_burst_bytes;
                    end
                end

                R_DATA: begin
                    // 메모리 read 수행
                    rstate <= R_RESP;
                end

                R_RESP: begin
                    if(r_fire) begin
                        if(r_count == r_len)begin
                            rstate <= R_IDLE;
                        end else begin
                            r_count <= r_count + 1'b1;

                                case (r_burst)
                                2'b00: begin // fixed
                                    r_addr <= r_addr;
                                end 

                                2'b01: begin // INCR 다음주소 = 현재 주소 + beat_bytes(1 << AxSIZE)
                                    r_addr <= r_addr + (1 << r_size);
                                end

                                2'b10: begin // WRAP: 경계 넘으면 r_wrap_base로 되감기
                                    if((r_addr + (1 << r_size)) >= r_wrap_top)
                                        r_addr <= r_wrap_base;
                                    else
                                        r_addr <= r_addr + (1 << r_size);
                                end
                                default: r_addr <= r_addr;
                                endcase

                            rstate <= R_DATA;
                        end
                    end                
                end
         endcase
        end
    end

    // read output logic
    always @(posedge axi_aclk or negedge axi_aresetn) begin
        if(!axi_aresetn) begin
            r_id    <= s_axi_arid;
            r_len   <= s_axi_arlen;
            r_size  <= s_axi_arsize;
            r_burst <= s_axi_arburst;
            r_count <= 0;

        end else begin
            case (rstate)
                R_IDLE: begin
                    s_axi_rvalid  <= 0;
                    s_axi_arready <= 1'b1;

                    if(ar_fire) begin
                        r_id    <= s_axi_arid;
                        r_len   <= s_axi_arlen;
                        r_size  <= s_axi_arsize;
                        r_burst <= s_axi_arburst;
                        r_count <= 0;
                    end
                end 

                R_DATA: begin
                    s_axi_rdata   <= mem[r_addr[9:2]];
                    s_axi_arready <= 1'b0;
                    s_axi_rvalid  <= 1'b1;
                    s_axi_rid     <= r_id;
                    s_axi_rresp   <= 2'b00;
                    s_axi_rlast   <= (r_count == r_len);
                end

                R_RESP: begin
                    // r_fire로 이 beat가 소비된 순간 rvalid를 내려서, 다음 beat의
                    // 실제 데이터가 R_DATA에서 새로 실릴 때까지 stale 값이 다시
                    // 새 beat로 오인되지 않게 한다.
                    if(r_fire) begin
                        s_axi_rvalid <= 1'b0;
                    end
                end

                default: ;
            endcase 
        end
    end
//--------------------------------------------------------------------------------------------------

    reg [AXI_WIDTH_ADDR-1:0] w_addr;
    reg [AXI_WIDTH_ID-1:0]   w_id;
    reg [7:0]                w_len;
    reg [7:0]                w_count;
    reg [2:0]                w_size;
    reg [1:0]                w_burst;
    reg [AXI_WIDTH_ADDR-1:0] w_wrap_base;
    reg [AXI_WIDTH_ADDR-1:0] w_wrap_top;  

    wire aw_fire;
    wire w_fire;
    wire b_fire;
    wire [AXI_WIDTH_ADDR-1:0] aw_burst_bytes; 

    assign aw_fire = s_axi_awvalid && s_axi_awready;
    assign w_fire  = s_axi_wvalid  && s_axi_wready;
    assign b_fire  = s_axi_bvalid  && s_axi_bready;
    assign aw_burst_bytes = ({{(AXI_WIDTH_ADDR-8){1'b0}}, s_axi_awlen} + 1'b1) << s_axi_awsize;

    // write state logic
    // AW는 W_IDLE에서만 받고(awready), W 데이터는 W_DATA에서만 받는다(wready).
    // WLAST는 마스터가 보내주는 신호라 그대로 믿고 W_RESP로 넘어간다(RLAST처럼 슬레이브가 직접 만들 필요 없음).
    always @(posedge axi_aclk or negedge axi_aresetn) begin
        if(!axi_aresetn) begin
            wstate <= W_IDLE;
        end else begin
            case (wstate)
                W_IDLE: begin
                    if(aw_fire) begin
                        wstate      <= W_DATA;
                        w_addr      <= s_axi_awaddr;
                        w_count     <= 0;
                        w_wrap_base <= s_axi_awaddr & ~(aw_burst_bytes - 1'b1);
                        w_wrap_top  <= (s_axi_awaddr & ~(aw_burst_bytes - 1'b1)) + aw_burst_bytes;
                    end
                end

                W_DATA: begin
                    if(w_fire) begin
                        w_count <= w_count + 1'b1;

                        case (w_burst)
                        2'b00: begin // fixed
                            w_addr <= w_addr;
                        end

                        2'b01: begin // INCR 다음주소 = 현재 주소 + beat_bytes(1 << AxSIZE)
                            w_addr <= w_addr + (1 << w_size);
                        end

                        2'b10: begin // WRAP: 경계 넘으면 w_wrap_base로 되감기
                            if((w_addr + (1 << w_size)) >= w_wrap_top)
                                w_addr <= w_wrap_base;
                            else
                                w_addr <= w_addr + (1 << w_size);
                        end
                        default: w_addr <= w_addr;
                        endcase

                        if(s_axi_wlast) begin
                            wstate <= W_RESP;
                        end
                    end
                end

                W_RESP: begin
                    if(b_fire) begin
                        wstate <= W_IDLE;
                    end
                end
            endcase
        end
    end

    // write output logic
    always @(posedge axi_aclk or negedge axi_aresetn) begin
        integer i;
        if(!axi_aresetn) begin
            w_id          <= 0;
            w_len         <= 0;
            w_size        <= 0;
            w_burst       <= 0;
            s_axi_awready <= 1'b0;
            s_axi_wready  <= 1'b0;
            s_axi_bvalid  <= 1'b0;
            s_axi_bresp   <= 2'b00;
            s_axi_bid     <= 0;

        end else begin
            case (wstate)
                W_IDLE: begin
                    s_axi_awready <= 1'b1;
                    s_axi_wready  <= 1'b0;

                    if(aw_fire) begin
                        w_id    <= s_axi_awid;
                        w_len   <= s_axi_awlen;
                        w_size  <= s_axi_awsize;
                        w_burst <= s_axi_awburst;
                    end
                end

                W_DATA: begin
                    s_axi_awready <= 1'b0;
                    s_axi_wready  <= 1'b1;

                    if(w_fire) begin
                        for(i=0; i<AXI_WIDTH_STRB; i=i+1) begin
                            if(s_axi_wstrb[i])
                                mem[w_addr[9:2]][8*i +: 8] <= s_axi_wdata[8*i +: 8];
                        end

                        if(s_axi_wlast) begin
                            s_axi_wready <= 1'b0;
                            s_axi_bvalid <= 1'b1;
                            s_axi_bresp  <= 2'b00;
                            s_axi_bid    <= w_id;
                        end
                    end
                end

                W_RESP: begin
                    if(b_fire) begin
                        s_axi_bvalid <= 1'b0;
                    end
                end

                default: ;
            endcase
        end
    end
endmodule

