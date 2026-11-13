class IFa_agent extends uvm_agent;

    `uvm_component_utils(IFa_agent)

    blockname_IFa_agent_cfg cfg;
    Driver_A driver_a;
    Monitor_A monitor_a;
    Sequencer_A sequencer_a;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(blockname_IFa_agent_cfg)::get(this, "", "cfg", cfg))
      `uvm_error("IFa_agent", "Não conseguiu pegar config")
    
    monitor_a = Monitor_A::type_id::create("monitor_a", this);
    
    if (cfg.is_active == UVM_ACTIVE) begin
      sequencer_a = Sequencer_A::type_id::create("sequencer_a", this);
      driver_a = Driver_A::type_id::create("driver_a", this);
    end
  endfunction

function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  `uvm_info(get_name(), $sformatf("THIS AGENT IS A %s", get_is_active.name()), UVM_NONE);
endfunction: end_of_elaboration_phase
    
endclass : IFa_agent