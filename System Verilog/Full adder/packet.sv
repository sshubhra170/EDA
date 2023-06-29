class packet;
  
  rand bit [7:0] a;
  rand bit [7:0] b;
  rand bit [7:0] c;
       bit [7:0] sum;
       bit [1:0] carry;
  
  function void print(string tag="");
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("a=0x%0h  b=0x%0h c=0x%0h",a,b,c);
    $display("sum=0x%0h carry=0x%0h",sum,carry);
    $display("-------------------------");
  endfunction : print
  
endclass : packet
  
  
  
  
  