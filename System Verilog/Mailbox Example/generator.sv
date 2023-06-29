class generator;
  packet pkt;
  mailbox mbx;
  
  function new (mailbox mbx);
    this.mbx=mbx;
  endfunction : new
  
  task start;
    repeat(10) begin
      #1;
      pkt =new();
      pkt.randomize();
      mbx.put(pkt);
      $display("------------------------------------------");
      $display("------------------------------------------");
      //$display("Generator::Packet Put into Mailbox");
      $display(" Gen a= %0d , b=%0d",pkt.a,pkt.b);
      
      
    end
  endtask : start
  
endclass: generator
  
  