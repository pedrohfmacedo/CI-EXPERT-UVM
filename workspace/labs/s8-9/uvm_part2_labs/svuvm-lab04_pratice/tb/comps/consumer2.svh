class consumer2 extends uvm_component;

//has-a
//  uvm_blocking_put_imp #(blockname_seq_item, consumer) consumer_port_imp; // consumidor tem porta mas aqui é ele que pede.
//  uvm_blocking_get_port #(blockname_seq_item) consumer_tlm_port; // consumidor tem porta mas aqui é ele que pede.
    uvm_analysis_imp #(blockname_seq_item, consumer2) consumer2_imp; // consumidor tem porta mas aqui é ele que pede.
`uvm_component_utils (consumer2)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    consumer2_imp = new ("consumer2_imp",this);
  endfunction

  // task put(blockname_seq_item t);
  //   // do nothing...
  //   t.print();
  // endtask

  // task run_phase (uvm_phase phase);
  //   //super.run_phase (phase);
  //   blockname_seq_item seq_item = blockname_seq_item::type_id::create("seq_item", this); //create item
  //   //super.run_phase (phase);
  //   phase.raise_objection(this);
  //   `uvm_info(get_name(), "CONSUMER, starte, objection raise", UVM_NONE);
  //     repeat(2) begin
  //       blockname_seq_item seq_item;
  //       // get it
  //       consumer_tlm_port.get(seq_item); //method get in port
  //       `uvm_info(get_name(),
  //         $sformatf("CONSUMER, got item:\n%s", seq_item.sprint()),
  //         UVM_NONE)
  //     end
  //   phase.drop_objection(this);
  //   `uvm_info(get_name(), "CONSUMER, finished objection dropped", UVM_NONE);
  // endtask

  function void write(blockname_seq_item seq_item);
    `uvm_info(get_name(), "RECEIVED IN CONSUMER2" , UVM_NONE)
  endfunction

endclass : consumer2