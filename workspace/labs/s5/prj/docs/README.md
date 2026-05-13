# Self-Checking SystemVerilog Testbenches

This project adds self-checking SystemVerilog testbenches (`.sv`) for the Lab 5 Verilog RTL blocks.

The goal is to verify each DUT automatically by comparing its output against a local reference model and reporting pass/fail counts at the end of simulation.

## Covered Blocks

- `1x8demux`
- `8x1mux`
- `adder32`
- `arbiter`
- `counter32bit`
- `decoder2x4`
- `encoder4x2`
- `matrixmult`
- `multiplier16x16`

`updown_counter` currently has only the original Verilog testbench. Its README documents the missing `.sv` self-checking testbench requirements.

## Project Structure

Each block follows the same basic layout:

```text
<block>/
+-- rtl/        # Verilog DUT
+-- tb/         # Verilog TB and, when available, self-checking SystemVerilog TB
+-- docs/       # Block README
`-- Makefile    # Build and simulation targets
```

The self-checking files are located under:

```text
prj/<block>/tb/tb_<block>.sv
```

## Testbench Approach

The `.sv` testbenches include:

- clock and reset generation
- directed and/or randomized stimulus
- a reference model for expected behavior
- automatic DUT vs. reference comparison
- pass/fail counters
- error messages with useful signal context
- FSDB waveform dump support

## Running a Simulation

Enter the target block directory and compile the SystemVerilog testbench:

```sh
cd prj/<block>
make vcs2
make run
```

Useful targets:

- `make vcs2` compiles the `.sv` testbench with VCS
- `make run` runs the simulation
- `make verdi_wf_easy` opens the generated FSDB waveform
- `make clean` or `make vcs_clean` removes generated simulation files, depending on the block

## Reference Template

`prj/tb_model.sv` contains the base structure used to build the self-checking testbenches.
