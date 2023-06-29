`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  
  generator g0;
  driver d0;
  monitor m0;
  scoreboard s0;
  
  mailbox mbx;
  mailbox smbx;
  
  virtual intf add;
  
  function new(virtual intf add);
    this.add=add;
 
    mbx=new();
    smbx=new();
  
    g0=new(mbx);
    d0=new(add,mbx);
    m0=new(add,smbx);
    s0=new(smbx);
  endfunction : new
  
  task pre_test();
    d0.reset();
  endtask: pre_test
  
  task test();
    fork
      g0.run();
      d0.run();
      m0.run();
      s0.run();
    join_any
  endtask
  
  task run();
    pre_test();
    test();
    $finish;
  endtask : run
  
endclass: environment