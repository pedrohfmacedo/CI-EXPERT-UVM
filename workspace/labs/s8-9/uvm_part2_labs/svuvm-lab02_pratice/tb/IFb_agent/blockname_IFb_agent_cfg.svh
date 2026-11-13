class blockname_IFb_agent_cfg extends uvm_object;

 `uvm_object_utils(blockname_IFb_agent_cfg)
 
 // Por default, o agent é passivo. Aqui configuramos como passive
  uvm_active_passive_enum is_active = UVM_PASSIVE;

 function new(string name = "");
    super.new(name);
 endfunction

endclass : blockname_IFb_agent_cfg