module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011
    } state_t;

    state_t current_state, next_state;

    // State Flip-Flop
    always @(posedge clk or negedge resetn) begin
        if (!resetn) 
            current_state <= A;
        else 
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            A: begin
                if (r[1]) next_state = B;
                else if (r[2]) next_state = C;
                else if (r[3]) next_state = D;
                else next_state = A;
            end
            B: begin
                if (r[1]) next_state = B; // Stay in state B if request from device 1
                else next_state = A; // Go back to state A if device 1 doesn't request
            end
            C: begin
                if (r[2]) next_state = C; // Stay in state C if request from device 2
                else next_state = A; // Go back to state A if device 2 doesn't request
            end
            D: begin
                next_state = A; // Go back to state A from D
            end
            default: next_state = A; // Default case to reset to state A
        endcase
    end

    // Output Logic
    always @(*) begin
        g = 3'b000; // Default all grants to 0
        case (current_state)
            B: g[1] = 1; // Grant to device 1
            C: g[2] = 1; // Grant to device 2
            D: g[3] = 1; // Grant to device 3
            default: g = 3'b000; // Default case
        endcase
    end

endmodule
