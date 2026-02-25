# LLM4ChipDesign HW3 ROME

## Part I - Run the provided mux hierarchy demo

### 1. Model Configuration
The model used for this assignment was GPT-5. The system was configured as an autocomplete engine for Verilog code. Key settings included a temperature of 0.6 and a maximum output limit to ensure the generation focused strictly on Verilog RTL code without unnecessary explanations.

### 2. Hierarchical Decomposition
The design follows a bottom-up hierarchical approach to build an 8-to-1 multiplexer. The module list and their relationships are as follows:

* mux2to1: This is the base submodule. It takes two single-bit inputs and one select bit to produce a single output.
* mux4to1: This module instantiates the previously generated mux2to1 modules to select one of four inputs.
* mux8to1: This is the top-level module. It instantiates the mux4to1 and mux2to1 modules to select one output from eight input bits using a 3-bit select signal.

### 3. Final Prompts

Representative Submodule (mux2to1) Prompt:
//We will be generating a 8-to-1 multiplexer hierarchically in Verilog. Please begin by generating a mux2to1 defined as follows:
module mux2to1(input wire in1, input wire in2, input wire select, output wire out)
//Insert code here
endmodule

Top Module (mux8to1) Prompt:
//We are generating a 8-to-1 multiplexer hierarchically in Verilog. We have generated mux2to1, mux4to1, defined as follows: [RTL Code of previous modules]
//Please include the previous module(s) in your response and use them to hierarchically generate a mux8to1 defined as:
module mux8to1(input [2:0] sel, input [7:0] in, output reg out)
//Insert code here
endmodule

### 4. Verification Results and Commands
All modules successfully passed their respective testbenches. The feedback loop correctly identified initial compilation errors in the more complex modules and provided the necessary fixes.

* mux2to1: Passed in 1 iteration.
* mux4to1: Passed in 2 iterations (corrected after 1 error).
* mux8to1: Passed in 2 iterations (corrected after 1 error).

The final iverilog and vvp commands used for verification were:
iverilog -o [module_name] [module_name].v [module_name]tb.v
vvp [module_name]

All testbenches printed the required passed! message upon successful completion.

## Part II - Extend to a new hierarchical RTL design 
Option A: Ripple-carry adder hierarchy (recommended). Example decomposition: half_adder ->
full_adder -> adder4 -> adder8.

ROME Part II: Ripple-Carry Adder Hierarchy Report

### 1. Model Configuration
The model selected for this hierarchical design was GPT-5. The system functioned as an autocomplete engine for Verilog code. It used a feedback loop to refine the code based on the error messages from the iverilog compiler and the results from the vvp simulator. All settings were configured to prioritize the generation of synthesizable RTL code.
### 2. Hierarchical Decomposition
The project implemented an 8-bit Ripple-Carry Adder through a step-by-step decomposition process. The hierarchy consists of the following modules:

* half_adder: The most basic unit, adding two single bits to produce a sum and a carry.
* full_adder: Built by instantiating the half_adder to handle three input bits, including a carry-in.
* adder4: A 4-bit adder created by connecting four full_adder modules in a chain.
* adder8: The top-level module, which instantiates the 4-bit adders to perform 8-bit addition.

### 3. Final Prompts

Representative Submodule (half_adder) Prompt:
//We will be generating a 8-bit ripple-carry adder hierarchically in Verilog. Please begin by generating a half_adder defined as follows:
module half_adder(input wire a, input wire b, output wire sum, output wire carry)
//Insert code here
endmodule

Top Module (adder8) Prompt:
//We are generating a 8-bit ripple-carry adder hierarchically in Verilog. We have generated half_adder, full_adder, adder4, defined as follows: [Previous RTL Code Provided]
//Please include the previous module(s) in your response and use them to hierarchically generate a adder8 defined as:
module adder8(input [7:0] a, input [7:0] b, input cin, output [7:0] sum, output cout)
//Insert code here
endmodule

### 4. Debugging and Iteration Results
The design process used iterative refinement to fix errors. The following table shows the debugging steps for each module:

| Module | Iteration | Issue Observed | Fix Applied | Outcome |
| --- | --- | --- | --- | --- |
| half_adder | 0 | None | N/A | Passed |
| full_adder | 0 | Compile Error | Fixed port connection syntax | Passed |
| adder4 | 0 | Compile Error | Corrected submodule instantiation | Passed |
| adder8 | 0 | Compile Error | Refined carry-out logic connection | Passed |

# 5. Verification Confirmation
All modules passed their self-checking testbenches. The final outputs confirmed that each design reached the required "Testbench ran successfully" status and printed the "passed!" message.

Final verification commands:
iverilog -o [module_name] [module_name].v [module_name]tb.v
vvp [module_name]
