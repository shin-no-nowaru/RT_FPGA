module SW_to_HEX0 (
    input  logic [9:0] SW_i,
    output logic [6:0] HEX0_o,
    output logic [7:0] an_o
);

    logic [3:0] MUX_o;
    logic [3:0] DC1_o;
    logic [3:0] DC2_o;
    logic [3:0] F_o;
    logic [1:0] control_signals;

    always_comb begin

        DC1_o = SW_i[3:0] >> 1;
        DC2_o = SW_i[7:4] & 4'b1010;
        F_o   = (SW_i[0] ^ SW_i[3]) & (SW_i[1] || SW_i[2]);

        case (control_signals)
            2'b00: MUX_o = DC1_o;
            2'b01: MUX_o = DC2_o;
            2'b10: MUX_o = F_o;
            2'b11: MUX_o = SW_i[3:0];
            default: MUX_o = 0;
        endcase

        case (MUX_o)
            4'h0: HEX0_o = 7'b1000000;
            4'h1: HEX0_o = 7'b1111001;
            4'h2: HEX0_o = 7'b0100100;
            4'h3: HEX0_o = 7'b0110000;
            4'h4: HEX0_o = 7'b0011001;
            4'h5: HEX0_o = 7'b0010010;
            4'h6: HEX0_o = 7'b0000010;
            4'h7: HEX0_o = 7'b1111000;
            4'h8: HEX0_o = 7'b0000000;
            4'h9: HEX0_o = 7'b0010000;
            4'hA: HEX0_o = 7'b0001000;
            4'hB: HEX0_o = 7'b0000011;
            4'hC: HEX0_o = 7'b1000110;
            4'hD: HEX0_o = 7'b0100001;
            4'hE: HEX0_o = 7'b0000110;
            4'hF: HEX0_o = 7'b0001110;
            default: HEX0_o = 0;
        endcase

    end

    assign control_signals = SW_i[9:8];
    assign an_o            = 8'b11111110;

endmodule