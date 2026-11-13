module blockname_tb_top();

  // uvm
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // adds own classes
  import blockname_pkg::*;

  initial begin: MAIN
    // create a component in the factory
    blockname_comp bc = blockname_comp::type_id::create("bc", null);

    // It starts the UVM execution/phasing mechanism.
    // If a test is specified, it is created first;
    // otherwise, existing UVM components are phased.
    run_test();
  end: MAIN

endmodule