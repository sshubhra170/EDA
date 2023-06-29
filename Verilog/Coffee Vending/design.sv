module vendingmachine(coin,clk,rstn,coffee);
  input [1:0] coin;
  input clk,rstn;
  output coffee;
  wire coffee;
  
  reg [1:0] state;
  reg [1:0] next_state;
  
  parameter s0 = 2'b00;
  parameter s5 = 2'b01;
  parameter s10 = 2'b10;
  parameter s15 = 2'b11;
  
  function [2:0] fsm;
    input [1:0] fsm_coin;
    input [1:0] fsm_state;
    reg fsm_coffee;
    reg [1:0] fsm_next;
    
    begin
      case(fsm_state)
        s0 : begin
          if(fsm_coin == 2'b10)
            begin
              fsm_coffee = 1'b0;
              fsm_next = s10;
            end
          else if(fsm_coin == 2'b01)
            begin
              fsm_coffee = 1'b0;
              fsm_next = s5;
            end
          else
            begin
              fsm_coffee = 1'b0;
              fsm_next = s0;
            end
        end
        s5 : begin
          if(fsm_coin == 2'b10)
            begin
              fsm_coffee = 1'b0;
              fsm_next = s15;
            end
          else if(fsm_coin == 2'b01)
            begin
              fsm_coffee = 1'b0;
              fsm_next = s10;
            end
          else
            begin
              fsm_coffee = 1'b0;
              fsm_next = s5;
            end
        end
        s10 : begin
          if(fsm_coin == 2'b10)
            begin
              fsm_coffee = 1'b0;
              fsm_next = s15;
            end
          else if(fsm_coin == 2'b01)
            begin
              fsm_coffee = 1'b0;
              fsm_next = s15;
            end
          else
            begin
              fsm_coffee = 1'b0;
              fsm_next = s10;
            end
        end
        s15 : begin
          fsm_coin = 1'b1;
          fsm_next = s0;
        end
      endcase
      fsm = {fsm_coffee,fsm_next};
    end
  endfunction
  
  assign {coffee,next_state} = fsm (coin,state);
  
  always @(posedge clk)
    begin
      if(rstn == 1'b1)
        state = s0;
      else
        state= next_state;
    end
endmodule