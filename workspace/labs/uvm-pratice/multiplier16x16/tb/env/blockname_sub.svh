class blockname_sub extends uvm_subscriber #(int);
  `uvm_component_utils(blockname_sub)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void write(int t);
    // nothing
  endfunction
endclass