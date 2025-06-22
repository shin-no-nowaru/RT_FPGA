module button_sync(
  input  logic clk,
  input  logic in,
  output logic out
);

  logic [2:0] button_syncroniser;
  logic       button_was_pressed;

  always_ff @(posedge clk) begin
    button_syncroniser[0] <= in;
    button_syncroniser[1] <= button_syncroniser[0];
    button_syncroniser[2] <= button_syncroniser[1];
  end

  assign button_was_pressed = ~button_syncroniser[2]
                            &  button_syncroniser[1];

  assign out = button_was_pressed;

endmodule
