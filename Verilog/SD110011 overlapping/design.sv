module sd110011_moore_over(clk,reset,in,out);
  input reg clk,reset,in;
  output reg out;
  
  parameter S0=0;
  parameter S1=1;
  parameter S11=2;
  parameter S110=3;
  parameter S1100=4;
  parameter S11001=5;
  
  reg [2:0] state,next;

  always @(posedge clk) begin
    if(!reset)
      state <= S0;
    else
      state<=next;
  end
  always @(state or in) begin
    
    case(state)
      S0: begin
        if(in) begin
          next = S1;
          out=0;
        end
        else begin
          next=S0;
          out=0;
        end
      end
      S1: begin
        if(in) begin
          next = S11;
          out=0;
        end
        else begin
          next=S0;
          out=0;
        end
      end
      S11: begin
        if(in) begin
          next = S11;
          out=0;
        end
        else begin
          next = S110;
          out=0;
        end
      end
      S110: begin
        if(in) begin
          next = S1;
          out=0;
        end
        else begin
          next = S1100;
          out=0;
        end
      end
      S1100: begin
        if(in) begin
          next = S11001;
          out=0;
        end
        else begin
          next = S0;
          out=0;
        end
      end
      S11001: begin
        if(in) begin
          out=1;
          next=S11;
        end
        else begin
          next = S0;
          out=0;
        end
      end
    endcase
  end
endmodule