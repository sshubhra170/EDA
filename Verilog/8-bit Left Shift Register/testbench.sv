module test;
  reg C,SI,CLR;
  wire SO;
  shift uut(.C(C),.CLR(CLR),.SI(SI),.SO(SO));
  always #10 C=~C;
  initial begin
    C<=0;
    SI<=0;
    CLR<=0;
  end
  initial begin
    $monitor("CLEAR = %0b  SERIAL IN = %b  SERIAL OUT = %b",CLR,SI,SO);
    $dumpvars;
    $dumpfile("test.vcd");
  end
  initial begin
    repeat(5) @(posedge C)
    	CLR<=0;
    #20 CLR<=1;
    
    repeat(5) @(posedge C)
      SI=~SI;
    #500 $finish;
  end
endmodule