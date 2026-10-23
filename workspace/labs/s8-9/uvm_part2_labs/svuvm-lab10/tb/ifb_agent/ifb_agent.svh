class ifb_agent extends uvm_agent;
  `uvm_component_utils(ifb_agent)

  // has:
  ifb_sequencer sqr;
  ifb_driver    drv;
  ifb_monitor   mon;

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // always mon
    mon = ifb_monitor::type_id::create("mon", this);
    
    // if active adds:
    if(get_is_active == UVM_ACTIVE) begin
      sqr = ifb_sequencer::type_id::create("sqr", this); 
      drv = ifb_driver::type_id::create("drv", this);  
    end
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);                 // connect the monitor to the agent's analysis port
    if(get_is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export); // connect the driver to the sequencer
    end
  endfunction: connect_phase
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info(get_name(), $sformatf("THIS AGENT IS A %s", get_is_active.name()), UVM_NONE)
  endfunction: end_of_elaboration_phase

endclass