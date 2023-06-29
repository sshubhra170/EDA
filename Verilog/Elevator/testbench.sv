// Code your testbench here
// or browse Example
module test;
  logic clk, rst, P0, P1, B0, B1, S0, S1, b_MD, b_MS, s_MD, s_MS;
  reg [4:1] Y;
  b_elevator b_dut (clk, rst, P0, P1, B0, B1, S0, S1, b_MD, b_MS);
  initial 
  begin
    clk = 1;
    forever #1 clk = !clk;
  end
    
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end

  initial begin
	rst = 1; 
    P0=0; P1=0; B0=0; B1=0; S0=1; S1=0;
    #5 rst = 0; 
    #10 B1=1; 
    #10 S0=0; B1=0;
    #30 S1=1; 
    #10 B0=1; 
    #10 S1=0; B0=0;
    #30 S0=1; 
    #10 $finish;
  end
endmodule