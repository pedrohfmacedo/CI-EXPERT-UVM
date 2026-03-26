# calc4 — Projeto SystemVerilog

## Descrição

Este projeto implementa um módulo chamado `calc4` que realiza operações aritméticas básicas com operandos de 8 bits.

Operações suportadas:

* 00: soma
* 01: subtração
* 10: multiplicação
* 11: divisão

---

## Estrutura do Projeto

```
calc4/
├── rtl/calc4.sv
├── tb/calc4_tb.sv
├── tb/calc4_tb_random.sv
├── sim/
└── Makefile
```

---

## Arquivos

### rtl/calc4.sv

Implementa o módulo principal com um `case` dentro de `always_comb`.

### tb/calc4_tb.sv

Testbench com testes fixos utilizando `$monitor`.

### tb/calc4_tb_random.sv

Testbench com testes aleatórios. Possui:

* geração de estímulos com `$urandom_range`
* modelo de referência (`calc_ref`)
* verificação automática com `$error`

---

## Simulação

Compilar:

```
make sim-vcs
```

Executar:

```
make run-vcs
```

Executar com interface gráfica:

```
make sim-gui-vcs
```

---

## Waveform

Os testbenches geram o arquivo:

```
wave.fsdb
```

Abrir manualmente:

```
verdi -ssf wave.fsdb
```

---

## Observações

Adicionar no início dos arquivos:

```
`timescale 1ns/1ps
```

Sugestão para evitar divisão por zero:

```
result = (b != 0) ? a / b : 8'd0;
```

