# ChipChat Report 
Heng Pu  
Netid: hp2723  

## Example 1  Binary_to_BCD
### 1. Initial Prompt  
```
Create a Verilog module named 'binary_to_bcd_converter' that converts a 5-bit binary input to an 8-bit BCD output.
The module should have:
- Input: [4:0] binary_input
- Output: [7:0] bcd_output (where the upper 4 bits represent the tens digit and the lower 4 bits represent the ones digit).
For example, if binary_input is 5'd21, bcd_output should be 8'h21.
Please provide a synthesizable design.
```
### 2. Parameters
```json
{
  "general": {
    "prompt": "prompt.txt",
    "name": "binary_to_bcd_converter",
    "testbench": "testbench.v",
    "outdir": "outputs_bcd",
    "log": "log.txt",
    "model_family": "ChatGPT",
    "model_id": "gpt-4o-mini",
    "iterations": 10,
    "num_candidates": 5
  }
}
```
**Imposrtant Parameters**
* **Model**: gpt-4o-mini
* **Max Iterations**: 10
* **Number of Candidates**: 5
  
### 3. Trajectory 

* **Initial Attempt**: The model tried to use the "Double-Dabble" (shift-and-add-3) algorithm to convert the binary input. However, it made a logic error by shifting the bits before adding 3. 
* **Feedback Issue**: At first, the testbench only reported the total number of errors (e.g., "Mismatches: 15 in 32 samples"). Without knowing the exact wrong outputs, the model could not fix the bug and got stuck in a loop of failures.
* **Testbench Improvement**: We updated the testbench to print the exact input, expected output, and actual output for every error. Even with detailed error logs, the model was still stuck on the wrong algorithm.
* **Prompt Hint & Success**: We added a hint to the prompt: "Since the input is only 5 bits, do NOT use a complex double-dabble algorithm. Use simple arithmetic (division by 10 and modulo 10)." With this hint, the model successfully generated the 100% correct code immediately in Iteration 0.

### 4. Testing and Result
#### Testbench
```verilog
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
                $display("Error: input %d, expected %h, got %h", i, expected_bcd, bcd_output);
                errors = errors + 1;
            end
        end
        $display("Mismatches: %d in 32 samples", errors);
    end
endmodule
```
#### Testing Command
```bash
iverilog -Wall -Winfloop -Wno-timescale -g2012 -s tb -o binary_to_bcd_converter.vvp binary_to_bcd_converter.sv testbench.v
vvp -n binary_to_bcd_converter.vvp
```
#### Output
```
Mismatches: 0 in 32 samples
Testbench ran successfully
```

## Example 2 
### 1. Initial Prompt
```
Create a Verilog model named 'sequence_detector'.
It must meet the following hardware specifications:
- Port Names: input wire clk, input wire reset_n (Active-low), input wire [2:0] data, output reg sequence_found.
- Detection Sequence: Detect the 8-step sequence: 001, 101, 110, 000, 110, 110, 011, 101.
- Critical Timing Requirement: The 'sequence_found' output must be a MEALY-TYPE output. It MUST go high in the SAME clock cycle that the 8th value (101) is received. Do not use a registered output for sequence_found.

HINT: Use a standard Finite State Machine (FSM) approach. Use `always @(posedge clk or negedge reset_n)` for state transitions, and a separate `always @(*)` block for the next-state logic and the Mealy output `sequence_found`. Ensure that partial sequence matches and overlaps are handled properly.
```
### 2. Parameters
```json
{
  "general": {
    "prompt": "prompt.txt",
    "name": "sequence_detector",
    "testbench": "sequence_detector_tb.v",
    "outdir": "outputs_seq",
    "log": "log.txt",
    "model_family": "ChatGPT",
    "model_id": "gpt-4o-mini",
    "iterations": 10,
    "num_candidates": 5
  }
}
```
**Imposrtant Parameters**
**Imposrtant Parameters**
* **Model**: gpt-4o-mini
* **Max Iterations**: 10
* **Number of Candidates**: 5
  
### 3. Trajectory
* **Compilation Errors**: Initially, the model's generated code failed to compile because the testbench module was named tb_sequence_detector, but the AutoChip script strictly required the root module to be named tb. All 5 responses in the early iterations received a rank of -1.

* **Testbench Format Issue**: The original testbench stopped the simulation immediately after the first error using $finish. This prevented AutoChip from reading the final mismatch count.

* **Fixes Applied**: We modified the testbench root module name to tb and added an errors counter to print the total number of errors at the end, matching the AutoChip format requirements.

* **Success**: Because we provided a strong hint in the initial prompt to use a standard Finite State Machine (FSM) with separate combinational and sequential logic blocks, the model generated a 100% correct design with 0 mismatches in Iteration 0 right after the testbench was fixed.

### 4. Testing and Result
#### Testbench
```verilog
`timescale 1ns/1ps

module tb(); 
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

        // Output format required by AutoChip
        $display("Mismatches: %d in 12 samples", errors);
        $finish;
    end
endmodule
```
#### Testing Command
```bash
iverilog -Wall -Winfloop -Wno-timescale -g2012 -s tb -o sequence_detector.vvp sequence_detector.v sequence_detector_tb.v
vvp -n sequence_detector.vvp
```
#### Output
```
Mismatches: 0 in 12 samples
Testbench ran successfully
```

## Part 3  Manual Design
### 1.Example 2 Sequence Dectector Handwritten SV RTL
```sv
module sequence_detector (
    input  logic       clk,
    input  logic       reset_n,
    input  logic [2:0] data,
    output logic       sequence_found
);

    // Define FSM states using SystemVerilog enumerated types
    typedef enum logic [2:0] {
        IDLE,
        S1,
        S2,
        S3,
        S4,
        S5,
        S6,
        S7
    } state_t;

    state_t current_state, next_state;

    // Sequential block for state memory
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational block for next state and Mealy output
    always_comb begin
        // Default assignments to prevent unintended latches
        next_state     = IDLE;
        sequence_found = 1'b0;

        case (current_state)
            IDLE: begin
                if (data == 3'b001) next_state = S1;
            end
            
            S1: begin
                if (data == 3'b101) next_state = S2;
                else if (data == 3'b001) next_state = S1;
            end
            
            S2: begin
                if (data == 3'b110) next_state = S3;
                else if (data == 3'b001) next_state = S1;
            end
            
            S3: begin
                if (data == 3'b000) next_state = S4;
                else if (data == 3'b001) next_state = S1;
            end
            
            S4: begin
                if (data == 3'b110) next_state = S5;
                else if (data == 3'b001) next_state = S1;
            end
            
            S5: begin
                if (data == 3'b110) next_state = S6;
                else if (data == 3'b001) next_state = S1;
            end
            
            S6: begin
                if (data == 3'b011) next_state = S7;
                else if (data == 3'b001) next_state = S1;
            end
            
            S7: begin
                if (data == 3'b101) begin
                    // Mealy output goes high in the same cycle
                    sequence_found = 1'b1; 
                    next_state = IDLE;
                end
                else if (data == 3'b001) next_state = S1;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
```
### 2. Design Choices Expalnation


### 3. Testing and Result
#### Testing Command
```python

```
#### Output

