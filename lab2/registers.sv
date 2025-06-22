module registers (
    input  logic       clk_i,
    input  logic [9:0] SW_i,
    input  logic [1:0] NKEY_i,
    output logic [9:0] LEDR_o,
    output logic [7:0] an_o,
    output logic       ca_o,
    output logic       cb_o,
    output logic       cc_o,
    output logic       cd_o,
    output logic       ce_o,
    output logic       cf_o,
    output logic       cg_o
);
    logic button_was_pressed;
    logic [1:0] KEY;

    // SW value register
    logic [9:0] SW_reg;

    // counter register
    logic [7:0] cnt;

    button_sync button (
        .clk(clk_i),
        .in(KEY[0]),
        .out(button_was_pressed)
    );

    // 10-bit register connected to the LEDR
    always_ff @( posedge clk_i or posedge KEY[1] ) begin
        if      (KEY[1])             SW_reg <= 10'd0;
        else if (button_was_pressed) SW_reg <= SW_i;
    end

    logic sw_event;
    always_comb begin
        if ((SW_i[0] + SW_i[1] + SW_i[2] + SW_i[3] + SW_i[4] + SW_i[5] + SW_i[6] + SW_i[7] + SW_i[8] + SW_i[9]) < 4'd4) sw_event = 1'b1;
        else sw_event = 1'b0;
    end

    always_ff @( posedge clk_i or posedge KEY[1] ) begin
        if (KEY[1]) cnt <= 8'd0;
        else if (button_was_pressed & sw_event) begin
            cnt <= cnt + 1'b1;
        end
    end

    hex_driver bin2hex (
        .clk_i(clk_i),
        .rst_i(KEY[1]),
        .data_i(cnt),
        .an(an_o),
        .ca(ca_o),
        .cb(cb_o),
        .cc(cc_o),
        .cd(cd_o),
        .ce(ce_o),
        .cf(cf_o),
        .cg(cg_o)
    );

    assign KEY          =   ~NKEY_i; // 2 inverters are not a crime (I hate work with active zeroes)
    assign LEDR_o       =   SW_reg;

endmodule