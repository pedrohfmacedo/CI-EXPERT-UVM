# Arbiter - `arbiter`

**What it does:**
Grants access to one of two clients based on request signals and priority selection.

**Special notes:**

* Uses a clocked FSM.
* Tracks pending client requests.
* Uses active-low reset (`reset_n`).

## Self-Checking SystemVerilog Testbench

File: `tb/tb_arbiter.sv`

This testbench verifies the arbiter automatically. It uses a SystemVerilog interface, a reference FSM model, and a scoreboard that compares `o_grant1` and `o_grant2` against the expected grants.

Checks covered:

* client 1 request
* client 2 request
* simultaneous requests
* alternating requests
* reset during operation
* randomized request and priority combinations

The simulation prints pass/fail messages during execution and a final `PASS COUNT` / `FAIL COUNT` summary.

Run with:

```sh
make vcs2
make run
```
