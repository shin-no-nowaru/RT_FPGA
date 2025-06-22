module hex_driver(
  input logic        clk_i,
  input logic        rst_i,
  input logic [31:0] data_i,

  output logic [7:0] an,
  output logic       ca,
  output logic       cb,
  output logic       cc,
  output logic       cd,
  output logic       ce,
  output logic       cf,
  output logic       cg
);

  logic [2:0] clk_div_ff;
  logic [2:0] scan_cnt_ff;
  logic [3:0] dc_hex_data;
  logic [6:0] seg;

  always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      clk_div_ff <= 3'd0;
    else
      clk_div_ff <= clk_div_ff + 1;
  end

  always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      scan_cnt_ff <= 3'd0;
    else if(clk_div_ff == 0)
      scan_cnt_ff <= scan_cnt_ff + 1;
  end

  always_comb begin
    case (scan_cnt_ff)
      3'd0: dc_hex_data = data_i[3:0];
      3'd1: dc_hex_data = data_i[7:4];
      3'd2: dc_hex_data = data_i[11:8];
      3'd3: dc_hex_data = data_i[15:12];
      3'd4: dc_hex_data = data_i[19:16];
      3'd5: dc_hex_data = data_i[23:20];
      3'd6: dc_hex_data = data_i[27:24];
      3'd7: dc_hex_data = data_i[31:28];
    endcase
  end

//   ___A
// F|   |
//  |___|B
// E| G |
//  |___|C
//  D

  always_comb begin
    case(dc_hex_data)
      4'h0:    seg = 7'b0000110; // E letter
      4'h1:    seg = 7'b0101011; // N letter
      4'h2:    seg = 7'b0100001; // D letter
      4'h3:    seg = 7'b0001100; // P letter
      4'h4:    seg = 7'b1000000; // O letter
      4'h5:    seg = 7'b1001111; // I letter
      4'h6:    seg = 7'b0000111; // T letter
      4'h7:    seg = 7'b0011000; // Q letter
      4'h8:    seg = 7'b1000001; // U letter
      4'h9:    seg = 7'b0001000; // A letter
      4'ha:    seg = 7'b0101111; // R letter
      default: seg = 7'b1111111; // empty
    endcase
  end

  // Anode demux
  always_comb begin
    case (scan_cnt_ff)
      3'd0: an = 8'b11111110;
      3'd1: an = 8'b11111101;
      3'd2: an = 8'b11111011;
      3'd3: an = 8'b11110111;
      3'd4: an = 8'b11101111;
      3'd5: an = 8'b11011111;
      3'd6: an = 8'b10111111;
      3'd7: an = 8'b01111111;
    endcase
  end

  assign ca = seg[0];
  assign cb = seg[1];
  assign cc = seg[2];
  assign cd = seg[3];
  assign ce = seg[4];
  assign cf = seg[5];
  assign cg = seg[6];


endmodule