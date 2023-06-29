// Code your testbench here
// or browse Examples
class test;
  int a;
  int b;
  local int c; //Encapsulation
  
  function print();
    c=a+b;
    $display("%0d + %0d = %0d",a,b,c);
  endfunction:print
  
endclass:test

class avg extends test;
  int a,b;
  int d;
  
  function seek();
    d= this.a > this.b ? this.a : this.b;
    $display("%0d",d);
  endfunction:seek

endclass: avg

module tb;
  
  initial begin
    
    test obj1; // object for parent class
    
    avg obj; //object for child class
    
    //operation on parent class object
    obj1=new;
    obj1.a=7;
    obj1.b=8;
    obj1.print();
    
    //operation on child class object
    obj=new;
    obj.a=9;
    obj.b=6;
    obj.seek();
  end
endmodule: tb