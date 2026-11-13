# Robot Project

This repository contains the RTL, testbenches, simulation scripts, and notes for the `robot_model` design.

## Overview

The design models a robot that receives one unload request at a time from four stations (`s0` to `s3`). The robot performs a load sequence, routes the item to the requested station, and completes the unload sequence before accepting a new request.

The original assignment material is available in [docs/specification.pdf](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/docs/specification.pdf).

## Repository Layout

- `rtl/`
  - `robot_model.v`: original Verilog RTL.
  - `robot_model_correct.v`: corrected Verilog RTL aligned with the reference behavior.
  - `robot_model.sv`: incomplete SystemVerilog rewrite attempt.
  - `robot_model_2.sv`: cleaner SystemVerilog version of the corrected intent.
- `tb/`
  - `robot_model_tb.v`: original manual Verilog testbench.
  - `robot_model_tb.sv`: main self-checking SystemVerilog testbench with reference model and scoreboard.
  - `robot_model_tb2.sv`: unfinished self-checking/SystemVerilog experiment.
  - `robot_model_tb2.v`: another Verilog version derived from the original `robot_model_tb.v`.
- `sim/`: VCS/Verdi compile and run scripts.
- `docs/`: concise project documentation and the original PDF specification.
- `cmd/`: saved waveform/debug command files.

## How To Run

From `sim/`:

```sh
make robot_comp
make robot_sim
make robot_gui
make robot_wav
make robot_verdi
make robot_restart
```

## Recommended Reference Points

Use [rtl/robot_model_correct.v](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/rtl/robot_model_correct.v) as the main Verilog reference for behavior, and [tb/robot_model_tb.sv](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/tb/robot_model_tb.sv) as the main verification environment.

For a short technical description of the FSMs, reference model, and verification strategy, see [docs/README.md](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/docs/README.md).
