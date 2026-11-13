class blockname_env_baseline extends uvm_env;

    `uvm_component_utils(blockname_env_baseline)

    blockname_agent_baseline agent;

    function new(string name = "blockname_env_baseline", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db #(uvm_active_passive_enum)::set( this, "agent", "is_active", UVM_ACTIVE );
        agent = blockname_agent_baseline::type_id::create("agent", this);
    endfunction 
    
endclass