class consumer extends uvm_component;

//has-a
    uvm_analysis_imp_imp1 #(blockname_seq_item, consumer) imp1; // consumidor tem porta mas aqui é ele que pede.
    uvm_analysis_imp_imp2 #(blockname_seq_item, consumer) imp2; // consumidor tem porta mas aqui é ele que pede.
    
  `uvm_component_utils (consumer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    imp1 = new ("imp1", this);
    imp2 = new ("imp2", this);
  endfunction

virtual function void write_imp1(blockname_seq_item t);
  `uvm_info(get_name(), "RECEIVED IN CONSUMER1", UVM_NONE)
endfunction

virtual function void write_imp2 (blockname_seq_item t);
  `uvm_info(get_name(), "RECEIVED IN CONSUMER2", UVM_NONE)
endfunction

endclass : consumer
