module ram #(
    parameter NB_COL        = 4,
    parameter COL_WIDTH     = 8,
    parameter RAM_ADDR_BITS = 32,
    parameter WORD_WIDTH    = NB_COL*COL_WIDTH
) (
    input  logic                     clk_i,
    input  logic                     en_a_i,
    input  logic                     en_b_i,
    input  logic                     we_a_i,
    input  logic                     we_b_i,
    input  logic                     rst_i,
    input  logic                     en_reg_i,
    input  logic [RAM_ADDR_BITS-1:0] addr_a_i,
    input  logic [RAM_ADDR_BITS-1:0] addr_b_i,
    input  logic [WORD_WIDTH-1:0]    data_a_i,
    input  logic [WORD_WIDTH-1:0]    data_b_i,
    output logic [WORD_WIDTH-1:0]    data_a_o,
    output logic [WORD_WIDTH-1:0]    data_b_o
);
    
    localparam RAM_DEPTH = 2**RAM_ADDR_BITS;
    logic [WORD_WIDTH-1:0] bram [RAM_DEPTH-1:0];            // BRAM
    logic [WORD_WIDTH-1:0] ram_data_a_ff, ram_data_b_ff;    // out port registers
    logic [WORD_WIDTH-1:0] data_out_reg_ff;                 // additional register for a port

    always_ff @( posedge clk_i ) begin
        if (en_a_i) begin
            if (we_a_i)
                bram[addr_a_i] <= data_a_i;
            else
                ram_data_a_ff  <= bram[addr_a_i];
        end
    end

    always_ff @( posedge clk_i ) begin
        if (en_b_i) begin
            if (we_b_i)
                bram[addr_b_i] <= data_b_i;
            else
                ram_data_b_ff  <= bram[addr_b_i];
        end
    end

    always_ff @( posedge clk_i  ) begin
        if      (rst_i) 
            data_out_reg_ff <= {WORD_WIDTH{1'b0}};
        else if (en_reg_i)
            data_out_reg_ff <= ram_data_a_ff;
    end

    assign data_a_o = data_out_reg_ff;
    assign data_b_o = ram_data_b_ff;

endmodule