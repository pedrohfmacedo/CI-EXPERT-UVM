## 🔹 4. Encoder (4×2) – `encoder4x2`

**What it does:**
Encodes a one-hot 4-bit input into a 2-bit binary output.

**Special notes:**

* Assumes valid one-hot input (no priority handling).
* Output is **latched on clock edge**.
* Includes **enable and reset**.

---

## Self-Checking SystemVerilog Testbench

File: `tb/tb_encoder4x2.sv`

This testbench verifies the encoder automatically. It drives valid and invalid 4-bit input patterns, computes the expected encoded value with a reference model, and compares it against `dout`.

Checks covered:

* reset behavior
* valid one-hot inputs
* invalid/random input patterns
* disabled output hold behavior

The simulation prints `PASS` and `FAIL` counters and reports mismatches with the current `en`, `din`, DUT output, and reference output.

Run with:

```sh
make vcs2
make run
```
