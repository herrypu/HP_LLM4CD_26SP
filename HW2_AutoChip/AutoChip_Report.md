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

## Example 2 Arbiter Circuit
### 1. Initial Prompt
```sv

```
### 2. Parameters
```json

```
**Imposrtant Parameters**
* Model name: gpt-4o-mini  
* Max iterations: 10
* Num of candidates: 5  
  
### 3. Trajectory

### 4. Testing and Result
#### Testbench
```
```
#### Testing Command
```python

```
#### Output

## Part 3  Manual Design
### 
```sv

```
### Design Choices Expalnation


### Testing and Result
#### Testing Command
```python

```
#### Output

