module tb;
  reg[3:0]a;
  reg[3:0]b;
  reg[3:0]c;
  reg[3:0]d;
  reg[1:0]sel;
  wire[3:0]out;
  integer i;
  mux mux0( .a(a),.b(b),.c(c),.d(d),.sel(sel),.out(out));
  initial begin
    $monitor("[%0t] sel=0x%0h a=0x%0h b=0x%0h c=0x%0h d=0x%0h out=0x%0h", $time,sel,a,b,c,d,out);
    sel<=0;
    a<= $random;
    b<= $random;
    c<= $random;
    d<= $random;
    
    for(i=1;i<4;i=i+1) begin
      #5 sel<=1;
    end
    #5 $finish;
  end
endmodule
