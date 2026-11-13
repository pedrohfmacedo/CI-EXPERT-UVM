class ifa_monitor extends uvm_monitor;
  `uvm_component_utils(ifa_monitor)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

endclass