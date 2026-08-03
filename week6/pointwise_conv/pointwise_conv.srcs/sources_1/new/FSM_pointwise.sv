module FSM_pointwise (
	input  logic clk,
	input  logic rst,
	input  logic start,

	output logic [5:0] ic_cnt,   // 0~63   inner  (IN_CH        = 64)
	output logic [8:0] oc_cnt,   // 0~383  middle (WEIGHT_WIDTH = 384)
	output logic [7:0] pix_cnt,  // 0~195  outer  (CHANNEL_WIDTH= 196)

	// BRAM 에 실제로 내보내는 주소. 각 출력의 마지막 MAC cycle 에만 다음
	// 출력의 주소를 미리 낸다(prefetch). 그 외에는 현재 counter 와 같다.
	output logic [8:0] oc_addr,
	output logic [7:0] pix_addr,

	output logic mem_read_req,
	output logic en_mul
);

	import pointwise_pkg::*;

	typedef enum logic [1:0] {
		ST_IDLE, ST_MAC, ST_DONE
	} state_t;

	state_t nstate, cstate;
	logic ic_last;
	logic oc_last;
	logic pix_last;
	logic adv;

	// current state logic
	always_ff @(posedge clk or posedge rst) begin
		if(rst) cstate <= ST_IDLE;
		else	cstate <= nstate;
	end

	// 두 BRAM 모두 read latency 가 1 cycle 이다. 예전에는 ST_LOAD 한 cycle 을
	// 따로 두어 그 latency 를 가렸지만, 출력 워드마다 곱셈기가 한 cycle 씩
	// 놀아서 (384*196 = 75,264 cycle) 전체의 직렬 성분이 되었다.
	// 이제 ST_MAC 의 마지막 cycle 에 다음 출력의 주소를 미리 요청하므로
	// ST_MAC 을 벗어나지 않고 연속으로 누적할 수 있다.
	always_comb begin
		nstate = cstate;

		case (cstate)
			ST_IDLE: if(start) nstate = ST_MAC;
			ST_MAC : if(ic_last && oc_last && pix_last) nstate = ST_DONE;
			ST_DONE: nstate = ST_IDLE;
			default: nstate = ST_IDLE;
		endcase
	end
	//-----------------------------------------------

	// 현재 출력의 마지막 MAC cycle. 이 cycle 에 다음 출력을 prefetch 한다.
	assign adv = (cstate == ST_MAC) && ic_last;

	// ST_IDLE 의 start cycle 이 최초 read 를 담당한다. 이때 counter 가 모두
	// 0 이고 adv 도 0 이므로 주소 0 번이 그대로 나간다.
	assign mem_read_req = ((cstate == ST_IDLE) && start) || adv;
	assign en_mul       = (cstate == ST_MAC);

	assign oc_addr  = adv ? (oc_last ? 9'd0 : oc_cnt + 9'd1) : oc_cnt;
	assign pix_addr = (adv && oc_last) ? (pix_last ? 8'd0 : pix_cnt + 8'd1)
	                                   : pix_cnt;

    //-----------------index calculate----------------
    assign ic_last  = (ic_cnt  >= IN_CH - PARALLEL_CH);
    assign oc_last  = (oc_cnt  == WEIGHT_WIDTH - 1);
    assign pix_last = (pix_cnt == CHANNEL_WIDTH- 1);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ic_cnt <= 0;  
            oc_cnt <= 0;
            pix_cnt <= 0;
        end else if (en_mul) begin    
            ic_cnt <= ic_last ? 0 : ic_cnt + PARALLEL_CH;
            if (ic_last) begin
                oc_cnt <= oc_last ? 0 : oc_cnt + 1'b1;
                if (oc_last)
                    pix_cnt <= pix_last ? 0 : pix_cnt + 1'b1;
            end
        end
    end
    //-----------------------------------------------

endmodule
