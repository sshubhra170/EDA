`define TRUE 1'b1
`define FALSE 1'b0
`define RED 2'd0
`define YELLOW 2'd1
`define GREEN 2'd2

`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

`define Y2RDELAY 3
`define R2GDELAY 2

module trafficlights(highway,farm,x,clk,clear);
  output [1:0] highway,farm;
  reg [1:0] highway,farm;
  input x;
  input clk,clear;
  reg[2:0] state;
  reg[2:0] next_state;
  initial begin 
    state=`S0;
    next_state=`S0;
    highway=`GREEN;
    farm=`RED;
  end
  always @(posedge clk)
    state=next_state;
  always @(state)
    begin
      case(state)
        `S0:begin
          highway=`GREEN;
          farm=`RED;
        end
        `S1:begin
          highway=`YELLOW;
          farm=`RED;
        end
        `S2:begin
          highway=`RED;
          farm=`RED;
        end
        `S3:begin
          highway=`RED;
          farm=`GREEN;
        end
        `S4:begin
          highway=`RED;
          farm=`YELLOW;
        end
      endcase
    end
  always @(state or clear or x)
    begin
      if(clear)
        next_state=`S0;
      else
        case(state)
          `S0: if(x)
            next_state=`S1;
          else
            next_state=`S0;
          `S1:begin
            repeat(`Y2RDELAY)@(posedge clk);
            next_state=`S2;
          end
          `S2:begin
            repeat(`R2GDELAY)@(posedge clk);
            next_state=`S3;
          end
          `S3: if(x)
            next_state=`S3;
          else
            next_state=`S4;
          `S4:begin
            repeat(`Y2RDELAY)@(posedge clk);
            next_state=`S0;
          end
          default:begin
            next_state=`S0;
            end
        endcase
    end
endmodule