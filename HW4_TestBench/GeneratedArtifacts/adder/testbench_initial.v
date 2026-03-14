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

    initial begin
        // Test 1: Both inputs are zero
        a = 4'b0000; b = 4'b0000;
        #10 $display("Test 1: a=%b, b=%b", a, b);

        // Test 2: Maximum input a, minimum input b
        a = 4'b1111; b = 4'b0000;
        #10 $display("Test 2: a=%b, b=%b", a, b);

        // Test 3: Minimum input a, maximum input b
        a = 4'b0000; b = 4'b1111;
        #10 $display("Test 3: a=%b, b=%b", a, b);

        // Test 4: Both inputs are maximum
        a = 4'b1111; b = 4'b1111;
        #10 $display("Test 4: a=%b, b=%b", a, b);

        // Test 5: Input a is half of maximum, input b is half of maximum
        a = 4'b1000; b = 4'b1000;
        #10 $display("Test 5: a=%b, b=%b", a, b);

        // Test 6: Input a and b are one less than half
        a = 4'b0111; b = 4'b0111;
        #10 $display("Test 6: a=%b, b=%b", a, b);

        // Test 7: Input a is zero, input b is one
        a = 4'b0000; b = 4'b0001;
        #10 $display("Test 7: a=%b, b=%b", a, b);

        // Test 8: Random values
        a = 4'b1010; b = 4'b0101;
        #10 $display("Test 8: a=%b, b=%b", a, b);

        // Test 9: Random values
        a = 4'b0110; b = 4'b0011;
        #10 $display("Test 9: a=%b, b=%b", a, b);

        // Test 10: Random values
        a = 4'b1110; b = 4'b0001;
        #10 $display("Test 10: a=%b, b=%b", a, b);

        $finish;
    end
endmodule