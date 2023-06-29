module seqdet
(
   input wire x,
   input wire clk,
   input wire rst,
  input reg [5:0] match,
   output wire z,
  output reg [5:0] q
);
 

 
  assign z = (q == match) ? 1'b1:1'b0;
 
always @ (posedge clk,negedge rst)
   if(!rst)
      q <= 6'd0;
   else
     q <= {q[4:0],x};
 
endmodule