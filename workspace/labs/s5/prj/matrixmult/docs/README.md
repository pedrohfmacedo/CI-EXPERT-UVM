## 🔹 5. 2×2 Matrix Multiplier – `matrix2x2_mult`

**What it does:**
Multiplies two 2×2 matrices packed into 32-bit inputs.

**How it works:**

* Each matrix is split into four 8-bit elements.
* Performs matrix multiplication:

  ```
  [a b]   [e f]
  [c d] x [g h]
  ```

**Special notes:**

* Uses **internal 2D arrays** (interesting Verilog feature).
* Mixed behavior:

  * Input unpacking → combinational
  * Computation → clocked
* Output packed back into 32-bit.

---

## Self-Checking SystemVerilog Testbench

File: `tb/tb_matrixmult.sv`

This testbench verifies the matrix multiplier automatically. It drives packed 2x2 matrices, computes the expected packed result with a reference model, and compares it against `Res`.

Checks covered:

* reset behavior
* enabled matrix multiplication
* disabled output hold behavior
* randomized packed matrix values

The simulation prints `PASS` and `FAIL` counters and reports mismatches with `A`, `B`, DUT result, and reference result.

Run with:

```sh
make vcs2
make run
```
