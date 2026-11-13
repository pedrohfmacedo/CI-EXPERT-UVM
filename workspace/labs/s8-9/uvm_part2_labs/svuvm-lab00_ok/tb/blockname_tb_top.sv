module blockname_tb_top();

  // uvm
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  initial begin: MAIN
    repeat(70) $write("-");
    $display("\n\n[dbg] blockname_tb_top started\n");
    repeat(70) $write("-");
    $display("");

    // ...
    run_test();
  end: MAIN

endmodule