class ifa_agent extends uvm_agent;
  `uvm_component_utils(ifa_agent)

  // has:
  ifa_sequencer sqr;
  ifa_driver    drv;
  ifa_monitor   mon;

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // always mon
    mon = ifa_monitor::type_id::create("mon", this);
    
    // if active adds:
    if(get_is_active == UVM_ACTIVE) begin
      sqr = ifa_sequencer::type_id::create("sqr", this); 
      drv = ifa_driver::type_id::create("drv", this);  
    end
  endfunction: build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info(get_name(), $sformatf("THIS AGENT IS A %s", get_is_active.name()), UVM_NONE)
  endfunction: end_of_elaboration_phase

endclass