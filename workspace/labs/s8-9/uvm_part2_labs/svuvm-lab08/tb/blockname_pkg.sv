package blockname_pkg;
  
  // uvm
  import uvm_pkg::*;
  `include "uvm_macros.svh"

// Tem uma macro (factory) uvm_analis_decl () passe para mim o sufico
// Esse cara (funcao) vai ter outro nome 
  `uvm_analysis_imp_decl(_imp1)
  `uvm_analysis_imp_decl(_imp2)

  // transactions
  `include "blockname_seq_item.svh"

  // compoenents
  `include "comps/producer1.svh"
  `include "comps/producer2.svh"
  `include "comps/consumer.svh"
  
  // tests
  `include "tests/blockname_test_baseline.svh"
endpackage