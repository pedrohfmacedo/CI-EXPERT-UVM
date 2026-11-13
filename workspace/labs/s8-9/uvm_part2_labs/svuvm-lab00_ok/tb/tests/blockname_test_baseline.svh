class blockname_test_baseline extends uvm_test;

  // factory
  // why is factory necessary?
  // allows that UVM create, find and change the class dynamically... remember: this is a POO program
  `uvm_component_utils(blockname_test_baseline)

  // why this?
  // because super will call the extended class and it has name and parent in its new()
  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  // exercise: override functions
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  
    repeat(10)
      `uvm_info(get_name(), "[dbg] i'v overrided the build_phase method of uvm_test", UVM_NONE)

  endfunction: build_phase
  
    // exercise: override functions
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  
    repeat(10)
      `uvm_info(get_name(), "[dbg] i'v overrided the connect_phase method of uvm_test", UVM_NONE)

  endfunction: connect_phase

endclass