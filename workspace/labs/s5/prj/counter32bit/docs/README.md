## 🔹 7. Counter with Overflow – `counter_overflow`

**What it does:**
A 32-bit counter with an additional overflow bit.

**Special notes:**

* Internally uses a **33-bit register**:

  * Lower 32 bits → count
  * MSB → overflow
* Has a **load feature**:

  * Loads a predefined value (`33'hfffffff8`)
* Supports:

  * Enable counting
  * Reset
  * Load operation

---

## Self-Checking SystemVerilog Testbench

File: `tb/tb_counter32bit.sv`

This testbench verifies the counter automatically. It models the expected 33-bit counter value, then compares `counter_out` and `counter_overflow` against the reference result.

Checks covered:

* reset behavior
* enabled counting
* load operation
* overflow tracking
* randomized `en` and `load` combinations

The simulation prints `PASS` and `FAIL` counters and reports mismatches with DUT and reference counter values.

Run with:

```sh
make vcs2
make run
```
