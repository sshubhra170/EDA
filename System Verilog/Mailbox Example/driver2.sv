class driver2;
  packet pkt;
  mailbox mbx;
  
  function new (mailbox mbx);
    this.mbx=mbx;
  endfunction : new
  
  task start;
    repeat(10) begin
      mbx.peek(pkt);
      //$display("Driver 2 ::  PACKET RECIEVED");
      $display("Driver 2 ::  a=%0d, b=%0d",pkt.a,pkt.b);
    end
  endtask : start
endclass: driver2