module sequence_detector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);

    typedef enum reg [3:0] { 
        S0, S1, S2, S3, S4, S5, S6, S7, S8 
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        // Default assignments
        next_state = current_state;
        sequence_found = 1'b0;

        case (current_state)
            S0: if (data == 3'b001) next_state = S1;
            S1: if (data == 3'b101) next_state = S2;
            S2: if (data == 3'b110) next_state = S3;
            S3: if (data == 3'b000) next_state = S4;
            S4: if (data == 3'b110) next_state = S5;
            S5: if (data == 3'b110) next_state = S6;
            S6: if (data == 3'b011) next_state = S7;
            S7: if (data == 3'b101) begin
                    next_state = S8;
                    sequence_found = 1'b1; // Mealy output
                end
            S8: begin
                    next_state = S0; // Return to start for the next detection
                    sequence_found = 1'b0;
                end
            default: next_state = S0; // Safety default transition
        endcase
    end

endmodule
