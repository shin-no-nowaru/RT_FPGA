`timescale 1ns / 1ps
module tb_registers;

    logic       CLOCK_50_i;
    logic [9:0] SW_i;
    logic [1:0] NKEY_i;
    logic [9:0] LEDR_o;
    logic [6:0] HEX0_o, HEX1_o;

    registers DUT (
        .CLOCK_50_i(CLOCK_50_i),
        .SW_i(SW_i),
        .NKEY_i(NKEY_i),
        .LEDR_o(LEDR_o),
        .HEX0_o(HEX0_o),
        .HEX1_o(HEX1_o)
    );

    localparam CLK_PERIOD = 10;
    initial CLOCK_50_i = 1'b0;
    always #(CLK_PERIOD/2) CLOCK_50_i = ~CLOCK_50_i;
    
    initial begin
        SW_i = 10'd0; NKEY_i[0] = 1'b1; NKEY_i[1] = 1'b0;
        repeat(5) @(negedge CLOCK_50_i);
        NKEY_i[1] = 1'b1; SW_i = 10'b0000000111;
        repeat(5) @(negedge CLOCK_50_i);
        NKEY_i[0] = 1'b0;
        repeat(5) @(negedge CLOCK_50_i);
        repeat(10) begin
            NKEY_i[0] = 1'b1;
            @(negedge CLOCK_50_i);
            NKEY_i[0] = 1'b0;
            @(negedge CLOCK_50_i);
        end
        $finish();
    end

endmodule