class consumer extends uvm_component;
  // has a
  uvm_blocking_put_imp #(blockname_seq_item, consumer) consumer_port_imp;

  `uvm_component_utils(consumer)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    consumer_port_imp = new ("consumer_port_imp", this);
  endfunction

  // try to rm... what happen?
  task put(blockname_seq_item t);
    // do nothing...
    t.print();
  endtask
endclass