module bin_to_hex(
    input  logic [3:0] val,
    output logic [6:0] otval
    );
    always_comb begin
        case (val)
            4'h0: otval = 7'b1000000;
            4'h1: otval = 7'b1111001;
            4'h2: otval = 7'b0100100;
            4'h3: otval = 7'b0110000;
            4'h4: otval = 7'b0011001;
            4'h5: otval = 7'b0010010;
            4'h6: otval = 7'b0000010;
            4'h7: otval = 7'b1111000;
            4'h8: otval = 7'b0000000;
            4'h9: otval = 7'b0010000;
            4'hA: otval = 7'b0001000;
            4'hB: otval = 7'b0000011;
            4'hC: otval = 7'b1000110;
            4'hD: otval = 7'b0100001;
            4'hE: otval = 7'b0000110;
            4'hF: otval = 7'b0001110;
            default: otval = 0;
        endcase
    end
endmodule
