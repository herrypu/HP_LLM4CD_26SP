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

    integer passed_tests = 0;
    integer failed_tests = 0;

    initial begin
        // Test case 1: sel=0, a=0, b=0
        a = 0; b = 0; sel = 0;
        #10;
        $display("Test 1: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 0) begin
            $display("Check y: yes (expected 0, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 0, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 2: sel=0, a=0, b=1
        a = 0; b = 1; sel = 0;
        #10;
        $display("Test 2: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 0) begin
            $display("Check y: yes (expected 0, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 0, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 3: sel=0, a=1, b=0
        a = 1; b = 0; sel = 0;
        #10;
        $display("Test 3: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 1) begin
            $display("Check y: yes (expected 1, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 1, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 4: sel=0, a=1, b=1
        a = 1; b = 1; sel = 0;
        #10;
        $display("Test 4: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 1) begin
            $display("Check y: yes (expected 1, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 1, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 5: sel=1, a=0, b=0
        a = 0; b = 0; sel = 1;
        #10;
        $display("Test 5: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 0) begin
            $display("Check y: yes (expected 0, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 0, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 6: sel=1, a=0, b=1
        a = 0; b = 1; sel = 1;
        #10;
        $display("Test 6: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 1) begin
            $display("Check y: yes (expected 1, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 1, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 7: sel=1, a=1, b=0
        a = 1; b = 0; sel = 1;
        #10;
        $display("Test 7: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 0) begin
            $display("Check y: yes (expected 0, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 0, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test case 8: sel=1, a=1, b=1
        a = 1; b = 1; sel = 1;
        #10;
        $display("Test 8: a=%b, b=%b, sel=%b, y=%b", a, b, sel, y);
        #10;
        if (y === 1) begin
            $display("Check y: yes (expected 1, got %b)", y);
            passed_tests = passed_tests + 1;
        end else begin
            $display("Check y: no (expected 1, got %b)", y);
            failed_tests = failed_tests + 1;
        end

        // Test summary
        $display("Test Summary: Total tests = %d, Passed = %d, Failed = %d", passed_tests + failed_tests, passed_tests, failed_tests);

        // Finish simulation
        $finish;
    end

endmodule