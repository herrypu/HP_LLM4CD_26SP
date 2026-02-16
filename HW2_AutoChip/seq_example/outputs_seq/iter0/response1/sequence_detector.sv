module sequence_detector(
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);

    // State encoding
    typedef enum reg [3:0] {
        S0 = 4'b0000, // Initial state
        S1 = 4'b0001, // 0 (step 1)
        S2 = 4'b0010, // 0 (step 2)
        S3 = 4'b0011, // 1 (step 3)
        S4 = 4'b0100, // 1 (step 4)
        S5 = 4'b0101, // 0 (step 5)
        S6 = 4'b0110, // 1 (step 6)
        S7 = 4'b0111, // 1 (step 7)
        S8 = 4'b1000  // 0 (step 8) (Final state)
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default assignment
        next_state = current_state;
        sequence_found = 1'b0; // Default output is low

        case (current_state)
            S0: begin
                if (data == 3'b001)
                    next_state = S1;
            end
            
            S1: begin
                if (data == 3'b001)
                    next_state = S1; // Stay in S1 for 0
                else if (data == 3'b101)
                    next_state = S2; // Move to S2 for 1
                else
                    next_state = S0; // Go back to S0 for any other input
            end

            S2: begin
                if (data == 3'b101)
                    next_state = S3; // Move to S3 for 1
                else
                    next_state = S0; // Go back to S0 otherwise
            end

            S3: begin
                if (data == 3'b110)
                    next_state = S4; // Move to S4 for 1
                else
                    next_state = S0; // Go back to S0 otherwise
            end

            S4: begin
                if (data == 3'b000)
                    next_state = S5; // Move to S5 for 0
                else
                    next_state = S0; // Go back to S0 otherwise
            end

            S5: begin
                if (data == 3'b110)
                    next_state = S6; // Move to S6 for 1
                else
                    next_state = S0; // Go back to S0 otherwise
            end

            S6: begin
                if (data == 3'b110)
                    next_state = S7; // Move to S7 for 1
                else
                    next_state = S0; // Go back to S0 otherwise
            end

            S7: begin
                if (data == 3'b011)
                    next_state = S8; // Move to S8 for 0
                else
                    next_state = S0; // Go back to S0 otherwise
            end

            S8: begin
                if (data == 3'b101) begin
                    sequence_found = 1'b1; // Sequence found in the same cycle
                    next_state = S1; // Return to S1 for further detections
                end else begin
                    next_state = S0; // Go back to S0 otherwise
                end
            end

            default: next_state = S0; // Default case to handle unexpected states
        endcase
    end

endmodule
