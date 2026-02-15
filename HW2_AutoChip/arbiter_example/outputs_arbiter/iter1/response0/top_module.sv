module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	state_t state, next_state;

	// Output logic
	always @(*) begin
		g = 3'b000; // Default grant signals to 0
		case (state)
			B: g[1] = 1'b1; // Grant for device 1
			C: g[2] = 1'b1; // Grant for device 2
			D: g[3] = 1'b1; // Grant for device 3
			default: g = 3'b000;
		endcase
	end

	// State transition logic
	always @(*) begin
		case (state)
			A: begin
				if (r[1]) next_state = B; // grant to device 1
				else if (r[2]) next_state = C; // grant to device 2
				else if (r[3]) next_state = D; // grant to device 3
				else next_state = A; // stay in A
			end
			B: begin
				if (r[1]) next_state = B; // stay in B if device 1 is requesting
				else next_state = A; // go back to A if device 1 is not requesting
			end
			C: begin
				if (r[2]) next_state = C; // stay in C if device 2 is requesting
				else next_state = A; // go back to A if device 2 is not requesting
			end
			D: begin
				if (r[3]) next_state = D; // stay in D if device 3 is requesting
				else next_state = A; // go back to A if device 3 is not requesting
			end
			default: next_state = A; // Default state
		endcase
	end

	// State flip-flop
	always @(posedge clk) begin
		if (!resetn) 
			state <= A; // Reset to state A
		else 
			state <= next_state; // Update state
	end

endmodule
