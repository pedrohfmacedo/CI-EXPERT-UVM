package blockname_pkg;
  
  // uvm
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // transactions
  `include "blockname_seq_item.svh"

  // compoenents
  `include "comps/producer.svh"
  `include "comps/consumer1.svh"
  `include "comps/consumer2.svh"
  // `include "comps/consumer.svh"
  
  // tests
  `include "tests/blockname_test_baseline.svh"
endpackage