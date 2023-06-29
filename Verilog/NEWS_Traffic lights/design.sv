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
  output [1:0] EW,NS;
  reg [1:0] EW,NS;
  input x;
  input clk,clear;
  reg[2:0] state;
  reg[2:0] next_state;
  initial begin 
    state=`S0;
    next_state=`S0;
    NS=`GREEN;
    EW=`RED;
  end
  always @(posedge clk)
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
  always @(state or clear or x)
    begin
      if(clear)
        next_state=`S0;
      else
        case(state)
          `S0: if(x) begin
            repeat(`TOYDELAY1)@(posedge clk or negedge clk);
            next_state=`S1;
          end
          else
            next_state=`S0;
          `S1:begin
            repeat(`FROMYDELAY)@(posedge clk or negedge clk);
            next_state=`S2;
          end
          `S2:begin
            repeat(`TOYDELAY2)@(posedge clk or negedge clk);
            next_state=`S3;
          end
          `S3: begin
            repeat(`FROMYDELAY)@(posedge clk or negedge clk);
            next_state=`S0;
          end
          default:begin
            next_state=`S0;
            end
        endcase
    end
endmodule