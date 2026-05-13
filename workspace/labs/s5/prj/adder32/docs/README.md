# 32-bit Adder - `adder`

**What it does:**
Adds two 32-bit operands and produces a 32-bit sum plus carry out.

**Special notes:**

* Output is clocked.
* Uses `en` to update or hold the previous result.
* Uses active-low reset (`reset_n`).

## Self-Checking SystemVerilog Testbench

File: `tb/tb_adder32.sv`

This testbench verifies the adder automatically. It drives `op_a`, `op_b`, and `en`, computes the expected 33-bit result with a reference model, and compares both `adder_out` and `carry_out`.

Checks covered:

* reset behavior
* enabled additions with random operands
* disabled output hold behavior
* directed edge cases, including zero and carry-out overflow

The simulation prints `PASS` and `FAIL` counters and reports mismatches with operands, enable, DUT output, and reference output.

Run with:

```sh
make vcs2
make run
```
