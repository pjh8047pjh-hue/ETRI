module counter(
    input clk,
    input rst,
    input en,

    output reg [3:0] sec_1,
    output reg [3:0] sec_10,
    output reg [3:0] min_1,
    output reg [3:0] min_10
);

reg [26:0] cnt;
wire tick = (cnt == 10**8 - 1);

always @(posedge clk, posedge rst) begin
    if(rst)begin
        cnt <= 0;
        sec_1 <= 0;
        sec_10 <= 0;
        min_1 <= 0;
        min_10 <= 0;
    end
    else if (en) begin
        if (tick) begin
            cnt <= 0;
            sec_1 <= sec_1 + 1;
            if(sec_1 == 9) begin
                sec_1 <= 0;
                sec_10 <= sec_10 + 1;
                if (sec_10 == 5) begin
                    sec_10 <= 0;
                    min_1 <= min_1 + 1;
                    if (min_1 == 9) begin
                        min_1 <= 0;
                        min_10 <= min_10 + 1;
                        if (min_10 == 5) begin
                            min_10 <= 0;
                        end
                    end
                end
            end
        end
        else begin
            cnt <= cnt + 1;
        end
    end
end

endmodule
