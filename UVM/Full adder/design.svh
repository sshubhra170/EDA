// Code your design here
module full_adder(input a, b, c, output carry, sum);
  assign {carry,sum}=a+b+c;
endmodule : full_adder