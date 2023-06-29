// Code your testbench here
// or browse Examples
`include "driver.sv"
`include "generator.sv"
`include "monitor.sv"
`include "packet.sv"
`include "interface.sv"

module tb;
  bit rst;
  
  generator gen;
  driver    drive;
  monitor   mon;
  intf add(rst);
  mailbox mbx;
  
  rst=1;
  #5 rst=0;
  
  fulladder uut(.a(add.a),
                .b(add.b),
                .c(add.c),
                .sum(add.sum),
                .carry(add.carry),
                .rst(add.rst));
  
  initial begin
    
    mbx = new(); 
    gen = new(mbx); 
    drive = new(mbx); 
    mon = new();
    
    gen.add =add;
    mon.add=add;
    drive.add=drive;
    
    drive.mbx= mbx;
    gen.mbx=mbx;
    
    $display("------------------------------------------");
    fork
      gen.start(); 
      drive.start();
      mon.run();
    join
    $display("------------------------------------------");
  end
endmodule 