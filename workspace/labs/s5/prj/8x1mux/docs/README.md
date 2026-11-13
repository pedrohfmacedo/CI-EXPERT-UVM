## 🔹 2. Multiplexer (8×1) – `mux8x1`

**What it does:**
Selects one of 8 input bits and forwards it to a single output.

**Special notes:**

* Controlled by a 3-bit select signal.
* Output is **registered (clocked)** instead of purely combinational.
* Includes **enable and reset**.

---

## Self-Checking SystemVerilog Testbench

File: `tb/tb_8x1mux.sv`

This testbench verifies the mux automatically. It drives random values for `sel` and `din`, computes the selected bit with a reference model, and compares it against `dout`.

Checks covered:

* reset behavior
* enabled mux selection
* disabled output hold behavior
* randomized select/input combinations

The simulation prints `PASS` and `FAIL` counters and reports mismatches with the current `en`, `sel`, `din`, DUT output, and reference output.

Run with:

```sh
make vcs2
make run
```
