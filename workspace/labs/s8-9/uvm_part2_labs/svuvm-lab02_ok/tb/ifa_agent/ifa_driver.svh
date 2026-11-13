class ifa_driver extends uvm_driver;
  `uvm_component_utils(ifa_driver)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

endclass