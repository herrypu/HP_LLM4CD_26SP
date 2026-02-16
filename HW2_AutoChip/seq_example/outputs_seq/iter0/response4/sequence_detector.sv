module sequence_detector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);

    // State encoding
    typedef enum reg [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100,
        S5 = 3'b101,
        S6 = 3'b110,
        S7 = 3'b111
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

    // Next-state logic and Mealy output generation
    always @(*) begin
        sequence_found = 1'b0; // Default value
        case (current_state)
            S0: begin
                if (data == 3'b001) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (data == 3'b101) begin
                    sequence_found = 1'b1; // Found sequence at state S1
                    next_state = S2;
                end else begin
                    next_state = S0; // Reset to initial state
                end
            end
            S2: begin
                if (data == 3'b110) begin
                    next_state = S3;
                end else begin
                    next_state = S0; // Reset to initial state
                end
            end
            S3: begin
                if (data == 3'b000) begin
                    next_state = S4;
                end else begin
                    next_state = S0; // Reset to initial state
                end
            end
            S4: begin
                if (data == 3'b110) begin
                    next_state = S5;
                end else begin
                    next_state = S0; // Reset to initial state
                end
            end
            S5: begin
                if (data == 3'b110) begin
                    next_state = S6;
                end else begin
                    next_state = S0; // Reset to initial state
                end
            end
            S6: begin
                if (data == 3'b011) begin
                    next_state = S7;
                end else begin
                    next_state = S0; // Reset to initial state
                end
            end
            S7: begin
                if (data == 3'b101) begin
                    sequence_found = 1'b1; // Found sequence at state S7
                    next_state = S0; // Reset to initial state or any next state if continuous detection is needed
                end else begin
                    next_state = S0; // Reset to initial state
                end
            end
            default: begin
                next_state = S0; // Default/reset state
            end
        endcase
    end

endmodule
