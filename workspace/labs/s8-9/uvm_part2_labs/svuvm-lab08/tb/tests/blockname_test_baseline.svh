class blockname_test_baseline extends uvm_test;
  `uvm_component_utils(blockname_test_baseline)

  function new (string name, uvm_component parent);
    super.new (name, parent);
  endfunction

  // has-a 
  producer1 prod1; // hanlde == ponter, null pointer
  producer2 prod2;
  consumer cons;

  //conntruct -build aloque na memoria crie os bojetos
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cons = consumer::type_id::create("cons", this);
    prod1 = producer1::type_id::create("prod1", this);
    prod2 = producer2::type_id::create("prod2", this);
  endfunction

  //connect
  // “Tudo que o produtor enviar pela sua porta prod_tlm_port será entregue ao consumidor, que implementa consumer_port_imp
  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    //produtor tem uma porta e essa porta tem uma conexao, que é o timpletnao (nao implementa o put)
    //prod.prod_tlm_port.connect(cons.consumer_port_imp);
    //cons.consumer_tlm_port.connect(prod.producer_port_imp);
    prod1.ap1.connect(cons.imp1);
    prod2.ap2.connect(cons.imp2);
    // cons.imp1.connect(prod1.ap);
    // cons.imp2.connect(prod2.ap);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass : blockname_test_baseline
