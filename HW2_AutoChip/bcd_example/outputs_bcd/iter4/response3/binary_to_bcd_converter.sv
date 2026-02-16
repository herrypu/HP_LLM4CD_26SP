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
            if (bcd_temp[3:0] > 4'h9)
                bcd_temp[3:0] = bcd_temp[3:0] + 4'h3;
            if (bcd_temp[7:4] > 4'h9)
                bcd_temp[7:4] = bcd_temp[7:4] + 4'h3;
        end
        
        bcd_output = bcd_temp;
    end

endmodule
