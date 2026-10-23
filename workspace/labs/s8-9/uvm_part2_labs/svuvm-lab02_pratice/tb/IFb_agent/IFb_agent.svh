class IFb_agent extends uvm_agent;

    `uvm_component_utils(IFb_agent)

    blockname_IFb_agent_cfg cfg;
    Driver_B driver_b;
    Monitor_B monitor_b;
    Sequencer_B sequencer_b;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(blockname_IFb_agent_cfg)::get(this, "", "cfg", cfg))
      `uvm_error("IFb_agent", "Não conseguiu pegar config")
    
    monitor_b = Monitor_B::type_id::create("monitor_b", this);
    
    if (cfg.is_active == UVM_ACTIVE) begin
      sequencer_b = Sequencer_B::type_id::create("sequencer_b", this);
      driver_b = Driver_B::type_id::create("driver_b", this);
    end
  endfunction

  function void end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
      `uvm_info(get_name(), $sformatf("THIS AGENT IS A %s", get_is_active.name()), UVM_NONE);
    
  endfunction : end_of_elaboration_phase
    
endclass : IFb_agent