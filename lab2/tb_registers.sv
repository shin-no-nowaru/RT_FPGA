`timescale 1ns / 1ps
module tb_registers;

    logic       clk_i;
    logic [9:0] SW_i;
    logic [1:0] NKEY_i;
    logic [9:0] LEDR_o;
    logic [7:0] an_o;
    logic ca_o,
          cb_o,
          cc_o,
          cd_o,
          ce_o,
          cf_o,
          cg_o;

    registers DUT (
        .clk_i(clk_i),
        .SW_i(SW_i),
        .NKEY_i(NKEY_i),
        .LEDR_o(LEDR_o),
        .an_o(an_o),
        .ca_o(ca_o),
        .cb_o(cb_o),
        .cc_o(cc_o),
        .cd_o(cd_o),
        .ce_o(ce_o),
        .cf_o(cf_o),
        .cg_o(cg_o)
    );

    localparam CLK_PERIOD = 10;
    initial clk_i = 1'b0;
    always #(CLK_PERIOD/2) clk_i = ~clk_i;
    
    initial begin
        SW_i = 10'd0; NKEY_i[0] = 1'b1; NKEY_i[1] = 1'b0;
        repeat(5) @(negedge clk_i);
        NKEY_i[1] = 1'b1; SW_i = 10'b0000000111;
        repeat(5) @(negedge clk_i);
        NKEY_i[0] = 1'b0;
        repeat(5) @(negedge clk_i);
        repeat(50) begin
            NKEY_i[0] = 1'b1;
            @(negedge clk_i);
            NKEY_i[0] = 1'b0;
            @(negedge clk_i);
        end
        $finish();
    end

endmodule