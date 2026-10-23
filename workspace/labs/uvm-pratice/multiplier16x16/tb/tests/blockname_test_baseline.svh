class blockname_test_baseline extends uvm_test;
  `uvm_component_utils(blockname_test_baseline)

  // has a
  blockname_env env;
  seq seqa;

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = blockname_env::type_id::create("env", this);
  endfunction: build_phase
  
function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction: end_of_elaboration_phase

task run_phase(uvm_phase phase);
  phase.raise_objection(this);

  begin
    `uvm_info(get_name(),
              $sformatf("STARTING TEST %s", get_full_name()),
              UVM_MEDIUM)

    seqa = seq::type_id::create("seqa");
    seqa.start(env.agent_a.sqr);
  end

  phase.drop_objection(this);
endtask : run_phase

endclass
