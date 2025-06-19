typedef enum logic [1:0] { S1, S2, S3, S4 } state_type;
module fsm (
    input  logic       clk_i, rst_i, // I don't consider rst_i as a physical key with cringe active zero, so testbench would be 0-1-0, not 1-0-1
    input  logic [1:0] control_signal,
    output logic [1:0] result
);

    import fsm_pkg::*;
    state_type next_state, state;

    always_comb begin
        case (state)
            S1:
            if (control_signal == b)      next_state = S2;
            else if (control_signal == a) next_state = S3;
            else if (control_signal == c) next_state = S4;
            S2:
            if (control_signal == a)      next_state = S3;
            S3:
            if (control_signal == c)      next_state = S4;
            S4: 
            if (control_signal == b)      next_state = S1;
            default: next_state = S1;
        endcase
    end

    always_ff @( posedge clk_i or posedge rst_i ) begin
        if (rst_i) state <= S1;
        else       state <= next_state;
    end

    assign result = state;
    
endmodule