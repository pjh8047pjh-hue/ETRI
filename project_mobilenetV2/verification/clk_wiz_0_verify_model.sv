`timescale 1ns / 1ps

// Test-only replacement for clk_wiz_0. The generated simulation output
// product is stale (40 MHz input) while the XCI is configured for 100->450 MHz.
// This file is intentionally not part of the Vivado project source set.
module clk_wiz_0 (
    input  wire clk_in1,
    output logic clk_out1,
    output logic locked
);
    initial begin
        clk_out1 = 1'b0;
        locked   = 1'b0;
        #100 locked = 1'b1;
    end

    always #1.111111 clk_out1 = ~clk_out1;

    wire unused_clk_in1 = clk_in1;
endmodule
