module tb_priority_encoder;
    // Declare signals
    reg [3:0] d;
    wire [1:0] q;
    wire valid;

    // Instantiate the module under test
    priority_encoder uut (
        .d(d),
        .q(q),
        .valid(valid)
    );

    initial begin
        // Test case 1
        d = 4'b0000;
        #10 $display("Test 1: d = %b", d);

        // Test case 2
        d = 4'b0001;
        #10 $display("Test 2: d = %b", d);

        // Test case 3
        d = 4'b0010;
        #10 $display("Test 3: d = %b", d);

        // Test case 4
        d = 4'b0011;
        #10 $display("Test 4: d = %b", d);

        // Test case 5
        d = 4'b0100;
        #10 $display("Test 5: d = %b", d);

        // Test case 6
        d = 4'b0101;
        #10 $display("Test 6: d = %b", d);

        // Test case 7
        d = 4'b0110;
        #10 $display("Test 7: d = %b", d);

        // Test case 8
        d = 4'b0111;
        #10 $display("Test 8: d = %b", d);

        // Test case 9
        d = 4'b1000;
        #10 $display("Test 9: d = %b", d);

        // Test case 10
        d = 4'b1001;
        #10 $display("Test 10: d = %b", d);

        // Test case 11
        d = 4'b1010;
        #10 $display("Test 11: d = %b", d);

        // Test case 12
        d = 4'b1011;
        #10 $display("Test 12: d = %b", d);

        // Test case 13
        d = 4'b1100;
        #10 $display("Test 13: d = %b", d);

        // Test case 14
        d = 4'b1101;
        #10 $display("Test 14: d = %b", d);

        // Test case 15
        d = 4'b1110;
        #10 $display("Test 15: d = %b", d);

        // Test case 16
        d = 4'b1111;
        #10 $display("Test 16: d = %b", d);

        // Randomized test cases
        // Test case 17
        d = 4'b1011;
        #10 $display("Test 17: d = %b", d);

        // Test case 18
        d = 4'b0110;
        #10 $display("Test 18: d = %b", d);

        // Test case 19
        d = 4'b1001;
        #10 $display("Test 19: d = %b", d);

        // Test case 20
        d = 4'b1101;
        #10 $display("Test 20: d = %b", d);

        // Test case 21
        d = 4'b0011;
        #10 $display("Test 21: d = %b", d);

        // Test case 22
        d = 4'b0101;
        #10 $display("Test 22: d = %b", d);

        // Test case 23
        d = 4'b0111;
        #10 $display("Test 23: d = %b", d);

        // Test case 24
        d = 4'b1110;
        #10 $display("Test 24: d = %b", d);

        // Test case 25
        d = 4'b1100;
        #10 $display("Test 25: d = %b", d);

        $finish;
    end
endmodule