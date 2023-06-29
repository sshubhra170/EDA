module sd1010_moore_over(input clk,
                   input reset,
                   input din,
                   output reg dout);
  parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6;
  reg [2:0] state;
  

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      dout <= 1'b0;
      state <= S0;
    end
    else begin
      case(state)
        S0: begin
          dout <=1'b0;
          if(din)
            state <= S1;
        end
        S1: begin
          dout <= 1'b0;
          if(din)
            state <= S2;
        end
        S2: begin
          dout <= 1'b0;
          if(din)
            state <= S2;
          else
            state <= S3;
        end
        S3: begin
          dout <= 1'b0;
          if(din)
            state <= S0;
          else
            state <= S4;
        end
        S4: begin
          dout <= 1'b0;
          if(din)
            state <= S5;
          else
            state <= S0;
        end
        S5: begin
          dout <= 1'b0;
          if(din)
            state <= S6;
          else
            state <= S0;
        end
        S6: begin
          dout <= 1'b1;
          if(din)
            state <= S2;
          else
            state <= S3;
        end
      endcase
    end
  end


endmodule