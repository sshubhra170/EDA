// Code your design here
module fulladder(input rst,
                 input logic [7:0] a,
                 input logic [7:0] b,
                 input logic [7:0] c,
                 output logic [7:0] sum,
                 output logic [1:0] carry);

  always_comb begin
    if(rst) begin
      sum <= 0;
      carry <= 0;
    end
    else begin
      {carry,sum}=a + b + c;
    end
  end
  
endmodule : fulladder 