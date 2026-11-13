class blockname_subscriber extends uvm_subscriber #(int);

    `uvm_component_utils(blockname_subscriber)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void write (int t);
        // What thing were is here
    endfunction 

endclass : blockname_subscriber 