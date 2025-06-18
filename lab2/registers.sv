module registers (
    input  logic       CLOCK_50_i,
    input  logic [9:0] SW_i,
    input  logic [1:0] NKEY_i,
    output logic [9:0] LEDR_o,
    output logic [6:0] HEX0_o, HEX1_o
);
    // signals to be synchronized
    logic [1:0] unsync_KEY, KEY;
    logic [9:0] SW;

    // SW value register
    logic [9:0] SW_reg;

    // counter register
    logic [7:0] cnt;

    // KEY input synchronization
    synchronization 
    #(
        .N(2)
    ) KEY_synchronization
    (
        .CLOCK_50_i(CLOCK_50_i),
        .unsync_i(unsync_KEY),
        .sync_o(KEY)
    );
    
    // SW input synchronization
    synchronization 
    #(
        .N(10)
    ) SW_synchronization
    (
        .CLOCK_50_i(CLOCK_50_i),
        .unsync_i(SW_i),
        .sync_o(SW)
    );

    // 10-bit register connected to the LEDR
    always_ff @( posedge KEY[0] or posedge KEY[1] ) begin
        if (KEY[1]) SW_reg <= 10'd0;
        else SW_reg <= SW;
    end

    // event calculation + synchronization
    logic unsync_sw_event, sw_event;
    always_comb begin
        if ((SW[0] + SW[1] + SW[2] + SW[3] + SW[4] + SW[5] + SW[6] + SW[7] + SW[8] + SW[9]) < 4'd4) unsync_sw_event = 1'b1;
        else unsync_sw_event = 1'b0;
    end
    synchronization
    #(
        .N(1)
    ) event_synchronization
    (
        .CLOCK_50_i(CLOCK_50_i),
        .unsync_i(unsync_sw_event),
        .sync_o(sw_event)
    );

    // SW goes through 2 registers in sync module + SW_reg, KEY goes through 2 registers and SW_event too, then counter register
    always_ff @( posedge KEY[0] or posedge KEY[1] ) begin
        if (KEY[1]) cnt <= 8'd0;
        else if (sw_event) begin
            cnt <= cnt + 1'b1;
        end
    end

    logic [3:0] HEX0, HEX1;
    bin_to_hex first_hex (
        .val(HEX0),
        .otval(HEX0_o)
    );
    bin_to_hex second_hex (
        .val(HEX1),
        .otval(HEX1_o)
    );

    assign HEX0 = cnt[3:0];
    assign HEX1 = cnt[7:4];
    assign unsync_KEY = ~NKEY_i; // 2 inverters are not a crime (I hate work with active zeroes)
    assign LEDR_o = SW_reg;

endmodule