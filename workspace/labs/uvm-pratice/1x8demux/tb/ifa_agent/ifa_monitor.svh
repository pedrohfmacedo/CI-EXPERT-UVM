class ifa_monitor extends uvm_monitor;

  uvm_analysis_port #(blockname_seq_item) port_a;
  `uvm_component_utils(ifa_monitor)

  function new(string name, uvm_component parent);
      super.new(name, parent);
      port_a = new("port_a", this);
  endfunction

endclass