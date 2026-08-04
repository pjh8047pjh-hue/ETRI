module depth_mac (
    input  logic clk,
    input  logic rst,
    input  logic start,

    input  logic 
    input  logic [143:0] weight,

    output logic data_out
);
    localparam SP = 15;
    localparam DW = 16;

    depth_weight_bram(.data_out());

    depth_input_bram(.data_out())

    // data logic
    logic [SP*DP-1:0] line_buf_2;
    logic [SP*DP-1:0] line_buf_1;

    wire signed [DW-1:0] bot = input_data;
    wire signed [DW-1:0] mid = line_buf_1[SP*DW-1 -: DW];
    wire signed [DW-1:0] top = line_buf_2[SP*DW-1 -: DW]; 

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            data_out   <= 0;
        end else begin
            line_buf_1 <= {line_buf_1, bot};
            line_buf_2 <= {line_buf_2, mid};
        end
    end

    //

    //
endmodule