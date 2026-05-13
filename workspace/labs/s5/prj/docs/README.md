# 📘 Verilog Circuits Collection – README

This repository contains a set of **basic digital design modules and their testbenches**, written in Verilog. The designs include combinational and sequential logic blocks commonly used in digital systems.

---

## 🔹 1. Demultiplexer (1×8) – `demux1x8`

**What it does:**
Routes a single input (`din`) to one of 8 outputs (`dout`) based on a 3-bit select signal.

**Special notes:**

* Only one output bit is high at a time.
* Output is **clocked (latched)** even though demux is normally combinational.
* Uses **enable (`en`)** and **active-low reset (`rstn`)**.

---

## 🔹 2. Multiplexer (8×1) – `mux8x1`

**What it does:**
Selects one of 8 input bits and forwards it to a single output.

**Special notes:**

* Controlled by a 3-bit select signal.
* Output is **registered (clocked)** instead of purely combinational.
* Includes **enable and reset**.

---

## 🔹 3. Decoder (2×4) – `decoder2x4`

**O que faz:**
Converte uma entrada de 2 bits em uma saída de 4 bits com codificação one-hot.

**Observações especiais:**

* Apenas uma saída fica HIGH por vez.
* Implementado com **saída sincronizada no clock**, não é puramente combinacional.
* Inclui **enable + reset**.

---

## 🔹 4. Encoder (4×2) – `encoder4x2`

**O que faz:**
Codifica uma entrada one-hot de 4 bits em uma saída binária de 2 bits.

**Observações especiais:**

* Assume entrada one-hot válida (sem prioridade).
* Saída é **latched na borda do clock**.
* Inclui **enable e reset**.

---

## 🔹 5. Multiplicador de Matrizes 2×2 – `matrix2x2_mult`

**O que faz:**
Multiplica duas matrizes 2×2 empacotadas em entradas de 32 bits.

**Como funciona:**

* Cada matriz é dividida em quatro elementos de 8 bits.
* Realiza a multiplicação matricial:

  ```
  [a b]   [e f]
  [c d] x [g h]
  ```

**Observações especiais:**

* Usa **arrays 2D internos** (recurso interessante do Verilog).
* Comportamento misto:

  * Desempacotamento de entrada → combinacional
  * Cálculo → sincronizado
* Saída empacotada novamente em 32 bits.

---

## 🔹 6. Multiplicador 16×16 – `multiplier`

**O que faz:**
Multiplica dois números de 16 bits e produz um resultado de 32 bits.

**Observações especiais:**

* Sequencial (sincronizado), não puramente combinacional.
* Usa **registrador para armazenar resultado**.
* Controlado por **enable e reset**.

---

## 🔹 7. Contador com Overflow – `counter_overflow`

**O que faz:**
Um contador de 32 bits com um bit adicional de overflow.

**Observações especiais:**

* Internamente usa um **registrador de 33 bits**:

  * Lower 32 bits → contagem
  * MSB → overflow
* Tem um recurso de **load**:

  * Carrega um valor pré-definido (`33'hfffffff8`)
* Suporta:

  * Contagem habilitada
  * Reset
  * Operação de load

---

## 🔹 8. Contador Up/Down (4-bit) – `updowncounter`

**O que faz:**
Conta para cima e para baixo simultaneamente:

* `up_counter`: incrementa
* `down_counter`: decrementa

**Observações especiais:**

* Ambos os contadores operam em paralelo.
* Reset inicializa:

  * Up → `0000`
  * Down → `1111`
* Controlado por sinal de enable.

---

## 🔹 9. Testbenches (TBs)

Cada módulo tem um testbench correspondente:

* `demux1x8_tb`
* `mux8x1_tb`
* `decoder2x4_tb`
* `encoder4x2_tb`
* `matrix2x2_mult_tb`
* `multiplier_tb`
* `counter_overflow_tb`
* `updown_counter_tb`

**O que fazem:**

* Geram sinais de clock
* Aplicam estímulos (valores de entrada)
* Geram arquivos de waveform (`.vcd` / `.fsdb`)

**Observações especiais:**

* Usam `$dumpfile`, `$dumpvars`, ou `$fsdbDumpvars`
* Ajudam a visualizar o comportamento em viewers de waveform (GTKWave, Verdi, etc.)

---

## ⚙️ General Observations

* Many designs are **clocked even when typically combinational**
  → Good for learning sequential design behavior.

* Consistent use of:

  * `en` (enable)
  * `rstn` / `resetn` (active-low reset)

* Good mix of:

  * **Combinational logic** (mux, demux, encoder, decoder)
  * **Sequential logic** (counters, multiplier, matrix mult)

---

## 📊 Summary Table

| Module           | Type       | Key Feature          |
| ---------------- | ---------- | -------------------- |
| demux1x8         | Sequential | One-hot output       |
| mux8x1           | Sequential | Selects 1 of 8       |
| decoder2x4       | Sequential | Binary → one-hot     |
| encoder4x2       | Sequential | One-hot → binary     |
| matrix2x2_mult   | Hybrid     | Uses 2D arrays       |
| multiplier       | Sequential | 16×16 multiply       |
| counter_overflow | Sequential | 33-bit with overflow |
| updowncounter    | Sequential | Dual counter         |
| Testbenches      | Simulation | Stimulus + waveform  |

