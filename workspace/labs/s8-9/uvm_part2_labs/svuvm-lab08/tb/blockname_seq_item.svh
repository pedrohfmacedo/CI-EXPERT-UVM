class blockname_seq_item extends uvm_sequence_item;

  // what does my driver needs to decodify to low level?
  // suppose: the block is just a register-based calculator
  rand bit [7:0] data;
  rand bit [3:0] addr; // allows 16 addresses
  rand bit [1:0]   op; // allows  4 operations

  // constraint addr to 0-10
   constraint addr_c {
    addr inside {[0:10]};
  }

  // factory + utility macros
  `uvm_object_utils_begin(blockname_seq_item)
    `uvm_field_int(addr,UVM_HEX)
    `uvm_field_int(data,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(op,  UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  function new(string name = "blockname_seq_item");
    super.new(name);
  endfunction: new
  
endclass: blockname_seq_item

