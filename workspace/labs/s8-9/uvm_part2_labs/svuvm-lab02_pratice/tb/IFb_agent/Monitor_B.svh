class Monitor_B extends uvm_monitor;

    `uvm_component_utils(Monitor_B)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction
    
endclass: Monitor_B

