class blockname_test_baseline extends uvm_test;
  `uvm_component_utils(blockname_test_baseline)

  // has a
  blockname_enviroment env;

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = blockname_enviroment::type_id::create("env", this);
  endfunction: build_phase
  
function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction: end_of_elaboration_phase

endclass : blockname_test_baseline