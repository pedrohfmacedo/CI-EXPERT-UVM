class blockname_test_baseline extends uvm_test;
    // Macro to register the test with the UVM factory
    `uvm_component_utils(blockname_test_baseline)

    //has-a relationship with the environment
    blockname_env_baseline env;

    // Constructor for the test class
    function new(string name = "blockname_test_baseline", uvm_component parent=null);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Running build_phase", UVM_MEDIUM)
         env = blockname_env_baseline::type_id::create("env", this);         // Create and configure the environment
        `uvm_info(get_type_name(), "Finished build_phase", UVM_MEDIUM) 
    endfunction 

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction
endclass














// class blockname_test_baseline extends uvm_test;

//     `uvm_component_utils(blockname_test_baseline)

//     function new(string name = "blockname_test_baseline", uvm_component parent=null);
//         super.new(name, parent);
//     endfunction 


// function void build_phase(uvm_phase phase);
//     super.build_phase(phase);
//     `uvm_info(get_type_name(), "Running build_phase", UVM_MEDIUM)
//     // Adicione aqui a criação de componentes e configuração do ambiente de teste
// endfunction

// task reset_phase(uvm_phase phase);
//     phase.raise_objection(this); // Levanta a objeção para que a simulação não termine antes do fim da fase
//     `uvm_info(get_type_name(), "Running reset_phase", UVM_MEDIUM)
//     #20ns
//     phase.drop_objection(this); // Remove a objeção para que a simulação possa continuar após o fim da fase
//     `uvm_info(get_type_name(), "Finished reset_phase", UVM_MEDIUM)
// endtask

// task pre_reset_phase(uvm_phase phase);
//     phase.raise_objection(this); // Levanta a objeção para que a simulação não termine antes do fim da fase
//     `uvm_info(get_type_name(), "Running pre_reset_phase", UVM_MEDIUM)

//     phase.drop_objection(this); // Remove a objeção para que a simulação possa continuar após o fim da fase
//     `uvm_info(get_type_name(), "Finished pre_reset_phase", UVM_MEDIUM)
// endtask


// endclass

//Criação do objeto de teste baseline sem passar pela factory, usando apenas custom way PÓO program
// class blockname_test_baseline extends uvm_test;

//
//     function new(string name = "blockname_test_baseline", uvm_component parent=null);
//      (nive da classe de cima *uvm_test)   super.new(name, parent);
//     endfunction 

// endclass