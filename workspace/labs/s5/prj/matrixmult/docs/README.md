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