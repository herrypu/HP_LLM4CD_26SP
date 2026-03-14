`timescale 1ns / 1ps

module tb_adder4bit;
    // Declare input and output signals
    reg [3:0] a;
    reg [3:0] b;
    wire [3:0] sum;
    wire carry;

    // Instantiate the adder module
    adder4bit uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    integer passed_tests = 0;
    integer failed_tests = 0;

    initial begin
        // Test 1: Both inputs are zero
        a = 4'b0000; b = 4'b0000;
        #10 $display("Test 1: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b0000 && carry === 1'b0) begin
            $display("Test 1 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b0000, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 1 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b0000, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test 2: Maximum input a, minimum input b
        a = 4'b1111; b = 4'b0000;
        #10 $display("Test 2: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("Test 2 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 2 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test 3: Minimum input a, maximum input b
        a = 4'b0000; b = 4'b1111;
        #10 $display("Test 3: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("Test 3 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 3 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test 4: Both inputs are maximum
        a = 4'b1111; b = 4'b1111;
        #10 $display("Test 4: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b1110 && carry === 1'b1) begin
            $display("Test 4 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1110, carry, 1'b1);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 4 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1110, carry, 1'b1);
            failed_tests = failed_tests + 1;
        end

        // Test 5: Input a is half of maximum, input b is half of maximum
        a = 4'b1000; b = 4'b1000;
        #10 $display("Test 5: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b0000 && carry === 1'b1) begin
            $display("Test 5 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b0000, carry, 1'b1);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 5 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b0000, carry, 1'b1);
            failed_tests = failed_tests + 1;
        end

        // Test 6: Input a and b are one less than half
        a = 4'b0111; b = 4'b0111;
        #10 $display("Test 6: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b1110 && carry === 1'b0) begin
            $display("Test 6 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1110, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 6 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1110, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test 7: Input a is zero, input b is one
        a = 4'b0000; b = 4'b0001;
        #10 $display("Test 7: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b0001 && carry === 1'b0) begin
            $display("Test 7 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b0001, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 7 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b0001, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test 8: Random values
        a = 4'b1010; b = 4'b0101;
        #10 $display("Test 8: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("Test 8 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 8 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test 9: Random values
        a = 4'b0110; b = 4'b0011;
        #10 $display("Test 9: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b1001 && carry === 1'b0) begin
            $display("Test 9 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1001, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 9 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1001, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test 10: Random values
        a = 4'b1110; b = 4'b0001;
        #10 $display("Test 10: a=%b, b=%b", a, b);
        #10;
        if (sum === 4'b1111 && carry === 1'b0) begin
            $display("Test 10 Passed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Test 10 Failed: Sum = %b (Expected: %b), Carry = %b (Expected: %b)", sum, 4'b1111, carry, 1'b0);
            failed_tests = failed_tests + 1;
        end

        // Test Summary
        $display("Test Summary: Total Tests = %d, Passed = %d, Failed = %d", passed_tests + failed_tests, passed_tests, failed_tests);

        $finish;
    end
endmodule