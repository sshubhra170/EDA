// Code your testbench here
// or browse Examples
`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "driver2.sv"

module tb;
  generator gen;
  driver    drive;
  driver2 drive2;
  
  mailbox mbx;
  
  initial begin
    mbx = new(); 
    
    gen = new(mbx); 
    drive = new(mbx); 
    drive2 =new(mbx);
    $display("------------------------------------------");
    fork
      gen.start(); 
      drive2.start();
      drive.start();
    join
    $display("------------------------------------------");
  end
endmodule