module sequence_detector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);
    typedef enum logic [3:0] {
        S0, // Initial state
        S1, // State after seeing 0
        S2, // State after seeing 00
        S3, // State after seeing 001
        S4, // State after seeing 000
        S5, // State after seeing 0000
        S6, // State after seeing 0001
        S7, // State after seeing 0011
        S8  // State after seeing 0010
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        // Default values
        next_state = current_state;
        sequence_found = 1'b0;

        case (current_state) 
            S0: 
                if (data == 3'b000) next_state = S1;
            S1: 
                if (data == 3'b001) next_state = S2; // Detect '1' after '0'
            S2: 
                if (data == 3'b101) next_state = S3; // Detect '0'
            S3: 
                if (data == 3'b110) next_state = S4; // Detect '1'
            S4: 
                if (data == 3'b000) next_state = S5; // Detect '0'
            S5: 
                if (data == 3'b110) next_state = S6; // Detect '1'
            S6: 
                if (data == 3'b011) next_state = S7; // Detect '0'
            S7: 
                if (data == 3'b101) begin
                    next_state = S0; 
                    sequence_found = 1'b1; // MEALY output
                end
            default: 
                next_state = S0;
        endcase
    end
endmodule
