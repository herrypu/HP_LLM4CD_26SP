module binary_to_bcd_converter (
    input [4:0] binary_input,
    output reg [7:0] bcd_output
);

    integer i;
    reg [8:0] bcd_temp; // Changed to 9 bits to accommodate carry

    always @(binary_input) begin
        bcd_temp = 9'b0;  // Initialize BCD temporary storage
        
        // Binary to BCD conversion algorithm
        for (i = 0; i < 5; i = i + 1) begin
            // Shift left by 1 to make space for the new bit
            bcd_temp = {bcd_temp[7:0], binary_input[4-i]};

            // Adjust BCD digits if needed
            if (bcd_temp[3:0] > 4'd9)
                bcd_temp[3:0] = bcd_temp[3:0] + 4'd6;  // Add 6 for adjustment
            if (bcd_temp[7:4] > 4'd9)
                bcd_temp[7:4] = bcd_temp[7:4] + 4'd6;  // Add 6 for adjustment
        end
        
        bcd_output = bcd_temp[7:0]; // Assign BCD output from the lower 8 bits
    end

endmodule
