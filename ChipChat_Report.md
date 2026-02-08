# ChipChat Report 
Heng Pu  
netid: hp2723

## 1. Choice of Examples and Extension
Example A: Example 1 - binary_to_bcd (combinational converter)  
Example B:  
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
### b. Final Module Interface
### c. Design Approach
### d. Verification Results
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
##### (2) What I changed to fix
##### (3) Why I Expect it to help

#### Iteration #3
##### (1) What Failed
##### (2) What I changed to fix
##### (3) Why I Expect it to help

## 5. Extension Report
### a. Final Prompt
### b. Final Module Interface
### c. Design Approach
### d. Verification Results