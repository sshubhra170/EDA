module seq_detector(input x,clk,reset,
                    output reg z
                   );

  parameter S0 = 0 ,
  S1 = 1 , 
  S11 = 2 ,
  S110 = 3 ,
  S1100 = 4,
  S11001 = 5 , 
  S110011 = 6 ;
  reg [2:0] PS,NS ;

  always @(posedge clk or posedge reset)
    begin
      if(reset)
        PS <= S0;   
      else    
        PS <= NS ; 
    end
  always @(PS, x)
    begin          
      case(PS)
        S0 : begin
          NS = x ? S1 : S0 ;
          $display(PS);
        end
        S1 : begin 
          NS = x ? S11 : S0 ;
          $display(PS);
        end
        S11 : begin 
          NS = x ? S11 : S110 ;
          $display(PS);
        end 
        S110: begin 
          NS = x ? S0 : S1100 ;
          $display(PS);
        end
        S1100 : begin 
          NS = x ? S11001 : S0 ;
          $display(PS);
        end
        S11001 : begin
          NS = x ? S110011 : S0 ;
          $display(PS);
        end  
        S110011 : begin
          z=1;
          NS = x ? S11 : S110 ;
          $display(PS);
        end
        default: NS = S0; 
      endcase
    end
endmodule