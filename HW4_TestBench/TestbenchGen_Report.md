# Part I - Tutorial Examples

For this section, I selected two examples from the notebook: one combinational logic design and one arithmetic logic design.

## 1. Example 1: 2-to-1 Multiplexer (Combinational)

* **Pipeline Execution**: The full pipeline ran successfully. It generated all four required files in the `mux/` output folder: `testbench_initial.v`, `golden_model.py`, `test_patterns_with_golden.json`, and `testbench_final.v`.
* **Compilation and Simulation Commands**:
    ```bash
    iverilog -g2012 -o LLM-aided-Testbench-Generation/examples/output/mux/sim.vvp LLM-aided-Testbench-Generation/examples/output/mux2to1.v LLM-aided-Testbench-Generation/examples/output/mux/testbench_final.v
    
    vvp LLM-aided-Testbench-Generation/examples/output/mux/sim.vvp
    ```
* **Simulation Output**: All 8 test patterns passed successfully. Here is the final summary from the simulation:
    ```text
    Test 1: a=0, b=0, sel=0, y=0
    Check y: yes (expected 0, got 0)
    ...
    Test Summary: Total tests = 8, Passed = 8, Failed = 0
    ```
* **Verification Evidence**: The generated `testbench_final.v` uses `if-else` statements to compare the actual output (`y`) with the expected output from the golden model. It also records the results using integer counters. Here is the key code section:
    ```verilog
    if (y === 0) begin
        $display("Check y: yes (expected 0, got %b)", y);
        passed_tests = passed_tests + 1;
    end else begin
        $display("Check y: no (expected 0, got %b)", y);
        failed_tests = failed_tests + 1;
    end
    ```

---

## 2. Example 2: 4-bit Adder (Arithmetic)

* **Pipeline Execution**: The full pipeline ran successfully. It generated all four required files in the `adder/` output folder: `testbench_initial.v`, `golden_model.py`, `test_patterns_with_golden.json`, and `testbench_final.v`.
* **Compilation and Simulation Commands**:
    ```bash
    iverilog -g2012 -o LLM-aided-Testbench-Generation/examples/output/adder/sim.vvp LLM-aided-Testbench-Generation/examples/output/adder4bit.v LLM-aided-Testbench-Generation/examples/output/adder/testbench_final.v
    
    vvp LLM-aided-Testbench-Generation/examples/output/adder/sim.vvp
    ```
* **Simulation Output**: All 10 test patterns passed without any errors. Here is the final summary from the simulation:
    ```text
    Test 1: a=0000, b=0000
    Test 1 Passed: Sum = 0000 (Expected: 0000), Carry = 0 (Expected: 0)
    ...
    Test Summary: Total Tests = 10, Passed = 10, Failed = 0
    ```
* **Verification Evidence**: The final testbench for the adder checks multiple outputs at the same time. It verifies that both the `Sum` (4-bit) and the `Carry` (1-bit) match the expected values calculated by the Python golden model. If both match, it adds to the `passed_tests` counter; if any mismatch happens, it adds to the `failed_tests` counter and prints an error message.

# Part II - Artifact Inspection

I chose the **4-bit Adder (Arithmetic)** example to explain the generated files.

## 1. Golden Model (`golden_model.py`)
The golden model is a Python function that acts as the software reference for the hardware design.
* **Inputs**: It takes two parameters, `a` and `b`, which represent the 4-bit unsigned input numbers.
* **Outputs**: It returns a dictionary containing the expected outputs: `sum` (the lower 4 bits of the addition) and `carry` (the 1-bit overflow flag).
* **Computation**: It computes the result by adding `a` and `b` in Python. It then calculates the 4-bit `sum` and the 1-bit `carry` (which becomes 1 if the addition result is greater than 15) and returns them as the correct reference answer.

## 2. Pattern File (`test_patterns_with_golden.json`)
This JSON file stores all the test cases and their correct answers.
* **Fields**: The file contains a list of objects (dictionaries). Each object has the input values for a specific test case (for example, `a` and `b`).
* **Expected Outputs**: After the Python golden model calculates the correct answer for each input, this answer is saved inside the same object under the `expected_outputs` field. This field contains the calculated `sum` and `carry` values, which the testbench will use later to check the hardware.

## 3. Updater Effect (Before vs. After)
The updater script changes the basic testbench into a smart, self-checking testbench.
* **Before (`testbench_initial.v`)**: The initial testbench only applies the input signals (like `a = 15; b = 15;`) and prints them to the screen using `$display`. It does not check if the hardware's output is correct.
* **After (`testbench_final.v`)**: The final testbench includes verification logic. After applying the inputs, it uses `if-else` statements to compare the actual hardware outputs (`sum` and `carry`) with the expected values from the JSON file. It also adds `passed_tests` and `failed_tests` integer counters to keep track of the results and prints a full test summary at the very end.

# Part III - Run the pipeline on your own module

* **Custom Module Name**: 4-bit Priority Encoder (`priority_encoder`)
* **LLM Setup**:
    * **Model Name**: GPT-4o.
    * **Key Parameters**: I used the default parameters provided in the notebook scripts (such as a temperature of 0.7 for the testbench generation and a temperature of 0.2 for the Python golden model).
    * **Prompt Choices**: In the natural language description, I specifically asked the LLM to generate exactly 25 test patterns. I required it to include all 16 possible input combinations (from 0000 to 1111) and 9 extra random patterns to ensure full coverage.
* **DUT Interface**:
    * `input wire [3:0] d`
    * `output reg [1:0] q`
    * `output reg valid`
* **Simulation Commands**:
    * **Compile**: 
        ```bash
        iverilog -g2012 -o LLM-aided-Testbench-Generation/examples/output/custom/sim.vvp LLM-aided-Testbench-Generation/examples/output/priority_encoder.v LLM-aided-Testbench-Generation/examples/output/custom/testbench_final.v
        ```
    * **Run**: 
        ```bash
        vvp LLM-aided-Testbench-Generation/examples/output/custom/sim.vvp
        ```

---

# Part IV - Demonstrate bug detection

* **Bug Introduction**: I introduced an intentional logic error in the `priority_encoder.v` file. When `d[3]` is 1, the output `q` should be `3` (`2'd3`). I changed this assignment to `q = 2'd2;`.
* **Failing Snippet**: 
    Running the testbench against this buggy module successfully caught the errors. Because `d[3]` is 1 in many test cases, 13 tests failed. Here is a snippet of the failing output:
    ```text
    Test 9: d = 1000
      q = 10, valid = 1 [no, expected q = 11, valid = 1]
    Test 10: d = 1001
      q = 10, valid = 1 [no, expected q = 11, valid = 1]
    Test 11: d = 1010
      q = 10, valid = 1 [no, expected q = 11, valid = 1]
    ...
    Test Summary: Total tests = 25, Passed = 12, Failed = 13
    ```
* **Passing Confirmation After Fix**: 
    I fixed the bug by changing the code back to the correct `q = 2'd3;`. I recompiled and ran the simulation again. All 25 test patterns passed as expected.
    ```text
    Test 24: d = 1110
      q = 11, valid = 1 [yes]
    Test 25: d = 1100
      q = 11, valid = 1 [yes]
    Test Summary: Total tests = 25, Passed = 25, Failed = 0
    ```