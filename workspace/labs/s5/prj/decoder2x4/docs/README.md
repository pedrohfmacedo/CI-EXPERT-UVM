## 🔹 3. Decoder (2×4) – `decoder2x4`

**What it does:**
Converts a 2-bit input into a one-hot 4-bit output.

**Special notes:**

* Only one output is HIGH at a time.
* Implemented with **clocked output**, not purely combinational.
* Includes **enable + reset**.

---

## Self-Checking SystemVerilog Testbench

File: `tb/tb_decoder2x4.sv`

This testbench verifies the decoder automatically. It drives `din` and `en`, computes the expected one-hot output with a reference model, and compares it against `dout`.

Checks covered:

* reset behavior
* enabled decoding for all input values
* disabled output hold behavior
* randomized input combinations

The simulation prints `PASS` and `FAIL` counters and reports mismatches with the current `en`, `din`, DUT output, and reference output.

Run with:

```sh
make vcs2
make run
```
