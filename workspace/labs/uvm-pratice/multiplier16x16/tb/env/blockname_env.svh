class blockname_env extends uvm_env;
  `uvm_component_utils(blockname_env)

  // has a
  ifa_agent agent_a;
  ifb_agent agent_b;

  // config
  blockname_env_config cfg;

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  
    // config
    cfg = blockname_env_config::type_id::create("cfg");
   // cfg.ifa_is_active = UVM_PASSIVE; //setando se é ativo ou passivo
    cfg.ifb_is_active = UVM_ACTIVE;

    // pass configuration to agents (set ou get) set -> top interface 
    uvm_config_db #(uvm_active_passive_enum)::set(
      this, // o pointer esta classse
      "agent_a", // classe destino
      "is_active", // qual atributo
      cfg.ifa_is_active // qual o valor ela recebe -> valor enviado
    );

    uvm_config_db #(uvm_active_passive_enum)::set(
      this,
      "agent_b",
      "is_active",
      cfg.ifb_is_active
    );

    // create agents
    agent_a = ifa_agent::type_id::create("agent_a", this);
    agent_b = ifb_agent::type_id::create("agent_b", this);  
  endfunction: build_phase
  
endclass