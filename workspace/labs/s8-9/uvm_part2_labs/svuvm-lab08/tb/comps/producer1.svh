class producer1 extends uvm_component;

// has-a 
uvm_analysis_port #(blockname_seq_item) ap1;

`uvm_component_utils (producer1)

//has-a
// blockname_seq_item seq_item;

function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase (uvm_phase phase);
  super.build_phase (phase);
  ap1 = new ("ap1", this);
endfunction

  task run_phase (uvm_phase phase);
    blockname_seq_item seq_item = blockname_seq_item::type_id::create("seq_item");
    phase.raise_objection(this);
    `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE);
    
    repeat(2) begin
      seq_item.randomize();
      ap1.write(seq_item);
    end
    
    phase.drop_objection(this);
    `uvm_info(get_name(), "<run_phase> finished, objection dropped ", UVM_NONE);
  endtask
  
endclass : producer1