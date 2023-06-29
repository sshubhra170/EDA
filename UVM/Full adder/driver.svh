class adder_driver extends uvm_driver #(adder_seq_item);
   virtual fa_intf add;
   
   `uvm_component_utils(adder_driver)
   
    //constructor
  function new(string name ="adder_driver", uvm_component parent=null);
      super.new(name,parent);
   endfunction : new
   
   // build_phase
  function void build_phase(uvm_phase phase);

	  //config_db stuff
    if(!uvm_config_db #(virtual fa_intf)::get(null, "*", "add", add))
      `uvm_fatal(get_type_name()," interface getting in driver");
   endfunction : build_phase
   
   //run_phase
   task run_phase(uvm_phase phase);
     forever begin
       seq_item_port.get_next_item(req);
       #1;
       add.a <= req.a;
	
       add.b <= req.b;
    
       add.c <= req.c;
       seq_item_port.item_done();
     end
     #500;
   endtask : run_phase
   
//    virtual task drive();
//      req.print();
	
// 	 $display("%0t : DRIVER :: A=%0d B=%0d C=%0d",$time,req.a,req.b,req.c);
     
//    endtask : drive
endclass : adder_driver