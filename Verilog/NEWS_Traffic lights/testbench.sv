module testbench;
  wire[1:0] NS,EW;
  reg x;
  reg clk,clear;
  trafficlights tc(.NS(NS),.EW(EW),.x(x),.clk(clk),.clear(clear));
  initial begin
    $monitor($time,"  NS=%b EW=%b x=%b",NS,EW,x);
    $dumpvars;
    $dumpfile("testbench.vcd");
  end
  initial begin
    clk=`FALSE;
    forever #1 clk=~clk;
  end
  initial begin
    clear=`TRUE;
    repeat(5) @(negedge clk);
    clear=`FALSE;
  end
  initial begin
    x=`FALSE;
    #10
    x=`TRUE;
    #500 $finish;
  end
endmodule