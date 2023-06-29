interface fa_intf();
  
  logic a;
  logic b;
  logic c;
  logic sum;
  logic carry;
  property p1;
    @(posedge a) b##1c;
  endproperty
  a1 : assert property(p1);
  modport DRV(output a,b,c);
    
  modport MON(input a,b,c,sum,carry);
  
endinterface