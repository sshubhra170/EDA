class adder_monitor extends uvm_monitor;
  `uvm_component_utils(adder_monitor)
  
  virtual fa_intf add;
  adder_seq_item trans_collected;
   
  uvm_analysis_port #(adder_seq_item) item_collected_port;
   
   
   
    //constructor
  function new(string name = "adder_monitor" , uvm_component parent=null);
      super.new(name,parent);
	  trans_collected = new();
	  item_collected_port = new("item_collected_port",this);
   endfunction : new
   
   // build_phase
  function void build_phase(uvm_phase phase);
     
	  //config_db stuff
    if(!uvm_config_db #(virtual fa_intf)::get(null, "*", "add", add))
      `uvm_fatal(get_type_name(),"interface is getting in monitor");
    
  endfunction : build_phase
   
   //run_phase
        task run_phase(uvm_phase phase);
    
    //forever begin
    #4
    repeat(10) begin
      #1
      //@(intf.mon)
      //@(intf)
      //@(intf.MON)
      $display("-----------------------------------------------");
      $display("-----------------------------------------------");
      $display("-----------------------------------------------");
      trans_collected.a = add.a;
      $display("%0t   Monitor_interface  a = %0d",$time,add.a);
      	trans_collected.b = add.b;
      $display("%0t,  Monitor_interface  b = %0d",$time,add.b);
      trans_collected.c = add.c;
      $display("%0t,  Monitor_interface  cin = %0d",$time,add.c);
      	trans_collected.sum = add.sum;
      $display("%0t   Monitor_interface  sum = %0d",$time,add.sum);
      	trans_collected.carry = add.carry;
      $display("%0t,  Monitor_interface  carry = %0d",$time,add.carry);
      
      item_collected_port.write(trans_collected);
    end
  endtask
   
endclass : adder_monitor