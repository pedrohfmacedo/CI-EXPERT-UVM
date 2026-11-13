class blockname_env_config extends uvm_object;
  `uvm_object_utils(blockname_env_config);

  uvm_active_passive_enum ifa_is_active = UVM_PASSIVE;
  uvm_active_passive_enum ifb_is_active = UVM_PASSIVE;

  function new(string name = "");
    super.new(name);
  endfunction: new

endclass
