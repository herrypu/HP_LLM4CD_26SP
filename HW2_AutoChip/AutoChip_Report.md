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
```sv
// Consider the FSM described by the state diagram shown below:

// A --r1=0,r2=0,r3=0--> A
// A --r1=1--> B
// A --r1=0,r2=1--> C
// A --r1=0,r2=0,r3=0--> D
// B (g1=1) --r1=1--> B
// B (g1=1) --r1=0--> A
// C (g2=1) --r2=1--> C
// C (g2=1) --r2=0--> A

// Resetn is an active-low synchronous reset that resets into state A. This FSM acts as an arbiter circuit, which controls access to some type of resource by three requesting devices. Each device makes its request for the resource by setting a signal _r[i]_ = 1, where _r[i]_ is either _r[1]_, _r[2]_, or _r[3]_. Each r[i] is an input signal to the FSM, and represents one of the three devices. The FSM stays in state _A_ as long as there are no requests. When one or more request occurs, then the FSM decides which device receives a grant to use the resource and changes to a state that sets that device's _g[i]_ signal to 1. Each _g[i]_ is an output from the FSM. There is a priority system, in that device 1 has a higher priority than device 2, and device 3 has the lowest priority. Hence, for example, device 3 will only receive a grant if it is the only device making a request when the FSM is in state _A_. Once a device, _i_, is given a grant by the FSM, that device continues to receive the grant as long as its request, _r[i]_ = 1.

// Write complete Verilog code that represents this FSM. Use separate always blocks for the state table and the state flip-flops, as done in lectures. Describe the FSM outputs, _g[i]_, using either continuous assignment statement(s) or an always block (at your discretion). Assign any state codes that you wish to use.

module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
```
### 2. Parameters
```json
{
	"general": {
        "prompt": "./2013_q2afsm.sv",
        "name": "top_module",
        "testbench": "./2013_q2afsm_tb.sv",
		"model_family": "ChatGPT",
		"model_id": "gpt-4o-mini",
		"num_candidates": 5,
		"iterations": 5,
        "outdir": "outputs_arbiter",
        "log": "log.txt",
		"ensemble": false
    }
}
```
### 3. Trajectory