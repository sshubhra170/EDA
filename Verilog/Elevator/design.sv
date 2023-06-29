// Code your design here
module b_elevator (clk, rst, P0, P1, B0, B1, S0, S1, MD, MS);
  input clk, rst, P0, P1, B0, B1, S0, S1;
  output MD, MS;
  reg [2:1] y, Y;
  
  parameter down = 2'b00, goup = 2'b01, up = 2'b10, godown = 2'b11;
  
  // Define the next state combinational circuit
  always @(P0, P1, B0, B1, S0, S1, y)
    case (y)
      down: 
        if (B1)	Y = goup;
         else   Y = down;
      goup: 
        if (S1)	Y = up;
	     else   Y = goup;
      up: 
        if (B0)	Y = godown;
	     else   Y = up;
      godown: 
        if (S0)	Y = down;
	     else   Y = godown;
	  default: 	Y = 2'bxx;
	endcase

  // Define the sequential block	
  always @(negedge rst, posedge clk)
    if (rst) y <= down;
    else	 y <= Y;
  
  // Define output	
  assign MD = y == godown;
  assign MS = y == goup;
endmodule