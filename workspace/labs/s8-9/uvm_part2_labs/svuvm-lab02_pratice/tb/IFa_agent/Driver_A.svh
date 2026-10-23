class Driver_A extends uvm_driver;
    `uvm_component_utils(Driver_A)

    function new (string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass : Driver_A