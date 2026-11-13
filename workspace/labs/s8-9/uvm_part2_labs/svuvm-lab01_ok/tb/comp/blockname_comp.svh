class blockname_comp extends uvm_component;
  `uvm_component_utils(blockname_comp)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "COMPONENT started, objection raised.", UVM_NONE)
    phase.drop_objection(this);
    `uvm_info(get_name(), "COMPONENT finished, objection dropped.", UVM_NONE)
  endtask: reset_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "COMPONENT started, objection raised.", UVM_NONE)
    phase.drop_objection(this);
    `uvm_info(get_name(), "COMPONENT finished, objection dropped.", UVM_NONE)
  endtask: run_phase
endclass