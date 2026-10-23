class producer extends uvm_component;
  // has a
  uvm_blocking_put_port #(blockname_seq_item) prod_tlm_port;

  `uvm_component_utils(producer)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    prod_tlm_port = new ("prod_tlm_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    blockname_seq_item seq_item;

    phase.raise_objection(this);
    `uvm_info(get_name(), "PRODUCER started, objection raised.", UVM_NONE)
  
      repeat(10) begin
        // create
        seq_item = blockname_seq_item::type_id::create("seq_item");
        
        // randomize or whatever
        seq_item.randomize();

        // send it
        begin_tr(seq_item, "PUT_TRANSACTION");
          prod_tlm_port.put(seq_item);
        end_tr(seq_item);

        #100ms;
      end
  
    phase.drop_objection(this);
    `uvm_info(get_name(), "PRODUCER finished, objection dropped.", UVM_NONE)
  endtask: run_phase
  
endclass