class producer2 extends uvm_component;
// has-a 
// uvm_blocking_put_port #(blockname_seq_item) prod_tlm_port;
// uvm_blocking_get_imp #(blockname_seq_item, producer) producer_port_imp;
uvm_analysis_port #(blockname_seq_item) ap2;

`uvm_component_utils (producer2)

//has-a
// blockname_seq_item seq_item;

function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase (uvm_phase phase);
  super.build_phase (phase);
  ap2 = new ("ap2", this);
endfunction

// task run_phase (uvm_phase phase);
//   super.run_phase (phase);
//     phase.raise_objection(this);
//     `uvm_info(get_name(), "PRODUCER, starte, objection raise", UVM_NONE);
//       repeat(2) begin
//         seq_item = blockname_seq_item::type_id::create("seq_item"); //create item
//         seq_item.randomize(); //
//         // send it
//         begin_tr(seq_item, "PUT_TRANSACTION");
//           producer_port_imp.put(seq_item); //method put in port
//         end_tr(seq_item);
//       end
//     phase.drop_objection(this);
//     `uvm_info(get_name(), "PRODUCER, finished objection dropped", UVM_NONE);
// endtask

  // task get (output blockname_seq_item seq_item);
  //   // do nothing...
  //   // Criando a sequência
  //   seq_item = blockname_seq_item::type_id::create("seq_item", this); //create item
  //   //seq_item .print();

  //   // Randomizando os valores do item
  //   seq_item.randomize(); // randomiza os valores do item
  //   `uvm_info(get_name(),
  //         $sformatf("PRODUCER, got item:\n%s", seq_item.sprint()),
  //         UVM_NONE)

  //   // Atribuindo o item criado ao parâmetro de saída
  //   seq_item = seq_item; // atribui o item criado ao parâmetro de saída
  // endtask

  task run_phase (uvm_phase phase);
    blockname_seq_item seq_item = blockname_seq_item::type_id::create("seq_item");
    phase.raise_objection(this);
    `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE);
    
    repeat(2) begin
      seq_item.randomize();
      ap2.write(seq_item);
    end

    phase.drop_objection(this);
    `uvm_info(get_name(), "<run_phase> finished, objection dropped ", UVM_NONE);
  endtask
  
  // function void write(blockname_seq_item seq_item);
  //   // do nothing...
  //   `uvm_info(get_name(),
  //         $sformatf("PRODUCER, got item:\n%s", seq_item.sprint()),
  //         UVM_NONE)
  // endfunction
endclass : producer2