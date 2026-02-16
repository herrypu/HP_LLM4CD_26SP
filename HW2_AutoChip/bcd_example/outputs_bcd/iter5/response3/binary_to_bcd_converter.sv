module binary_to_bcd_converter (
    input [4:0] binary_input,
    output reg [7:0] bcd_output
);

    integer i;
    reg [7:0] bcd_temp; 

    always @(binary_input) begin
        bcd_temp = 8'b0;
        
        // Binary to BCD conversion algorithm
        for (i = 0; i < 5; i = i + 1) begin
            // Shift left by 1 to make space for the new bit
            bcd_temp = {bcd_temp[6:0], binary_input[4-i]};

            // Adjust BCD digits if needed
            if (bcd_temp[3:0] >= 5) 
                bcd_temp[3:0] = bcd_temp[3:0] + 3;
            if (bcd_temp[7:4] >= 5) 
                bcd_temp[7:4] = bcd_temp[7:4] + 3;
        end
        
        bcd_output = bcd_temp;
    end

    // Ensure the BCD output is valid for inputs 0 to 31
    always @(binary_input) begin
        if (binary_input > 25) begin
            bcd_output = 8'hFF; // Invalid input case
        end
    end

endmodule
