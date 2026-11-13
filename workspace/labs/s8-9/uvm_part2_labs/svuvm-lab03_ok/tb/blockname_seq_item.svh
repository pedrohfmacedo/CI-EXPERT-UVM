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

  // constraint addr to 3-4
  constraint datar_c {
    data inside {[0:4]};
  }

  // factory + utility macros
  `uvm_object_utils_begin(blockname_seq_item)
    `uvm_field_int(addr, UVM_HEX | UVM_NOPRINT)
    `uvm_field_int(data, UVM_BIN | UVM_NOPRINT)
    `uvm_field_int(op,   UVM_DEC | UVM_NOPRINT)
  `uvm_object_utils_end

  function new(string name = "blockname_seq_item");
    super.new(name);
  endfunction: new

  function void pre_randomize();
  	$display ("before .randomization");
  	$display ("op %d", op);
     // Se op randomizado for 1, disable o randomize do addr
    if(op == 1) begin
      $display ("disable addr random");
      addr.rand_mode(0); // desativa random do adder
      addr_c.constraint_mode(0); /// desativa o constraint acima
    end
  endfunction

  function void post_randomize();
  // Reativar o random de addr após a randomização
  if(op == 1) begin
    $display ("enable addr random");
    data.rand_mode(0);           // Reativa randomização de addr
    datar_c.constraint_mode(0);   // Reativa constraint
  end
  endfunction

//
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);

    // style 1
    // printer.print_field("addr", addr, 4, UVM_HEX);
    // printer.print_field("data", data, 8, UVM_HEX);
    // printer.print_field("op",   op,   2, UVM_DEC);

    // style 2

    printer.print_string(
      "transaction",
      $sformatf("addr=0x%0h data=0x%0h op=%0d", addr, data, op)
    );


  endfunction

endclass: blockname_seq_item
