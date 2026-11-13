class ifb_monitor extends uvm_monitor;

  uvm_analysis_port #(blockname_seq_item) port_b;
  `uvm_component_utils(ifb_monitor)

  function new(string name, uvm_component parent);
      super.new(name, parent);
      port_b = new("port_b", this);
  endfunction

endclass