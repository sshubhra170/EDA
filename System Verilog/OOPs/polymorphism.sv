class test;
  
  int data;
  protected int out; //Encapsulation
  
  virtual function void display(int data); 
    out = data;
    $display("happend parent class : %0d",out);
  endfunction : display
  
endclass : test

class test1 extends test;
  
  int data;
  
  
  function void display(int x);
    super.display(x);
    out= this.data;
    $display("happend in child class : %0d", out);
  endfunction : display
  
endclass : test1

class test2 extends test;
  
  int x;
  
  function void display(int x);
    out= x;
    //super.display(out);
    $display("happend in child class 2 : %0d", out);
  endfunction : display
  
endclass : test2

module tb;
  
  test t; // parent class object
  test1 t1; //child class object
  test2 t2;
  
  initial begin
    t = new();
    t.display(90); //calls function from parent class
    
    t1 = new();
    t1.data=89;
    t1.display(78); //calls function from child class
    
    t2=new();
    t = t2; //base handle assigned to ext object 
    t.display(67); //calss function from child class
    
    $cast(t2,t);
    t.display(45);
  end
  
endmodule:tb