module binary_to_bcd_converter (
    input [4:0] binary_input,
    output reg [7:0] bcd_output
);

    always @(*) begin
        integer temp;
        integer tens, ones;
        
        // Cast binary_input to integer for arithmetic operations
        temp = binary_input;

        // Calculate tens and ones using simple division and modulo operations
        tens = temp / 10;  // Get the tens digit
        ones = temp % 10;  // Get the ones digit

        // Assign the BCD output: upper 4 bits for tens, lower 4 bits for ones
        bcd_output = {tens[3:0], ones[3:0]};
    end

endmodule
