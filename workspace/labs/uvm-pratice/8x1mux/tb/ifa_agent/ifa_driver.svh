class ifa_driver extends uvm_driver #(blockname_seq_item);
  `uvm_component_utils(ifa_driver)

  function new(string name, uvm_component parent);
      super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    blockname_seq_item req;

    forever begin
      seq_item_port.get_next_item(req);

      // Dirija req ao DUT aqui, quando a interface virtual estiver disponível.
      `uvm_info(get_type_name(),
                $sformatf("Received item"),
                UVM_MEDIUM)

      seq_item_port.item_done();
    end
  endtask : run_phase

endclass
