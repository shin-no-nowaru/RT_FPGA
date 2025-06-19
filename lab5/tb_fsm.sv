`timescale 1ns/1ps
import fsm_pkg::*;
module tb_fsm;
    
    logic       clk_i, rst_i;
    logic [1:0] control_signal, result;

    fsm DUT (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .result(result),
        .control_signal(control_signal)
    );

    localparam CLK_PERIOD = 10;
    initial clk_i = 0;
    always #(CLK_PERIOD/2) clk_i = ~clk_i;

    initial begin
        rst_i = 0; #1; rst_i = 1; #1; rst_i = 0;
        control_signal = b;
        @(negedge clk_i);
        control_signal = a;
        @(negedge clk_i);
        control_signal = c;
        @(negedge clk_i);
        control_signal = b;
        @(negedge clk_i);
        control_signal = a;
        @(negedge clk_i);
        control_signal = b;
        @(negedge clk_i);
        $finish();
    end

endmodule