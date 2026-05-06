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