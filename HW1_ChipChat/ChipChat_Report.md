# ChipChat Report 
Heng Pu  
Netid: hp2723

## 1. Choice of Examples and Extension
Example A: Example 1 - binary_to_bcd  
Example B:  Example 2 - sequence_detector  
Extension:

## 2. Model Used and Generation Parameters
model name: deepseek-reasoner  
max_tockens: 2048  
temperature: 0.7  

## 3. Example A Report
### a. Final Prompt
```
 I am trying to create a Verilog model named "binary_to_bcd_converter". 
It must meet the following strict specifications:
    - Port Names and Widths:
        - Input: "binary_input" (5-bits)
        - Output: "bcd_output" (8-bits: 4-bits for the 10's place and 4-bits for the 1's place)
    - Functional requirements:
        - The module should convert the 5-bit binary input to its equivalent BCD representation.
        - For example, if binary_input is 5'd21, bcd_output should be 8'h21.

Please write a synthesizable Verilog design that uses these exact port names.
```
### b. Final Module Interface
```verilog
input [4:0] binary_input,
output reg [7:0] bcd_output
```
### c. Design Approach
The LLM provided two distinct synthesizable RTL implementations for this combinational converter. The first approach utilizes a Lookup Table (Case Statement) covering all 32 possible input values (0–31), ensuring highly deterministic timing and clear mapping to BCD values. The second approach uses Combinational Arithmetic Logic, where the tens digit is calculated through a series of conditional comparisons (checks for values ≥ 10, 20, or 30) and the ones digit is derived using modulo 10 arithmetic. The final 8-bit output is formed by concatenating the 4-bit tens and ones registers. Both designs were verified as synthesizable and functionally identical within the 5-bit range.

### d. Verification Results

Command:
```
!cd binary_to_bcd/ && iverilog -g2012 -o binary_to_bcd.vvp binary_to_bcd.v binary_to_bcd_tb.v && vvp binary_to_bcd.vvp
```
Outcome:
```
All test cases passed!
```

## 4. Example B Report 
### a. Final Prompt
```
I am trying to create a Verilog model named "sequence_detector".
It must meet the following hardware specifications to pass the testbench:

    - Port Names (Strict):
        - Clock: "clk"
        - Reset: "reset_n" (Active-low reset)
        - Input Data: "data" (3 bits)
        - Output: "sequence_found" (1 bit)

    - Detection Sequence:
        Detect the 8-step sequence: 001, 101, 110, 000, 110, 110, 011, 101.

    - Critical Timing Requirement:
        The "sequence_found" output must be a MEALY-TYPE output (combinational logic). 
        It MUST go high in the SAME clock cycle that the 8th value (0b101) is received. 
        Do not use a registered output for sequence_found as it introduces a one-cycle delay.

    - Standard: Use synthesizable Verilog (always @(*) and always @(posedge clk)).
```
### b. Final Module Interface
```verilog
    input wire clk,
    input wire reset_n,      // Active-low reset
    input wire [2:0] data,   // 3-bit input data
    output reg sequence_found  // Mealy output
```
### c. Design Approach
The design implements a Mealy-type Finite State Machine (FSM) to detect a specific 8-step binary sequence through 3-bit input data. To meet the critical timing requirement of asserting the output in the same cycle as the final input, the architecture uses one-hot encoding for its states (comprising S_IDLE and S_STEP1 through S_STEP7). The logic is divided into two primary blocks: a sequential always block for stable state transitions and a combinational always @(*) block for next-state determination and immediate output generation. By assigning the sequence_found signal in the combinational block based on the current state (S_STEP7) and the immediate value of the input data (3'b101), the design eliminates the one-cycle registration delay characteristic of Moore-type outputs. Additionally, the state machine is robust, featuring a synchronous restart to S_STEP1 whenever the first value of the sequence (001) is re-encountered during detection.
### d. Verification Results
Command:
```
!cd sequence_detector/ && iverilog -g2012 -o sequence_detector.vvp sequence_detector.v sequence_detector_tb.v && vvp sequence_detector.vvp
```
Outcome:
```
All test cases passed!
```
### f. Iteration Table
#### Iteration #1
##### (1) What Failed
The LLM response was prematurely cut off probably due to the max_tokens limit (2048), resulting in incomplete Verilog syntax. 
##### (2) What I changed to fix
I increased the max_tokens parameter to 4096 to ensure full code generation. 
##### (3) Why I Expect it to help
A higher token limit allows the model to complete the entire module structure. 

#### Iteration #2
##### (1) What Failed
The iverilog compiler reported that reset_n and sequence_found are not ports of the design under test (dut). This is because the LLM generated a module using rst_n and seq_found as port names, while the provided testbench expects the full names reset_n and sequence_found.
##### (2) What I changed to fix
I refined the verilog_generation_prompt to explicitly specify the required port names and widths, ensuring strict adherence to the testbench interface.
##### (3) Why I Expect it to help
Providing a precise hardware specification (Spec) in the prompt forces the LLM to align its output with the existing verification environment, eliminating manual port renaming.

#### Iteration #3
##### (1) What Failed
Functional Mismatch (Cycle 8 Delay). The simulation failed with Error: Cycle 8, Expected: 1, Got: 0. This occurred because the LLM generated a Moore-type FSM with a registered output, causing the sequence_found signal to appear one cycle later than the testbench expected.
##### (2) What I changed to fix
I updated the prompt to explicitly request a Mealy-type output, requiring the sequence_found signal to be driven by combinational logic so it asserts in the same cycle as the final sequence input.
##### (3) Why I Expect it to help
By removing the output register, the timing of the "found" signal aligns perfectly with the testbench's sampling window at the 8th clock cycle.

## 5. Extension 
(Parameterizing Example 2: Sequence Detector)
### a. Final Prompt
```
I want to extend the sequence_detector design to be fully parameterized.
The new module should be named "sequence_detector_ext".

Specifications:
1. Parameters:
   - DATA_WIDTH: Default is 3 (width of input data).
   - SEQ_LEN: Default is 8 (number of steps in the sequence).
   - TARGET_SEQ: A parameter that holds the entire concatenated sequence.
     Default should be the concatenation of: 0b001, 101, 110, 000, 110, 110, 011, 101.

2. Logic Requirements:
   - Port Names: clk, reset_n, data [DATA_WIDTH-1:0], sequence_found.
   - Design Style: Use a shift-register window approach OR a generic FSM that references TARGET_SEQ.
   - Timing: Must be a Mealy-type output (combinational) that asserts "sequence_found"
     in the SAME cycle the last element of the sequence is matched.

3. Synthesizability:
   - Must use synthesizable Verilog (always @(posedge clk) and always @(*)).
```
### b. Final Module Interface
Parameters:

    DATA_WIDTH: Width of each input element (Default: 3).

    SEQ_LEN: Total length of the target sequence (Default: 8).

    TARGET_SEQ: Concatenated target sequence bits.

Ports:

    clk, reset_n (Active-low reset), data [DATA_WIDTH-1:0] (Inputs).

    sequence_found (Output).
### c. Design Approach
The design utilizes a Parameterized Finite State Machine (FSM) approach to ensure flexibility. A generate block is employed to slice the TARGET_SEQ parameter into a 1D array of sequence elements (seq_elements), allowing the FSM logic to dynamically reference specific segments based on the current state. The state transition logic uses a binary counter for state representation, comparing the incoming data with the corresponding seq_elements[state]. Crucially, the design implements Mealy-type logic for the sequence_found signal, which is asserted combinationally in the same clock cycle as the final sequence match to eliminate output delay.
### d. Test Bench
The verification environment (tb_code_v3_fixed) instantiates three separate instances of the sequence_detector_ext with varying parameters to validate scalability:

    dut_1: Default configuration (3-bit data, length 8).

    dut_2: Custom configuration (4-bit hex data, length 5).

    dut_3: Short sequence (2-bit data, length 3). The testbench uses modular tasks (send_sequence_1/2/3) to drive stimulus and checks for the immediate assertion of sequence_found after each sequence completion.
### e. Verification Results
The simulation was performed using iverilog -g2012. The log confirms that the single RTL source code successfully adapted to all three unique hardware configurations:
Plaintext
```
Test 1: Default Pattern
  PASS
Test 2: 4-bit Hex
  PASS
Test 3: Short Seq
  PASS
```
### f. Explanation and Impact
Transitioning from a hard-coded FSM to a parameterized architecture significantly enhances design reusability. By using generate blocks and parameter slicing, the same module can now be deployed for vastly different detection tasks without modifying the underlying RTL. This abstraction demonstrates a professional hardware design flow where "specification change" is handled via top-level parameter overrides rather than manual logic redesign, greatly reducing the potential for human error during iterations.