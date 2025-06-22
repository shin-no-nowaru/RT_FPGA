module dynamic_hex(
    input logic        clk_i,
    input logic        SW_i,
    input logic        nkey_i,
    output logic [7:0] an_o,
    output logic       ca_o,
    output logic       cb_o,
    output logic       cc_o,
    output logic       cd_o,
    output logic       ce_o,
    output logic       cf_o,
    output logic       cg_o
    );

    logic key_i;
    logic [31:0] word1, word2, data;

    hex_driver bin2hex (
        .clk_i(clk_i),
        .rst_i(key_i),
        .data_i(data),
        .an(an_o),
        .ca(ca_o),
        .cb(cb_o),
        .cc(cc_o),
        .cd(cd_o),
        .ce(ce_o),
        .cf(cf_o),
        .cg(cg_o)
    );

    // I should use packages but I am lazy as hell
    assign word1 = 32'h01234516; // ENDPOINT
    assign word2 = 32'h7892a916; // QUADRANT
    assign data  = (SW_i) ? word2 : word1;
    assign key_i = ~nkey_i;

endmodule
