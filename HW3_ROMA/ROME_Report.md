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

