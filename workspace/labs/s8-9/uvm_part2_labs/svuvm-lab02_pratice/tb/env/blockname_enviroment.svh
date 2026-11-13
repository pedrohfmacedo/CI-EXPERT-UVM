class blockname_enviroment extends uvm_env;
  `uvm_component_utils(blockname_enviroment)

  // has a
  IFa_agent agent_a;
  IFb_agent agent_b;
  blockname_scoreboard scb;
  blockname_subscriber sub;
  blockname_env_cfg cfg;

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg = blockname_env_cfg::type_id::create("cfg", this);
    
    // Passar as configs dos agents via config_db
    uvm_config_db #(blockname_IFa_agent_cfg)::set(this, "IFa_agent", "cfg", cfg.cfg_agent_a);
    uvm_config_db #(blockname_IFb_agent_cfg)::set(this, "IFb_agent", "cfg", cfg.cfg_agent_b);
    
    agent_a = IFa_agent::type_id::create("IFa_agent", this);
    agent_b = IFb_agent::type_id::create("IFb_agent", this);
    scb = blockname_scoreboard::type_id::create("scb", this);
    sub = blockname_subscriber::type_id::create("sub", this);
  endfunction: build_phase

endclass : blockname_enviroment