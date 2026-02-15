# ChipChat Report 
Heng Pu  
Netid: hp2723  

## Example 1 7420 Chip
### 1. Initial Prompt  
```sv
// The 7400-series integrated circuits are a series of digital chips with a few gates each. The 7420 is a chip with two 4-input NAND gates.

// Create a module with the same functionality as the 7420 chip. It has 8 inputs and 2 outputs.

module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
```
### 2. Parameters
```json
{
	"general": {
        "prompt": "./7420.sv",
        "name": "top_module",
        "testbench": "./7420_tb.sv",
		"model_family": "ChatGPT",
		"model_id": "gpt-4o-mini",
		"num_candidates": 5,
		"iterations": 5,
        "outdir": "outputs_7420",
        "log": "log.txt",
		"ensemble": false
    }
}
```
**Imposrtant Parameters**
* Model name: gpt-4o-mini  
* Max iterations: 5
* Num of candidates: 5
  
### 3. Trajectory  
The 7420 generation followed a straightforward path where the gpt-4o-mini model achieved success on the first attempt. After receiving the initial prompt describing the dual 4-input NAND gate, the model produced the complete Verilog code during iteration zero. AutoChip then used the iverilog tool to compile the design and verify it against the testbench. The simulation showed zero mismatches across all 239 samples, meaning the model correctly implemented the combinational logic without requiring any feedback-driven corrections or extra iterations.  

## Example 2 Arbiter Circuit
### 1. Initial Prompt

### 2. Parameters

### 3. Trajectory