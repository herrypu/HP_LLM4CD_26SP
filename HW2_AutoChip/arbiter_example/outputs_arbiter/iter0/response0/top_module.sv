module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (r[1]) next_state = B;
                else if (r[2]) next_state = C;
                else if (r[3]) next_state = D;
                else next_state = A;
            end
            B: begin
                if (r[1]) next_state = B; // g1=1, stay in B
                else next_state = A; // r1=0, go back to A
            end
            C: begin
                if (r[2]) next_state = C; // g2=1, stay in C
                else next_state = A; // r2=0, go back to A
            end
            D: begin
                next_state = A; // Just an example; modify if needed
            end
            default: next_state = A; // Default case for safety
        endcase
    end

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A; // Reset to state A
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default output
        case (current_state)
            B: g[1] = 1'b1; // Grant to device 1
            C: g[2] = 1'b1; // Grant to device 2
            D: g[3] = 1'b1; // Grant to device 3
            default: g = 3'b000; // No grant
        endcase
    end
endmodule
