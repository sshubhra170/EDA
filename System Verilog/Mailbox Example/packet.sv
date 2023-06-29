class packet;
  rand bit [7:0] a;
  rand bit [7:0] b;
  
  //constraint for_a{a<=20;}
  //constraint for_a{a inside{2,5,[10:17]};}
  //constraint for_b{(a<=15) -> (b<8);}
  constraint for_b{ if(a<=15) b<8;
                   else b>8;}
  constraint for_a{ a dist{7:/8, 5:=4, [3:12]:/3};}
  
  
  function void post_randomize();
    //$display("Packet::Packet Generated");
    //$display("Packet::Addr=%0d,Data=%0d\n",a,b);
  endfunction
endclass