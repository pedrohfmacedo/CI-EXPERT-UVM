class ifb_driver extends uvm_driver;
  `uvm_component_utils(ifb_driver)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

endclass