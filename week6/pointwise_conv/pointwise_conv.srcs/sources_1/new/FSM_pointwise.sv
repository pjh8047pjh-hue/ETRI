module FSM_pointwise (
	input  logic clk,
	input  logic rst,
	input  logic start,

	output logic [5:0] ic_cnt,   // 0~63   inner  (IN_CH        = 64)
	output logic [8:0] oc_cnt,   // 0~383  middle (WEIGHT_WIDTH = 384)
	output logic [7:0] pix_cnt,  // 0~195  outer  (CHANNEL_WIDTH= 196)
	output logic mem_read_req,
	output logic en_mul
);
    
	import pointwise_pkg::*;

	typedef enum logic [1:0] {
		ST_IDLE, ST_LOAD, ST_MAC, ST_DONE
	} state_t;  

	state_t nstate, cstate;
	logic ic_last;
	logic oc_last;
	logic pix_last;

	// current state logic
	always_ff @(posedge clk or posedge rst) begin
		if(rst) cstate <= ST_IDLE;
		else	cstate <= nstate;
	end

	// LOAD에서 input/weight BRAM을 동시에 요청한다. 두 IP 모두 read
	// latency가 1 cycle이므로 다음 상태인 MAC에서 두 데이터가 함께 유효하다.
	always_comb begin
		nstate = cstate;

		case (cstate)
			ST_IDLE: if(start) nstate = ST_LOAD;
			ST_LOAD: nstate = ST_MAC;
			ST_MAC : if(ic_last) begin
				if(oc_last && pix_last)
					nstate = ST_DONE;
				else
					nstate = ST_LOAD;
			end
			ST_DONE: nstate = ST_IDLE;
			default: nstate = ST_IDLE;
		endcase
	end
	//-----------------------------------------------

	assign mem_read_req = (cstate == ST_LOAD);
	assign en_mul       = (cstate == ST_MAC);

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
