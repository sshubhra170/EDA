class adder_sequence extends uvm_sequence#(adder_seq_item);
  `uvm_object_utils(adder_sequence)
  
  //constructor
  
  function new(string name = "adder_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(10)
      begin
        //`uvm_do(req);
        req = adder_seq_item::type_id::create("req");
        //$display("HI this is sequence");
        start_item(req);
        req.randomize();
       // req.a = 0;
       // req.b = 0;
       // req.c = 0;
       
        finish_item(req);
      end  
  endtask
endclass