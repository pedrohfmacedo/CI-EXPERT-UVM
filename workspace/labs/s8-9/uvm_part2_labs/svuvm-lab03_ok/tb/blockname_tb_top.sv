module blockname_tb_top();

  // uvm
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import blockname_pkg::*;

  initial begin: MAIN
    
    //PREDECESSSOR DO SEQUENCE
    repeat(10) begin
      // create
      blockname_seq_item seq_item = blockname_seq_item::type_id::create("seq_item");
      
      // randomize
      if(seq_item.randomize())
        $display("sucess randomization ITEM");

      // force something
      // ..
      // seq_item.addr = 8'hAA;
       seq_item.op = 1'b1;

      // debug
      seq_item.print();
    end
  end: MAIN
endmodule

// force something
// seq_item.randomize() with {
//   addr == 4'hA;
//   op   == 1;
// };
