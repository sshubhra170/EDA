`include "environment.sv"
program test(intf add);
  environment e0;
  initial begin
    e0=new(add);
    e0.run();
  end
endprogram : test