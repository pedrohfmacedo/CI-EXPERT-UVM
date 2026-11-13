## 🔹 6. 16×16 Multiplier – `multiplier`

**What it does:**
Multiplies two 16-bit numbers and produces a 32-bit result.

**Special notes:**

* Sequential (clocked), not purely combinational.
* Uses **register to store result**.
* Controlled by **enable and reset**.

---

## Self-Checking SystemVerilog Testbench

File: `tb/tb_multiplier16x16.sv`

This testbench verifies the multiplier automatically. It drives 16-bit operands and `en`, computes the expected 32-bit product with a reference model, and compares it against `multi_out`.

Checks covered:

* reset behavior
* enabled multiplication with random operands
* disabled output hold behavior
* directed edge cases, including zero and maximum operand values

The simulation prints `PASS` and `FAIL` counters and reports mismatches with operands, enable, DUT output, and reference output.

Run with:

```sh
make vcs2
make run
```
