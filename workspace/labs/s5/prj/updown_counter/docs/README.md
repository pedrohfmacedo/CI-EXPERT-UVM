## Up/Down Counter - `updowncounter`

**What it does:**
Implements two 4-bit counters that run in parallel.

**Special notes:**

* `up_counter` increments from `0000`.
* `down_counter` decrements from `1111`.
* Counting starts when `en` is high.
* Uses active-low reset (`resetn`).

---

## Self-Checking SystemVerilog Testbench

Current status: this block does not have a `.sv` self-checking testbench in `tb/`.

Only the original Verilog testbench is present:

```text
tb/tb_updown_counter.v
```

To match the other blocks, the missing `.sv` testbench should add:

* a reference model for `up_counter` and `down_counter`
* reset and enable checks
* output hold checks when `en` is low
* pass/fail counters
* mismatch messages with DUT and reference values

The Makefile already has a `vcs2` target for `tb/tb_updown_counter.sv`, but that file must exist before the target can be used.
