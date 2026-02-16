module binary_to_bcd_converter(
    input [4:0] binary_input,
    output reg [7:0] bcd_output
);

    always @(*) begin
        integer decimal_value;
        decimal_value = binary_input; // Convert to decimal
        
        // Calculate BCD digits
        bcd_output[3:0] = decimal_value % 10;           // Ones digit
        bcd_output[7:4] = decimal_value / 10;           // Tens digit
    end

endmodule
