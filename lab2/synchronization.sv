module synchronization 
#(
    parameter N = 8
) 
(
    input  logic            CLOCK_50_i,
    input  logic [N-1:0]    unsync_i,
    output logic [N-1:0]    sync_o
);

    logic [1:0][N-1:0] sync_reg;
    
    always_ff @( posedge CLOCK_50_i ) begin
        sync_reg[1:0] <= {sync_reg[0], unsync_i};
    end

    assign sync_o = sync_reg[1];

endmodule