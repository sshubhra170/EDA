class driver;
  virtual intf add;
  mailbox mbx;
  
  
  function new (virtual intf add, mailbox mbx);
    this.add=add;
    this.mbx=mbx;
  endfunction : new
  
  task start;
    //$display("T=%0t [Driver] start",$time);
    repeat(10) begin
      packet item;
      mbx.get(item);
      add.rst <= item.rst;
      add.a <= item.a;
      add.b <= item.b;
      add.c <= item.c;
    end
  endtask : start
endclass: driver