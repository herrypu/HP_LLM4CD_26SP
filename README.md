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

## HW3_ROME
### Final Reports
* **[ROME_Report.pdf](./HW3_ROME/ROME_Report.pdf)**: Final report documenting the hierarchical Verilog generation using the ROME workflow, including the Mux demo, Ripple-carry adder extension, and debugging iteration tables. (Markdown version: **[ROME_Report.md](./HW3_ROME/ROME_Report.md)**).

### Implementation Notebooks
These notebooks demonstrate the hierarchical decomposition and verification feedback loop:
* **[ROME_submission_P1.ipynb](./HW3_ROME/ROME_submission_P1.ipynb)**: Part I submission featuring the provided Mux hierarchy demo (2-to-1, 4-to-1, and 8-to-1 multiplexers).
* **[ROME_Part2&3.ipynb](./HW3_ROME/ROME_Part2&3.ipynb)**: Completion of Parts II and III, featuring the Ripple-carry adder extension (half-adder to 8-bit adder) and automated debugging logs.

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
├── HW2_AutoChip/
│   ├── AutoChip_Report.pdf       # HW2 Final consolidated report (PDF)
│   ├── example1.ipynb            # HW2 Example 1 (Binary-to-BCD) notebook
│   ├── example2.ipynb            # HW2 Example 2 (Sequence Detector) notebook
│   ├── bcd_example.zip           # Compressed backup of Example 1 workspace
│   ├── seq_example.zip           # Compressed backup of Example 2 workspace
│   ├── bcd_example/              # Example 1 working directory
│   │   ├── prompt.txt            # Initial hardware specification prompt
│   │   ├── config.json           # AutoChip configuration file
│   │   ├── testbench.v           # Testbench compatible with AutoChip evaluation
│   │   └── outputs_bcd/          # AutoChip generated trajectories and logs
│   │       ├── log.txt           # Main iteration log for Example 1
│   │       └── iter0/            # Candidate responses and simulation results for iteration 0
│   └── seq_example/              # Example 2 working directory
│       ├── prompt.txt            # Initial hardware specification prompt (with FSM hint)
│       ├── config.json           # AutoChip configuration file
│       ├── sequence_detector_tb.v# Modified official testbench for AutoChip
│       └── outputs_seq/          # AutoChip generated trajectories and logs
│           ├── log.txt           # Main iteration log for Example 2
│           └── iter0/            # Candidate responses and simulation results for iteration 0
│
├── HW3_ROME/
│   ├── Archive/                    # Archived files and alternative model attempts
│   │   ├── README.md               # Archive documentation
│   │   ├── ROME_GeneratedFiles.zip # Zipped backup of generated files
│   │   ├── ROME_Part2_GPT3.5.zip   # Part 2 backup using GPT-3.5
│   │   ├── ROME_Part2_gpt5.ipynb   # Experimental notebook for GPT-5
│   │   └── ROME_Part2_GPT5.zip     # Part 2 backup using GPT-5
│   ├── Docs/                       # Assignment requirements and demo files
│   │   ├── ROME_Assignment.pdf     # Official assignment instructions
│   │   └── ROME_demo.ipynb         # Official provided demo notebook
│   ├── ROME_P1_GeneratedFiles/     # Generated files for Part I (Mux Demo)
│   │   ├── mux2to1/                # 2-to-1 Multiplexer submodule files and logs
│   │   ├── mux4to1/                # 4-to-1 Multiplexer submodule files and logs
│   │   ├── mux8to1/                # 8-to-1 Multiplexer top module files and logs
│   │   ├── sample_data/            # Colab/Local sample data directory
│   │   ├── mux2to1tb.v             # Testbench for 2-to-1 Multiplexer
│   │   ├── mux4to1tb.v             # Testbench for 4-to-1 Multiplexer
│   │   └── mux8to1tb.v             # Testbench for 8-to-1 Multiplexer
│   ├── Rome_P2_GeneratedFiles/     # Generated files for Part II (Adder Extension)
│   │   ├── adder4/                 # 4-bit Ripple-carry adder files and logs
│   │   ├── adder8/                 # 8-bit Ripple-carry adder top module files and logs
│   │   ├── full_adder/             # Full adder submodule files and logs
│   │   ├── half_adder/             # Half adder submodule files and logs
│   │   └── sample_data/            # Colab/Local sample data directory
│   ├── ROME_Part2&3.ipynb          # Part II & III final submission notebook
│   ├── ROME_Report.md              # HW3 Final consolidated report (Markdown)
│   ├── ROME_Report.pdf             # HW3 Final consolidated report (PDF)
│   └── ROME_submission_P1.ipynb    # Part I final submission notebook
│
├── .gitignore
├── LICENSE
├── pack_repo.py
├── README.md
└── repo_analysis_data.txt