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

## Part II: Hierarchical RTL Design Extension

### 1. Model and Generation Settings
For the extension design, the **ChatGPT (gpt-3.5-turbo)** model was selected. The generation followed the hierarchical ROME workflow , using the model as an autocomplete engine to produce synthesizable Verilog modules. The generation settings utilized a temperature of **0.6** and a maximum of **10 iterations** per module to allow the feedback loop to correct any compilation or logic errors.

### 2. Hierarchical Decomposition
I implemented **Option A: Ripple-carry adder hierarchy**[cite: 1]. The design follows a modular decomposition where smaller components are instantiated to build more complex logic:

* **half_adder**: The foundation module, handling 1-bit addition without an input carry.
    * **Interfaces**: Inputs `a`, `b`; Outputs `sum`, `carry`.
* **full_adder**: A 1-bit adder that includes an input carry[cite: 1].
    * **Hierarchy**: It is designed to instantiate the `half_adder`[cite: 1].
    * **Interfaces**: Inputs `a`, `b`, `cin`; Outputs `sum`, `cout`.
* **adder4**: A 4-bit ripple-carry adder[cite: 1].
    * **Hierarchy**: This module instantiates four `full_adder` submodules.
    * **Interfaces**: Inputs `[3:0] a`, `[3:0] b`, `cin`; Outputs `[3:0] sum`, `cout`.
* **adder8 (Top Module)**: The final 8-bit ripple-carry adder[cite: 1].
    * **Hierarchy**: It instantiates two `adder4` modules to complete the 8-bit logic, satisfying the requirement to instantiate at least two submodules.
    * **Interfaces**: Inputs `[7:0] a`, `[7:0] b`, `cin`; Outputs `[7:0] sum`, `cout`.



### 3. Representative Prompts

**Submodule Prompt (half_adder):** 
> //We will be generating a 8-bit ripple-carry adder hierarchically in Verilog. Please begin by generating a half adder defined as follows:
> module half_adder(input wire a, input wire b, output wire sum, output wire carry)
> //Insert code here
> endmodule

**Top Module Prompt (adder8):** 
> //We are generating a 8-bit ripple-carry adder hierarchically in Verilog. We have generated half adder, full adder, 4-bit ripple-carry adder defined as follows: [Previous Module Code]
> //Please include the previous module(s) in your response and use them to hierarchically generate a 8-bit ripple-carry adder defined as:
> module adder8(input [7:0] a, input [7:0] b, input cin, output [7:0] sum, output cout)
> //Insert code here
> endmodule

### 4. Verification Results
Verification was performed using `iverilog` for compilation and `vvp` for simulation[cite: 1]. Each module was tested with a self-checking testbench[cite: 1].

* **half_adder**: Passed in 1 iteration (Iteration 0).
* **full_adder**: Passed in 1 iteration (Iteration 0).
* **adder4**: Passed in 2 iterations (Iteration 1).
* **adder8**: Passed in 3 iterations (Iteration 2).

**Final Simulation Commands:** 
1. `iverilog -o adder8 ./adder8/adder8.v adder8tb.v`
2. `vvp adder8`

All modules successfully printed the required "**passed!**" message upon completion.

## Part III: Debugging Documentation and Results

This section outlines the iterative process used to correct the **adder8** (8-bit ripple-carry adder) module. The feedback loop was essential in directing the model to transition from generating submodules to completing the top-level hierarchical design.

### 1. Iteration Table
The table below tracks the debugging progress from the initial failure to the successful simulation.

| Iteration | Issue Observed | Fix Applied | Outcome |
| :--- | :--- | :--- | :--- |
| 0 | **Compile Error**: The model generated an `adder4` module instead of the required `adder8` because the prompt context was still focused on the previous hierarchical step. | Fed the compiler error back to the model, specifically pointing out that the `adder8` module was missing. | **Failed** |
| 1 | **Compile Error**: Despite the feedback, the model repeated the `adder4` implementation, failing to rename the module or expand the logic. | Re-submitted the specific "Unknown module type: adder8" error to emphasize the naming requirement. | **Failed** |
| 2 | **Success**: The model correctly generated the `adder8` module by instantiating eight `full_adder` components in a ripple-carry chain. | Final simulation with the self-checking testbench passed all checks. | **Passed!** |



### 2. Iteration Log Analysis
The primary technical hurdle was a module name mismatch. The testbench (`adder8tb.v`) expected a module named `adder8`, but the model initially provided `adder4` due to the template provided in the prompt.

**Key Error Lines:**
```text
./adder8tb.v:4: error: Unknown module type: adder8
2 error(s) during elaboration.
*** These modules were missing:
        adder8 referenced 1 times.