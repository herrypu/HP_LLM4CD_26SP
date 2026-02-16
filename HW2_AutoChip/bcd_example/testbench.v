module tb;
    reg [4:0] binary_input;
    wire [7:0] bcd_output;
    integer i, errors;
    reg [3:0] temp_tens;
    reg [3:0] temp_ones;
    reg [7:0] expected_bcd;

    binary_to_bcd_converter uut (
        .binary_input(binary_input),
        .bcd_output(bcd_output)
    );

    initial begin
        errors = 0;
        for (i = 0; i < 32; i = i + 1) begin
            binary_input = i;
            #10;
            temp_tens = i / 10;
            temp_ones = i % 10;
            expected_bcd = {temp_tens, temp_ones};
            
            if (bcd_output !== expected_bcd) begin
                // 这行极其重要：让 LLM 看到它到底算错了什么
                $display("Error: input %d, expected %h, got %h", i, expected_bcd, bcd_output);
                errors = errors + 1;
            end
        end
        $display("Mismatches: %d in 32 samples", errors);
    end
endmodule