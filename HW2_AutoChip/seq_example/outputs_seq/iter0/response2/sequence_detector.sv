module sequence_detector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);
    
    // State Encoding
    parameter S0 = 3'b000,  // Initial state
              S1 = 3'b001,  // First value of the sequence
              S2 = 3'b010,  // Second value of the sequence
              S3 = 3'b011,  // Third value of the sequence
              S4 = 3'b100,  // Fourth value of the sequence
              S5 = 3'b101,  // Fifth value of the sequence
              S6 = 3'b110,  // Sixth value of the sequence
              S7 = 3'b111;  // Seventh value of the sequence
  
    reg [2:0] state, next_state;

    // State Transition Logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= S0; // Reset to initial state
        else
            state <= next_state; // Update state on clock edge
    end

    // Next State Logic and Mealy Output
    always @(*) begin
        // Default values
        next_state = state; // Stay in the same state
        sequence_found = 1'b0; // Default output to low

        case (state)
            S0: if (data == 3'b001) next_state = S1; // Transition to S1
            S1: if (data == 3'b101) next_state = S2; // Transition to S2
            S2: if (data == 3'b110) next_state = S3; // Transition to S3
            S3: if (data == 3'b000) next_state = S4; // Transition to S4
            S4: if (data == 3'b110) next_state = S5; // Transition to S5
            S5: if (data == 3'b110) next_state = S6; // Transition to S6
            S6: if (data == 3'b011) next_state = S7; // Transition to S7
            S7: begin
                    if (data == 3'b101) begin
                        sequence_found = 1'b1; // Mealy output goes high
                        next_state = S1; // Can start a new sequence at S1
                    end
                end
            default: next_state = S0; // Fallback to initial state
        endcase
    end

endmodule
