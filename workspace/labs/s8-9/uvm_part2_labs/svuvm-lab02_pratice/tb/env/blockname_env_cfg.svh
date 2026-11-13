class blockname_env_cfg extends uvm_object;

 `uvm_object_utils(blockname_env_cfg)
 
  blockname_IFa_agent_cfg cfg_agent_a;
  blockname_IFb_agent_cfg cfg_agent_b;
 // Por default, o agent é passivo. Aqui configuramos como passive
 //   uvm_active_passive_enum Ifa_is_active = UVM_PASSIVE;
 //   uvm_active_passive_enum Ifb_is_active = UVM_PASSIVE;        


 function new(string name = "");
    super.new(name);
    cfg_agent_a = blockname_IFa_agent_cfg::type_id::create("cfg_agent_a");
    cfg_agent_b = blockname_IFb_agent_cfg::type_id::create("cfg_agent_b");
 endfunction

endclass : blockname_env_cfg