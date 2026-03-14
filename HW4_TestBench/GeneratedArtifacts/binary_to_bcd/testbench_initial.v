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

    initial begin
        // Test pattern 1: Minimum boundary value
        test_num = 1;
        binary_input = 5'b00000; // Decimal 0
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 2: Maximum boundary value
        test_num = 2;
        binary_input = 5'b11111; // Decimal 31
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 3: Typical use case
        test_num = 3;
        binary_input = 5'b01010; // Decimal 10
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 4: Edge case - near midpoint
        test_num = 4;
        binary_input = 5'b01111; // Decimal 15
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 5: Random value
        test_num = 5;
        binary_input = 5'b00101; // Decimal 5
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 6: Random value
        test_num = 6;
        binary_input = 5'b10101; // Decimal 21
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 7: Edge case - near zero
        test_num = 7;
        binary_input = 5'b00001; // Decimal 1
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 8: Random value
        test_num = 8;
        binary_input = 5'b10011; // Decimal 19
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 9: Random value
        test_num = 9;
        binary_input = 5'b11010; // Decimal 26
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        // Test pattern 10: Typical use case - middle value
        test_num = 10;
        binary_input = 5'b10000; // Decimal 16
        #10;
        $display("Test %0d: binary_input = %b", test_num, binary_input);

        $finish;
    end
endmodule