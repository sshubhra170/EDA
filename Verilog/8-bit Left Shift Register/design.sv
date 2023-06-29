module shift (C, CLR, SI, SO); 
  input  C,SI,CLR; 
  output SO; 
  reg [7:0] tmp; 
  
  always @(posedge C or posedge CLR) 
    begin 
      if (CLR) 
        tmp = 8'b00000000; 
      else 
        begin 
          tmp = {tmp[6:0], SI}; 
        end  
 
    end 
  assign SO  = tmp[7]; 
endmodule 