module sequence_detector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);

    // State encoding
    typedef enum reg [3:0] {
        S0 = 4'b0000,
        S1 = 4'b0001,
        S2 = 4'b0010,
        S3 = 4'b0011,
        S4 = 4'b0100,
        S5 = 4'b0101,
        S6 = 4'b0110,
        S7 = 4'b0111,
        S8 = 4'b1000  // Final state after receiving last sequence
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic and Mealy output
    always @(*) begin
        sequence_found = 1'b0;  // Default output
        case (current_state)
            S0: begin
                if (data == 3'b001)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (data == 3'b101)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (data == 3'b110)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (data == 3'b000)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                if (data == 3'b110)
                    next_state = S5;
                else
                    next_state = S0;
            end
            S5: begin
                if (data == 3'b110)
                    next_state = S6;
                else
                    next_state = S0;
            end
            S6: begin
                if (data == 3'b011)
                    next_state = S7;
                else
                    next_state = S0;
            end
            S7: begin
                if (data == 3'b101) begin
                    sequence_found = 1'b1; // Mealy output
                    next_state = S8; // Transition to S8
                end
                else
                    next_state = S0;
            end
            default: begin
                next_state = S0;
            end
        endcase
    end

endmodule
