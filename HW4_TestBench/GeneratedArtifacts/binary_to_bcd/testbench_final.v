module tb_binary_to_bcd_converter;
    // Declare testbench signals
    reg [4:0] binary_input;
    wire [7:0] bcd_output;

    // Instantiate the module under test
    binary_to_bcd_converter uut (
        .binary_input(binary_input),
        .bcd_output(bcd_output)
    );

    integer test_num;
    integer passed_tests, failed_tests;

    initial begin
        passed_tests = 0;
        failed_tests = 0;

        // Test pattern 1: Minimum boundary value
        test_num = 1;
        binary_input = 5'b00000; // Decimal 0
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd0) begin
            $display("Test %0d: bcd_output = %b, expected = 00000000 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00000000 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 2: Maximum boundary value
        test_num = 2;
        binary_input = 5'b11111; // Decimal 31
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd49) begin
            $display("Test %0d: bcd_output = %b, expected = 00110001 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00110001 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 3: Typical use case
        test_num = 3;
        binary_input = 5'b01010; // Decimal 10
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd16) begin
            $display("Test %0d: bcd_output = %b, expected = 00010000 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00010000 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 4: Edge case - near midpoint
        test_num = 4;
        binary_input = 5'b01111; // Decimal 15
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd21) begin
            $display("Test %0d: bcd_output = %b, expected = 00101001 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00101001 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 5: Random value
        test_num = 5;
        binary_input = 5'b00101; // Decimal 5
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd5) begin
            $display("Test %0d: bcd_output = %b, expected = 00000101 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00000101 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 6: Random value
        test_num = 6;
        binary_input = 5'b10101; // Decimal 21
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd33) begin
            $display("Test %0d: bcd_output = %b, expected = 00100001 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00100001 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 7: Edge case - near zero
        test_num = 7;
        binary_input = 5'b00001; // Decimal 1
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd1) begin
            $display("Test %0d: bcd_output = %b, expected = 00000001 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00000001 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 8: Random value
        test_num = 8;
        binary_input = 5'b10011; // Decimal 19
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd25) begin
            $display("Test %0d: bcd_output = %b, expected = 00011001 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00011001 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 9: Random value
        test_num = 9;
        binary_input = 5'b11010; // Decimal 26
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd38) begin
            $display("Test %0d: bcd_output = %b, expected = 00100110 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00100110 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Test pattern 10: Typical use case - middle value
        test_num = 10;
        binary_input = 5'b10000; // Decimal 16
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);
        #10;
        if (bcd_output == 8'd22) begin
            $display("Test %0d: bcd_output = %b, expected = 00010110 - yes", test_num, bcd_output);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test %0d: bcd_output = %b, expected = 00010110 - no", test_num, bcd_output);
            failed_tests = failed_tests + 1;
        end

        // Display test summary
        $display("Test Summary:");
        $display("Total tests run: %0d", test_num);
        $display("Tests passed: %0d", passed_tests);
        $display("Tests failed: %0d", failed_tests);

        $finish;
    end
endmodule