//`timescale 1ns/1ps
module calc4_tb;

    // Sinais de teste
    logic [7:0] a;
    logic [7:0] b;
    logic [1:0] op;
    logic [7:0] result;

    // Instância do DUT
    calc4 dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    // Procedimento de teste
    initial begin
    	$display("Op: 00: + ; 01: - ;10 : * ;11: / ;");   
        $display(" a       b      op | result");
        $monitor("%0d     %0d     %02b | %0d", a, b, op, result);

        // Operações básicas
        a = 10; b = 5; op = 2'b00; #10; // soma
        a = 10; b = 5; op = 2'b01; #10; // subtração
        a = 10; b = 5; op = 2'b10; #10; // multiplicação
        a = 10; b = 5; op = 2'b11; #10; // divisão

        // Testes adicionais
        a = 20; b = 4; op = 2'b00; #10;
        a = 20; b = 4; op = 2'b01; #10;
        a = 20; b = 4; op = 2'b10; #10;
        a = 20; b = 4; op = 2'b11; #10;

        // Overflow (wrap-around)
        a = 8'd255; b = 8'd1; op = 2'b00; #10; // soma overflow
        a = 8'd50;  b = 8'd10; op = 2'b10; #10; // mult overflow

        // Divisão por zero
        a = 8'd10; b = 8'd0; op = 2'b11; #10;

        $finish;
    end
   initial begin
     $fsdbDumpfile("wave.fsdb");
     $fsdbDumpvars(0, calc4_tb);
   end


endmodule
