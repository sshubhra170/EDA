`include "uvm_macros.svh"
module full_adder_top();
    
  import uvm_pkg::*;
  `include "interface.sv"
  `include "seq_item.sv"
  `include "sequence.sv"
  `include "sequencer.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "agent.sv"
  `include "environment.sv"
  `include "test.sv"  
  
  fa_intf add();  
  
  full_adder DUT (.a(add.a),.b(add.b),.c(add.c),.carry(add.carry),.sum(add.sum)); 
  
  initial begin
    
    //set method
    uvm_config_db #(virtual fa_intf)::set(null, "*", "add", add);
  end
  
  initial begin
    //uvm_info (get_type_name(), $sformatf ("IN TOP"),UVM_LOW);
    $display("This is top before run_test");
    run_test("adder_test");  
    $display("This is top after run_test"); 
  end
  
   initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule