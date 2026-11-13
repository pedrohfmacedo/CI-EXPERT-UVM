class Sequencer_A extends uvm_sequencer;

    `uvm_component_utils(Sequencer_A)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction
    
endclass: Sequencer_A


