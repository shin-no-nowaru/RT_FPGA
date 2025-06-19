`timescale 1ns / 1ps
module tb_SW_to_HEX0;

    logic [9:0] SW;
    logic [6:0] HEX0;
    logic [7:0] an;

    SW_to_HEX0 DUT (
        .SW_i   (SW),
        .HEX0_o (HEX0),
        .an_o   (an)
    );

    initial begin
        an = 8'b11111110;
        SW = 0;
        for(int i = 0; i != 1024; i++) begin
            #5;
            SW++;
        end
    end

endmodule