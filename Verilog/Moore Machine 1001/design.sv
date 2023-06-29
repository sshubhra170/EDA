module moore_1001(input reset,
                  input clk,
                  input x,
                  output reg  y
                 );
  parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4;
  reg [2:0] current_State, next_State;
  
  
  always @(posedge clk) begin
    if(reset)
      current_State <=A;
    else
      current_State <=next_State;
    end
  always @(*) begin
    next_State= current_State;
    y=1'b0;
    
    case (current_State)
      
      A: begin
        if(x==1'b1) next_State=B;
      end
      
      B: begin
        if(x==1'b0) next_State=C;
      end
      C: begin 
        if(x==1'b0) next_State=D;
        else 
          next_State= B;
      end
      
      D: begin 
        if(x==1'b0) next_State=A;
        else                
          next_State= E;
      end
      E:         
        begin 
          y=1'b1;
          if(x==1'b0) next_State=C;
          else 
            next_State= B;
        end
      default: begin 
        next_State=A; 
        y=1'b0; 
      end
    endcase                
  end
endmodule