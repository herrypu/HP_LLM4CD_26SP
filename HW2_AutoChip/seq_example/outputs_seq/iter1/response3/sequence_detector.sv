module sequence_detector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);
    typedef enum logic [3:0] {
        S0, // Initial state
        S1, // 0
        S2, // 1
        S3, // 1
        S4, // 0
        S5, // 1
        S6, // 1
        S7, // 0
        S8  // 1
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
                if (data == 3'b010) next_state = S2; // transition to S1 to see the next '1'
                else if (data == 3'b000) next_state = S1; // stay in S1
            S2: 
                if (data == 3'b101) next_state = S3; // detecting 1
            S3: 
                if (data == 3'b110) next_state = S4; // detecting 1
            S4: 
                if (data == 3'b000) next_state = S5; // back to 0
            S5: 
                if (data == 3'b110) next_state = S6; // detecting 1
            S6: 
                if (data == 3'b011) next_state = S7; // detecting 0
            S7: 
                if (data == 3'b101) begin
                    next_state = S8; 
                    sequence_found = 1'b1; // MEALY output on condition
                end
            S8: begin
                next_state = S8; // Stay in last state
                sequence_found = 1'b1; // Output only during this state
            end
            default: 
                next_state = S0;
        endcase
    end
endmodule
