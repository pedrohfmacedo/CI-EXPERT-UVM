class seq extends uvm_sequence #(blockname_seq_item);
  `uvm_object_utils(seq)

    function new(string name = "seq");
        super.new(name);
    endfunction: new

    task body();
        blockname_seq_item seq_item;
        `uvm_info(get_type_name(), $sformatf("STARTING SEQUENCE (1) %s", get_full_name()), UVM_MEDIUM)
        repeat (2) begin       
            seq_item = blockname_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            assert(seq_item.randomize()); // seq_item.randomize() with { req inside {[0:255]}; }; // seq_item.randomize() with { req inside {[0:255]}; };
            seq_item.print();
            finish_item(seq_item);
            end
        `uvm_info(get_type_name(), $sformatf("ENDING SEQUENCE (1)%s", get_full_name()), UVM_MEDIUM)
        repeat (2) begin       
            seq_item = blockname_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.data = 8'hAA;
            seq_item.print();
            finish_item(seq_item);
            end
        repeat (2) begin       
            seq_item = blockname_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.addr = 8'h55;
            seq_item.print();
            finish_item(seq_item);
            end
        repeat (2) begin       
            seq_item = blockname_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.op = 1;
            seq_item.print();
            finish_item(seq_item);
            end
    
    endtask: body



    // function void do_print(uvm_printer printer);
    //     super.do_print(printer);
    //     printer.print_field_int("req", seq_item.req, $bits(seq_item.req), UVM_HEX);
    // endfunction: do_print
endclass: seq