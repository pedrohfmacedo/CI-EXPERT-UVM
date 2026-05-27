# Robot Documentation

This document summarizes the intended behavior of the `robot_model`, the main FSM structure, and the verification strategy used in this project.

## Specification Summary

The robot serves four unload stations: `s0`, `s1`, `s2`, and `s3`.

- Only one request is expected at a time.
- A valid transaction starts with a one-hot request.
- The robot performs a load sequence first.
- After loading, it performs the unload sequence for the selected station.
- The request is considered complete only after the matching `s*_unload_done` signal is observed.

Operationally, stations `s1` and `s3` require an extra vertical joint movement during unload, while `s0` and `s2` follow the shorter unload path.

The original source for the assignment is [specification.pdf](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/docs/specification.pdf).

## FSM Structure

The design is easier to understand as three cooperating FSMs:

- Main control FSM: waits for a valid request and tracks whether the active service belongs to the `s0/s1` side or the `s2/s3` side.
- Load FSM: performs the load sequence `IDLE -> WRIST_HOR -> LOAD_ITEM -> WRIST_VERT -> IDLE`.
- Unload FSM: performs the unload sequence, starting at `JOINTA_RIGHT`, optionally visiting `JOINTC_DOWN` and `JOINTC_UP`, then releasing the claw and returning through `JOINTA_LEFT`.

In the corrected implementations, the active station is latched so the design keeps serving the same request even if inputs change during the transaction.

## RTL Variants

- [../rtl/robot_model.v](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/rtl/robot_model.v): original Verilog RTL.
- [../rtl/robot_model_correct.v](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/rtl/robot_model_correct.v): corrected Verilog RTL and best reference for intended behavior.
- [../rtl/robot_model.sv](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/rtl/robot_model.sv): incomplete SystemVerilog elaboration attempt.
- [../rtl/robot_model_2.sv](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/rtl/robot_model_2.sv): more complete SystemVerilog version based on the corrected behavior.

## Testbenches

- [../tb/robot_model_tb.sv](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/tb/robot_model_tb.sv): main self-checking testbench. It contains the reference model, scoreboard, state tracking, and directed tests.
- [../tb/robot_model_tb2.sv](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/tb/robot_model_tb2.sv): unfinished SystemVerilog/self-checking attempt.
- [../tb/robot_model_tb.v](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/tb/robot_model_tb.v): original manual Verilog testbench used mostly for waveform observation.
- [../tb/robot_model_tb2.v](/home/pedro.macedo/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/tb/robot_model_tb2.v): another Verilog version derived from the original `robot_model_tb.v`.

## Reference Model

The main reference model lives inside `robot_model_tb.sv`. It mirrors the expected main, load, and unload FSM transitions and computes the expected outputs:

- `load_start`
- `s0_unloadstart`
- `s1_unloadstart`
- `s2_unloadstart`
- `s3_unloadstart`

It also enforces the project assumption that only one request is legal at a time. Multi-request patterns are treated as out-of-spec and are expected to keep the design idle.

## Verification Plan

The verification intent is simple and mostly directed:

- Reset behavior: confirm all FSMs and outputs return to idle under active-low reset.
- Valid request flows: run complete sequences for `s0`, `s1`, `s2`, and `s3`.
- Path differentiation: confirm `s1` and `s3` use the extra joint-C path, while `s0` and `s2` do not.
- Completion handling: confirm only the matching `s*_unload_done` completes the service.
- Illegal stimulus: apply multi-request combinations and `done` pulses without a valid request.
- State visibility: check that the DUT state encodings match the expected main/load/unload progress.

This is not a constrained-random environment. The current approach is a compact directed self-checking flow centered on behavior matching against the embedded reference model.
