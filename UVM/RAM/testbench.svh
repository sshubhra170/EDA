`include "uvm_macros.svh"
module full_adder_top();
    
  import uvm_pkg::*;
  `include "interface.svh"
  `include "seq_item.svh"
  `include "sequence.svh"
  `include "sequencer.svh"
  `include "driver.svh"
  `include "monitor.svh"
  `include "agent.svh"
  `include "environment.svh"
  `include "test.svh"  
  
  ram_if i();  
  
  ram DUT (.clk(i.clk),
           .rst(i.rst),
		   .wr_enb(i.wr_enb),
		   .wr_addr(i.wr_addr),
		   .wr_data(i.wr_data),
		   .rd_enb(i.rd_enb),
		   .rd_addr(i.rd_addr),
		   .rd_data(i.rd_data)); 

  
  initial begin
    //set method
    uvm_config_db #(virtual ram_if)::set(uvm_root::get(), "*", "i", i);
  end
  
  initial begin
    //uvm_info (get_type_name(), $sformatf ("IN TOP"),UVM_LOW);
    $display("This is top before run_test");
    run_test("ram_test");  
    $display("This is top after run_test"); 
  end
  
   initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule