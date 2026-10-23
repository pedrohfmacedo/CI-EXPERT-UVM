class blockname_test_baseline extends uvm_test;
  `uvm_component_utils(blockname_test_baseline)

  function new (string name, uvm_component parent);
    super.new (name, parent);
  endfunction

  // has-a 
  producer prod; // hanlde == ponter, null pointer
  // consumer cons;
  consumer1 cons1;
  consumer2 cons2;
  //conntruct -build aloque na memoria crie os bojetos
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  //  cons = consumer::type_id::create("cons", this);
    cons1 = consumer1::type_id::create("cons1", this);
    cons2 = consumer2::type_id::create("cons2", this);
    prod = producer::type_id::create("prod", this);
  endfunction

  //connect
  // “Tudo que o produtor enviar pela sua porta prod_tlm_port será entregue ao consumidor, que implementa consumer_port_imp
  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    //produtor tem uma porta e essa porta tem uma conexao, que é o timpletnao (nao implementa o put)
    //prod.prod_tlm_port.connect(cons.consumer_port_imp);
    //cons.consumer_tlm_port.connect(prod.producer_port_imp);
    prod.ap.connect(cons1.analysis_export);
    prod.ap.connect(cons2.consumer2_imp);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass : blockname_test_baseline
