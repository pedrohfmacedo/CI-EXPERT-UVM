class blockname_test_baseline extends uvm_test;
  `uvm_component_utils(blockname_test_baseline)

  // has a
  producer p;
  consumer c;

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    p = producer::type_id::create("p", this);
    c = consumer::type_id::create("c", this);    
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    p.prod_tlm_port.connect(c.consumer_port_imp);
  endfunction: connect_phase
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();    
  endfunction: end_of_elaboration_phase

endclass