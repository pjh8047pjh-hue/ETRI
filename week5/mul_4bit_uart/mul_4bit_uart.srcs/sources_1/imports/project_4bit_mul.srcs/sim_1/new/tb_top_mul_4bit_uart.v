`timescale 1ns / 1ps

module tb_top_mul_4bit_uart();

    localparam CLK_PERIOD     = 25; // 보드 입력 40 MHz
    localparam SYS_CLK_PERIOD = 10; // clk_wiz_0 출력 100 MHz
    localparam CLK_FREQ       = 100_000_000;
    localparam BAUD_RATE  = 115200;
    localparam integer DIVISOR    = CLK_FREQ / BAUD_RATE;
    localparam real    BIT_PERIOD = DIVISOR * SYS_CLK_PERIOD;

    reg  clk;
    reg  rx_data;
    wire tx_data;

    integer pass_count = 0;
    integer fail_count = 0;
    reg [7:0] received_char;
    reg [7:0] result_ascii;

    top_mul_4bit dut (
        .clk(clk),
        .rx_data(rx_data),
        .tx_data(tx_data)
    );

    initial clk = 1'b0;
    always #(CLK_PERIOD/2) clk = ~clk;

    function [7:0] hex_to_ascii;
        input [3:0] value;
        begin
            hex_to_ascii = (value < 10) ? ("0" + value)
                                         : ("A" + value - 10);
        end
    endfunction

    function [3:0] ascii_to_hex;
        input [7:0] ascii;
        begin
            ascii_to_hex = (ascii <= "9") ? (ascii - "0")
                                           : (ascii - "A" + 10);
        end
    endfunction

    task send_uart_byte(input [7:0] data);
        integer bit_no;
        begin
            rx_data = 1'b0;
            #(BIT_PERIOD);
            for (bit_no = 0; bit_no < 8; bit_no = bit_no + 1) begin
                rx_data = data[bit_no];
                #(BIT_PERIOD);
            end
            rx_data = 1'b1;
            #(BIT_PERIOD);
        end
    endtask

    task recv_uart_byte(output [7:0] data);
        integer bit_no;
        begin
            @(negedge tx_data);
            #(BIT_PERIOD + BIT_PERIOD/2);
            for (bit_no = 0; bit_no < 8; bit_no = bit_no + 1) begin
                data[bit_no] = tx_data;
                #(BIT_PERIOD);
            end
        end
    endtask

    task run_case(input [3:0] a_in, input [3:0] b_in);
        reg [7:0] actual;
        reg [7:0] expected;
        begin
            expected = a_in * b_in;
            send_uart_byte(hex_to_ascii(a_in));
            send_uart_byte(" ");
            send_uart_byte(hex_to_ascii(b_in));

            recv_uart_byte(received_char);
            result_ascii[7:4] = ascii_to_hex(received_char);
            recv_uart_byte(received_char);
            result_ascii[3:0] = ascii_to_hex(received_char);
            actual = result_ascii;

            // CR, LF, "> "
            recv_uart_byte(received_char);
            recv_uart_byte(received_char);
            recv_uart_byte(received_char);
            recv_uart_byte(received_char);

            if (actual == expected) begin
                pass_count = pass_count + 1;
                $display("[PASS] %0h x %0h = %02h", a_in, b_in, actual);
            end else begin
                fail_count = fail_count + 1;
                $display("[FAIL] %0h x %0h expected %02h, got %02h",
                         a_in, b_in, expected, actual);
            end
        end
    endtask

    initial begin
        #(BIT_PERIOD * 500);
        $display("TIMEOUT: simulation did not finish in time");
        $finish;
    end

    initial begin
        rx_data = 1'b1;
        #(CLK_PERIOD * 50);

        // 설정 직후 prompt "> "
        recv_uart_byte(received_char);
        recv_uart_byte(received_char);

        run_case(4'h3, 4'h5);
        run_case(4'hF, 4'hF);
        run_case(4'h0, 4'hC);
        run_case(4'hA, 4'hB);

        $display("---------------------------------------------");
        $display("RESULT: %0d passed, %0d failed", pass_count, fail_count);
        $display("---------------------------------------------");

        #(BIT_PERIOD * 5);
        $finish;
    end

endmodule
