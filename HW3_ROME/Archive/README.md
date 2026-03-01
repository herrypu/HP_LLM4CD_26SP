# HP_LLM4CD_S6SP
@Tandon NYU

## HW1_ChipChat
### Final Reports
* **[ChipChat_Report.pdf](./HW1_ChipChat/ChipChat_Report.pdf)**: The comprehensive final report covering all examples, iteration logs, and extension analysis. (Markdown version also available: **[ChipChat_Report.md](./HW1_ChipChat/ChipChat_Report.md)**).

### Implementation Notebooks
These notebooks contain the final prompts, generated Verilog code, and simulation results (iverilog):
* **[chipchat_exampleA.ipynb](./HW1_ChipChat/chipchat_exampleA.ipynb)**: Example A (Binary-to-BCD Converter).
* **[chipchat_exampleB.ipynb](./HW1_ChipChat/chipchat_exampleB.ipynb)**: Example B (Sequence Detector - Mealy FSM).
* **[chipchat_extension.ipynb](./HW1_ChipChat/chipchat_extension.ipynb)**: Extension (Parameterized Sequence Detector with multi-instance verification).

## HW2_AutoChip
### Final Reports
* **[AutoChip_Report.pdf](./HW2_AutoChip/AutoChip_Report.pdf)**: The comprehensive final report covering the AutoChip generation trajectories, iteration logs, and manual RTL design explanations.(Markdown version also available: **[AutoChip_Report.md](./HW2_AutoChip/AutoChip_Report.md)**).

### Implementation Notebooks
These notebooks contain the AutoChip workflow, generated Verilog code, automated iterations, and simulation results:
* **[example1.ipynb](./HW2_AutoChip/example1.ipynb)**: Example 1 (Binary-to-BCD Converter) using the AutoChip trajectory.
* **[example2.ipynb](./HW2_AutoChip/example2.ipynb)**: Example 2 (Sequence Detector - Mealy FSM) using the AutoChip trajectory.
* **[HumanSVTesting.ipynb](./HW2_AutoChip/HumanSVTesting.ipynb)**: PartB Handwrting Sequence Detector SV RTL Testbench Testing

### Project Structure

```text
.
├── HW1_ChipChat/
│   ├── ChipChat_Report.pdf       # HW1 Final consolidated report (PDF)
│   ├── ChipChat_Report.md        # HW1 Final consolidated report (Markdown)
│   ├── chipchat_exampleA.ipynb   # HW1 Example A final submission
│   ├── chipchat_exampleB.ipynb   # HW1 Example B final submission
│   ├── chipchat_extension.ipynb  # HW1 Part III Extension final submission
│   ├── hw1log.md                 # HW1 Chat/Iteration logs
│   ├── Archive/                  # Early attempts and intermediate iterations
│   └── Docs/                     # Assignment rubric and official tutorial files
│
└── HW2_AutoChip/
    ├── AutoChip_Report.pdf       # HW2 Final consolidated report (PDF)
    ├── example1.ipynb            # HW2 Example 1 (Binary-to-BCD) notebook
    ├── example2.ipynb            # HW2 Example 2 (Sequence Detector) notebook
    ├── bcd_example.zip           # Compressed backup of Example 1 workspace
    ├── seq_example.zip           # Compressed backup of Example 2 workspace
    ├── bcd_example/              # Example 1 working directory
    │   ├── prompt.txt            # Initial hardware specification prompt
    │   ├── config.json           # AutoChip configuration file
    │   ├── testbench.v           # Testbench compatible with AutoChip evaluation
    │   └── outputs_bcd/          # AutoChip generated trajectories and logs
    │       ├── log.txt           # Main iteration log for Example 1
    │       └── iter0/            # Candidate responses and simulation results for iteration 0
    └── seq_example/              # Example 2 working directory
        ├── prompt.txt            # Initial hardware specification prompt (with FSM hint)
        ├── config.json           # AutoChip configuration file
        ├── sequence_detector_tb.v# Modified official testbench for AutoChip
        └── outputs_seq/          # AutoChip generated trajectories and logs
            ├── log.txt           # Main iteration log for Example 2
            └── iter0/            # Candidate responses and simulation results for iteration 0