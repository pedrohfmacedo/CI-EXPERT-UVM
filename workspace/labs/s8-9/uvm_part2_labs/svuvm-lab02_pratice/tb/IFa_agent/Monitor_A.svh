class Monitor_A extends uvm_monitor;

    `uvm_component_utils(Monitor_A)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction
endclass: Monitor_A

