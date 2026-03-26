`timescale 1ns/1ps

module calc4_tb;

    // Sinais
    logic [7:0] a;
    logic [7:0] b;
    logic [1:0] op;
    logic [7:0] result;

    // Variável esperada (modelo de referência)
    logic [7:0] expected;

    // DUT
    calc4 dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    // Função de referência (golden model)
    function automatic [7:0] calc_ref (
        input logic [7:0] a,
        input logic [7:0] b,
        input logic [1:0] op
    );
        case (op)
            2'b00: calc_ref = a + b;
            2'b01: calc_ref = a - b;
            2'b10: calc_ref = a * b;
            2'b11: calc_ref = (b == 0) ? 8'd0 : a / b;
            default: calc_ref = 8'd0;
        endcase
    endfunction

    initial begin
        $display("Iniciando testes randomizados...");

        // Loop de testes
        for (int i = 0; i < 50; i++) begin

            // Randomização
            a  = $urandom_range(0, 255);
            b  = $urandom_range(0, 255);
            op = $urandom_range(0, 3);

            #1; // pequena espera

            // Calcula esperado
            expected = calc_ref(a, b, op);

            // Tratamento especial: divisão por zero
            if (op == 2'b11 && b == 0) begin
                $display("DIV BY ZERO detectado: a=%0d b=%0d -> result=%0d", a, b, result);
            end
            else begin
                // Verificação automática
                if (result !== expected) begin
                    $error("ERRO: a=%0d b=%0d op=%02b | esperado=%0d obtido=%0d",
                            a, b, op, expected, result);
                end
                else begin
                    $display("OK: a=%0d b=%0d op=%02b -> result=%0d",
                             a, b, op, result);
                end
            end
        end

        $display("Testes finalizados.");
        $finish;
    end

endmodule
initial begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0, calc4_tb_random);
end
