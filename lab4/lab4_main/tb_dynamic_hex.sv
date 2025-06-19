`timescale 1ns / 1ps
module tb_dynamic_hex;

logic       clk_i, SW_i, nkey_i;
logic [7:0] an_o;
logic       ca_o, cb_o, cc_o, cd_o, ce_o, cf_o, cg_o;

dynamic_hex DUT (
    .clk_i(clk_i),
    .SW_i(SW_i),
    .nkey_i(nkey_i),
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
    SW_i = 0; nkey_i = 1;
    @(negedge clk_i);
    nkey_i = 0;
    @(negedge clk_i);
    nkey_i = 1;
    repeat (60) @(negedge clk_i);
    SW_i = 1;
    repeat (64) @(negedge clk_i);
    $finish();
end
    
endmodule