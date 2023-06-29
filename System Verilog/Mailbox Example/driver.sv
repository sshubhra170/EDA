class driver;
  packet pkt;
  mailbox mbx;
  
  function new (mailbox mbx);
    this.mbx=mbx;
  endfunction : new
  
  task start;
    repeat(10) begin
      mbx.get(pkt);
      //$display("Driver  ::  PACKET RECIEVED");
      $display("Driver1  ::  a=%0d, b=%0d\n",pkt.a,pkt.b);
    end
  endtask : start
endclass: driver