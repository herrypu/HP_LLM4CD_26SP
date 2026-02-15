module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State flip-flops
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A; // Reset to state A
        else
            current_state <= next_state;
    end

    // State table
    always_comb begin
        case (current_state)
            A: begin
                if (r[1]) next_state = B; // Device 1 requests
                else if (r[2]) next_state = C; // Device 2 requests
                else if (r[3]) next_state = D; // Device 3 requests
                else next_state = A; // Stay in state A
            end

            B: begin
                if (r[1]) next_state = B; // Device 1 still has grant
                else next_state = A; // Device 1 stops requesting
            end

            C: begin
                if (r[2]) next_state = C; // Device 2 still has grant
                else next_state = A; // Device 2 stops requesting
            end

            default: next_state = A; // Default to state A
        endcase
    end

    // FSM outputs
    always_comb begin
        g = 3'b000; // Default all grants to 0
        case (current_state)
            B: g[1] = 1; // Grant for device 1
            C: g[2] = 1; // Grant for device 2
            default: g[3] = 0; // Device 3 has lower priority, do not grant unless in specific conditions
        endcase
    end

endmodule
