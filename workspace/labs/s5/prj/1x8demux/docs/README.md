## 🔹 1. Demultiplexer (1×8) – `demux1x8`

**What it does:**
Routes a single input (`din`) to one of 8 outputs (`dout`) based on a 3-bit select signal.

**Special notes:**

* Only one output bit is high at a time.
* Output is **clocked (latched)** even though demux is normally combinational.
* Uses **enable (`en`)** and **active-low reset (`rstn`)**.

---

## Self-Checking SystemVerilog Testbench

File: `tb/tb_1x8demux.sv`

This testbench verifies the demux automatically. It drives random values for `sel` and `din`, computes the expected one-hot output with a reference model, and compares it against `dout`.

Checks covered:

* reset behavior
* enabled demux routing
* disabled behavior
* randomized input combinations

The simulation prints `PASS` and `FAIL` counters and reports mismatches with the current `en`, `sel`, `din`, DUT output, and reference output.

Run with:

```sh
make vcs2
make run
```
