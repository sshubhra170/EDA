// Code your testbench here
// or browse Examples
module testbench;
  wire[1:0] highway,farm;
  reg x;
  reg clk,clear;
  trafficlights tc(highway,farm,x,clk,clear);
  initial
    $monitor($time,"  highway=%b farm=%b x=%b",highway,farm,x);
  initial begin
    clk=`FALSE;
    forever #5 clk=~clk;
  end
  initial begin
    clear=`TRUE;
    repeat(5) @(negedge clk);
    clear=`FALSE;
  end
  initial begin
    x=`FALSE;
    
    #200 x=`TRUE;
    #100 x=`FALSE;
    
    #200 x=`TRUE;
    #100 x=`FALSE;
    
    #200 x=`TRUE;
    #100 x=`FALSE;
    
    #100 $stop;
  end
endmodule