module binary_to_bcd_converter (
    input [4:0] binary_input,
    output reg [7:0] bcd_output
);

    integer i;
    reg [7:0] bcd_temp;

    always @(binary_input) begin
        bcd_temp = 8'b0;

        // Binary to BCD conversion algorithm
        for (i = 4; i >= 0; i = i - 1) begin
            // Shift left by 1 to make space for the new bit
            bcd_temp = {bcd_temp[6:0], binary_input[i]};

            // Adjust BCD digits if needed
            if (bcd_temp[3:0] > 4'd9) 
                bcd_temp[3:0] = bcd_temp[3:0] + 4'd6;
            if (bcd_temp[7:4] > 4'd9)
                bcd_temp[7:4] = bcd_temp[7:4] + 4'd6;
        end

        bcd_output = bcd_temp; // Correct assignment to output after shifting
    end

endmodule
