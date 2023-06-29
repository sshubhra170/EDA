`define TRUE 1'b1
`define FALSE 1'b0
`define RED 2'd0
`define YELLOW 2'd1
`define GREEN 2'd2

`define S0 2'd0
`define S1 2'd1
`define S2 2'd2
`define S3 2'd3

`define TOYDELAY1 30
`define FROMYDELAY 5
`define TOYDELAY2 55

module trafficlights(EW,NS,x,clk,clear);
  output reg[1:0] EW,NS;
  input x;
  input clk,clear;
  reg[2:0] state,next_state;
  reg [5:0] count;
  
  always @(posedge clk or negedge clk)
    state=next_state;

  always @(state)
    begin
      case(state)
        `S0:begin
          NS=`GREEN;
          EW=`RED;
        end
        `S1:begin
          NS=`YELLOW;
          EW=`YELLOW;
        end
        `S2:begin
          NS=`RED;
          EW=`GREEN;
        end
        `S3:begin
          NS=`YELLOW;
          EW=`YELLOW;
        end
      endcase
    end
  always @(posedge clk or posedge clear or negedge clk)
    begin
      if(clear) begin
        state=`S0;
        count=0;
      end
      else if(x)
        case(state)
          `S0:
              if(count <`TOYDELAY1) begin
                next_state=`S0;
                count=count+1;
              end
              else begin
                next_state=`S1;
                count=0;
              end
            
          `S1:
            if(count <`FROMYDELAY) begin
              next_state=`S1;
              count=count+1;
            end
            else begin
              next_state=`S2;
              count=0;
            end
          `S2:
            if(count <`TOYDELAY2) begin
              next_state=`S2;
              count=count+1;
            end              
            else begin
              next_state=`S3;
              count=0;
            end
          `S3: 
            if(count <`FROMYDELAY) begin
              next_state=`S3;
              count=count+1;
            end
            else begin
              next_state=`S0;
              count=0;
            end
          default:begin
            next_state=`S0;
          end
        endcase
    end
endmodule