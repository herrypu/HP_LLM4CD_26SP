`timescale 1ns / 1ps

module mux2to1_tb;

    // Declare testbench signals
    reg a;
    reg b;
    reg sel;
    wire y;

    // Instantiate the module under test
    mux2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        // Test case 1: sel=0, a=0, b=0
        a = 0; b = 0; sel = 0;
        #10;
        $display("Test 1: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Test case 2: sel=0, a=0, b=1
        a = 0; b = 1; sel = 0;
        #10;
        $display("Test 2: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Test case 3: sel=0, a=1, b=0
        a = 1; b = 0; sel = 0;
        #10;
        $display("Test 3: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Test case 4: sel=0, a=1, b=1
        a = 1; b = 1; sel = 0;
        #10;
        $display("Test 4: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Test case 5: sel=1, a=0, b=0
        a = 0; b = 0; sel = 1;
        #10;
        $display("Test 5: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Test case 6: sel=1, a=0, b=1
        a = 0; b = 1; sel = 1;
        #10;
        $display("Test 6: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Test case 7: sel=1, a=1, b=0
        a = 1; b = 0; sel = 1;
        #10;
        $display("Test 7: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Test case 8: sel=1, a=1, b=1
        a = 1; b = 1; sel = 1;
        #10;
        $display("Test 8: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);

        // Finish simulation
        $finish;
    end

endmodule