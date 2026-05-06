## 🔹 1. Demultiplexer (1×8) – `demux1x8`

**What it does:**
Routes a single input (`din`) to one of 8 outputs (`dout`) based on a 3-bit select signal.

**Special notes:**

* Only one output bit is high at a time.
* Output is **clocked (latched)** even though demux is normally combinational.
* Uses **enable (`en`)** and **active-low reset (`rstn`)**.

---