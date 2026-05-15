# calc4 — Módulo de Calculadora em SystemVerilog

## Descrição

O módulo `calc4` realiza operações aritméticas básicas entre dois operandos de 8 bits.  
A operação é definida por um sinal de controle (`op`) de 2 bits.

## Interface

### Entradas
- `a` (8 bits): primeiro operando  
- `b` (8 bits): segundo operando  
- `op` (2 bits): seletor da operação  

### Saída
- `result` (8 bits): resultado da operação

## Operações

| op   | Operação             |
|------|---------------------|
| 00   | Soma (`a + b`)      |
| 01   | Subtração (`a - b`) |
| 10   | Multiplicação       |
| 11   | Divisão             |

## Funcionamento

O módulo utiliza um bloco `always_comb`.  
O resultado é definido por um `case` com base no valor de `op`.  
Valores inválidos resultam em saída igual a zero.

## Observações

- Não há tratamento para divisão por zero.  
- Pode ocorrer overflow devido ao limite de 8 bits.
