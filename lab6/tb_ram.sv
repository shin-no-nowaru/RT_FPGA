`timescale 1ns / 1ps
module tb_ram;
    
localparam NB_COL           = 4;
localparam COL_WIDTH        = 8;
localparam RAM_ADDR_BITS    = 32;
localparam WORD_WIDTH       = NB_COL*COL_WIDTH;

logic                     clk_i;
logic                     en_a_i;
logic                     en_b_i;
logic [NB_COL-1:0]        we_a_i;
logic [NB_COL-1:0]        we_b_i;
logic                     rst_i;
logic                     en_reg_i;
logic [RAM_ADDR_BITS-1:0] addr_a_i;
logic [RAM_ADDR_BITS-1:0] addr_b_i;
logic [WORD_WIDTH-1:0]    data_a_i;
logic [WORD_WIDTH-1:0]    data_b_i;
logic [WORD_WIDTH-1:0]    data_a_o;
logic [WORD_WIDTH-1:0]    data_b_o;

ram #(
    .NB_COL(NB_COL),
    .COL_WIDTH(COL_WIDTH),
    .RAM_ADDR_BITS(RAM_ADDR_BITS)
) DUT (
    .clk_i(clk_i),
    .en_a_i(en_a_i),
    .en_b_i(en_b_i),
    .we_a_i(we_a_i),
    .we_b_i(we_b_i),
    .rst_i(rst_i),
    .en_reg_i(en_reg_i),
    .addr_a_i(addr_a_i),
    .addr_b_i(addr_b_i),
    .data_a_i(data_a_i),
    .data_b_i(data_b_i),
    .data_a_o(data_a_o),
    .data_b_o(data_b_o)
);

localparam CLK_PERIOD = 10;
initial clk_i = 0;
always #(CLK_PERIOD/2) clk_i = ~clk_i;

initial begin
    rst_i = 1;
    @(negedge clk_i);
    rst_i    = 0;
    en_reg_i = 1;
    en_a_i   = 1;
    en_b_i   = 1;
    we_a_i   = 4'b1111;
    we_b_i   = 4'b1111;
    addr_a_i = 32'heeeeeeee;
    addr_b_i = 32'heeeeeeee;
    data_a_i = 0;
    data_b_i = 0;
    for (int i = 0; i < 2^RAM_ADDR_BITS; i++) begin
        @(posedge clk_i);
        data_a_i++;
        data_b_i++;
    end
end

endmodule