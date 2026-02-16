module binary_to_bcd_converter (
    input [4:0] binary_input,
    output reg [7:0] bcd_output
);

    always @(*) begin
        integer tens, ones;
        tens = binary_input / 10;
        ones = binary_input % 10;
        bcd_output = {tens[3:0], ones[3:0]}; // Concatenate tens and ones
    end

endmodule
