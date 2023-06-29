class monitor;
  virtual intf add;
  
  task run();
    $display("MONITOR");
    forever begin
      #1;
      packet pkt=new();
      pkt.rst = pkt.rst;
      pkt.a = add.a;
      pkt.b = add.b;
      pkt.c = add.c;
      pkt.sum = add.sum;
      pkt.carry = add.carry;
      pkt.print(" Monitor");
    end
  endtask:run
endclass: monitor