class generator;
  rand packet item;
  mailbox mbx;
  
  function new (mailbox mbx);
    this.mbx=mbx;
  endfunction : new
  
  task start;
    repeat(10) begin
      item =new();
      item.randomize();
      mbx.put(item);
    end
  endtask: start
  
endclass : generator
      
      
  