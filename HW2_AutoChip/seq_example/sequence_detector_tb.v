`timescale 1ns/1ps

module tb(); // <-- 这里改成了 tb，必须和 AutoChip 底层硬编码匹配
    reg clk;
    reg reset_n;
    reg [2:0] data;
    wire sequence_found;
    
    integer errors; 

    // Instantiate the sequence_detector module
    sequence_detector dut (
        .clk(clk),
        .reset_n(reset_n),
        .data(data),
        .sequence_found(sequence_found)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test stimulus task
    task apply_stimulus;
        input [2:0] data_value;
        input integer delay_cycles;
        begin
            data <= data_value;
            repeat (delay_cycles) @(posedge clk);
        end
    endtask

    // Check output task
    task check_output;
        input integer cycle;
        input expected_value;
        begin
            if (sequence_found !== expected_value) begin
                $display("Error: Cycle %0d, Expected: %b, Got: %b", cycle, expected_value, sequence_found);
                errors = errors + 1; 
            end
        end
    endtask

    // Testbench stimulus and checking
    initial begin
        // Initialize signals
        errors = 0;
        clk <= 0;
        reset_n <= 0;
        data <= 3'b000;

        // Apply reset
        @(posedge clk);
        reset_n <= 1;

        // Test case: Correct sequence
        apply_stimulus(3'b001, 1); check_output(1, 1'b0);
        apply_stimulus(3'b101, 1); check_output(2, 1'b0);
        apply_stimulus(3'b110, 1); check_output(3, 1'b0);
        apply_stimulus(3'b000, 1); check_output(4, 1'b0);
        apply_stimulus(3'b110, 1); check_output(5, 1'b0);
        apply_stimulus(3'b110, 1); check_output(6, 1'b0);
        apply_stimulus(3'b011, 1); check_output(7, 1'b0);
        apply_stimulus(3'b101, 1); check_output(8, 1'b1);

        // Test case: Incorrect sequence
        apply_stimulus(3'b001, 1); check_output(9, 1'b0);
        apply_stimulus(3'b101, 1); check_output(10, 1'b0);
        apply_stimulus(3'b010, 1); check_output(11, 1'b0);
        apply_stimulus(3'b000, 1); check_output(12, 1'b0);

        // 输出 AutoChip 需要的匹配结果格式
        $display("Mismatches: %d in 12 samples", errors);
        $finish;
    end
endmodule