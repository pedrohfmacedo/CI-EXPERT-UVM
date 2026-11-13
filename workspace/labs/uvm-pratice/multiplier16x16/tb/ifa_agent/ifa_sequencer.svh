class ifa_sequencer extends uvm_sequencer #(blockname_seq_item);
  `uvm_component_utils(ifa_sequencer)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

endclass
