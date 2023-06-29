module Controller(clock,
                  sig_Lid_Closed,
                  sig_Coin,sig_Cancel,
                  sig_Time_Out,
                  sig_Out_Of_Balance,
                  sig_Motor_Failure,
                  sig_Full,
                  sig_Time,
                  sig_Wash_Completed,
                  sig_Rinse_Completed,
                  sig_Spin_Completed,
                  sig_Dry_Completed,
                  start,
                  ready,
                  fill_Water_Operation,
                  soak_Operation,
                  wash_Operation,
                  rinse_Operation,
                  spin_Operation,
                  dry_Operation,
                  fault,
                  coin_Return,
                  water_Intake,
                  fault_Cleared,
                  state
                 );
    
  input clock;
  input sig_Lid_Closed;
  input sig_Coin;
  input sig_Cancel;
  input sig_Time_Out;
  input sig_Out_Of_Balance;
  input sig_Motor_Failure;
  input sig_Full;
  input sig_Time;
  input sig_Wash_Completed;
  input sig_Rinse_Completed;
  input sig_Spin_Completed;
  input sig_Dry_Completed;
  
  output start;
  output ready;
  output fill_Water_Operation;
  output soak_Operation;
  output wash_Operation;
  output rinse_Operation;
  output spin_Operation;
  output dry_Operation;
  output fault;
  output coin_Return;
  output water_Intake;
  output fault_Cleared;
  output [3:0] state;
  
  parameter STATE_START = 4'd0 ;
  parameter STATE_READY = 4'd1;
  parameter STATE_FILL_WATER = 4'd2;
  parameter STATE_SOAK = 4'd3;
  parameter STATE_WASH = 4'd4;
  parameter STATE_RINSE = 4'd5;
  parameter STATE_SPIN = 4'd6;
  parameter STATE_DRY = 4'd7;
  parameter STATE_FAULT = 4'd8;
  
  reg [3:0]state = STATE_START;
  reg [3:0] next_State;
  
  always @(posedge  clock) begin
    state = next_State;
  end
  
  always @(posedge clock) begin
    case (state)
      STATE_START: begin
        if (sig_Coin == 1)
          next_State = STATE_READY;
        else 
          next_State = STATE_START;
      end
      STATE_READY: begin
        if (sig_Lid_Closed == 1)
          next_State = STATE_FILL_WATER;
        else if (sig_Cancel == 1)
          next_State = STATE_START;
      end
      STATE_FILL_WATER: begin
        if (sig_Cancel == 1)
          next_State = STATE_START;
        else if (sig_Full == 1)
          next_State = STATE_SOAK;
                
        else if (sig_Time_Out == 1)
          next_State = STATE_FAULT;
        else 
          next_State = STATE_FILL_WATER;
        end
      STATE_SOAK: begin
        if (sig_Cancel == 1)
          next_State = STATE_START;
        else if (sig_Time == 1) 
          next_State = STATE_WASH;
        else if (sig_Time_Out == 1) 
          next_State = STATE_FAULT;
        else 
          next_State = STATE_SOAK;
      end
      STATE_WASH: begin
        if (sig_Cancel == 1)
          next_State = STATE_START;
        else if (sig_Wash_Completed == 1) 
          next_State = STATE_RINSE;                    
        else if (sig_Out_Of_Balance == 1)
          next_State = STATE_FAULT;
        else 
          next_State = STATE_WASH;
      end
      STATE_RINSE: begin
        if (sig_Cancel == 1)
          next_State = STATE_START;
        else if (sig_Rinse_Completed == 1) 
          next_State = STATE_SPIN;
        
        else if (sig_Motor_Failure == 1) 
          next_State = STATE_FAULT;
        
        else 
          next_State = STATE_RINSE;
      end
      STATE_SPIN: begin
        if (sig_Cancel == 1)
          next_State = STATE_START;
        
        else if (sig_Spin_Completed == 1) 
          next_State = STATE_DRY;
        
        else if (sig_Motor_Failure == 1 | sig_Out_Of_Balance == 1) 
          next_State = STATE_FAULT;
        
        else 
          next_State = STATE_SPIN;
      end
      STATE_DRY: begin
        if (sig_Cancel == 1)
          next_State = STATE_START;
        
        else if (sig_Dry_Completed == 1) 
          next_State = STATE_START;
        
        else if (sig_Motor_Failure == 1 | sig_Out_Of_Balance == 1) 
          next_State = STATE_FAULT;
        
        else 
          next_State = STATE_DRY;
      end
        
      STATE_FAULT:
        next_State = STATE_READY;
      
      default: 
        next_State = STATE_START;
    endcase    
  end
  
  assign start = (state == STATE_START) ? 1'b1 : 1'b0;
  assign ready = (state == STATE_READY)? 1'b1: 1'b0;
  assign fill_Water_Operation = (state == STATE_FILL_WATER)? 1'b1: 1'b0;
  assign soak_Operation = (state == STATE_SOAK)? 1'b1: 1'b0;   
  assign wash_Operation = (state == STATE_WASH)? 1'b1: 1'b0;
  assign rinse_Operation = (state == STATE_RINSE)? 1'b1: 1'b0;
  assign spin_Operation = (state ==STATE_SPIN)? 1'b1: 1'b0;
  assign dry_Operation = (state == STATE_DRY)? 1'b1: 1'b0;
  assign fault = (state == STATE_FAULT)? 1'b1: 1'b0;
  assign coin_Return = (state == STATE_READY)? 1'b1: 1'b0;
  assign water_Intake=((state==STATE_FILL_WATER)||(state == STATE_RINSE))? 1'b1: 1'b0;
  assign fault_Cleared = (state == STATE_FAULT)? 1'b1: 1'b0;
  
endmodule

module Timer (clock,
              state,
              sig_Full,
              sig_Time,
              sig_Wash_Completed,
              sig_Rinse_Completed,
              sig_Spin_Completed,
              sig_Dry_Completed
             );
    
  input clock;
  input [3:0] state;
  output sig_Full;
  output sig_Time;
  output sig_Wash_Completed;
  output sig_Rinse_Completed;
  output sig_Spin_Completed;
  output sig_Dry_Completed;
    
  reg sig_Full;
  reg sig_Time;
  reg sig_Wash_Completed;
  reg sig_Rinse_Completed;
  reg sig_Spin_Completed;
  reg sig_Dry_Completed;
  reg [1:0] fill_Water_Counter;
  reg [1:0] soak_Counter;
  reg [2:0] wash_Counter;
  reg [1:0] rinse_Counter;
  reg [1:0] spin_Counter;
  reg [1:0] dry_Counter;

  parameter STATE_START = 3'd0;
  parameter STATE_READY = 3'd1;
  parameter STATE_FILL_WATER = 3'd2;
  parameter STATE_SOAK = 3'd3;
  parameter STATE_WASH = 3'd4;
  parameter STATE_RINSE = 3'd5;
  parameter STATE_SPIN = 3'd6;
  parameter STATE_DRY = 3'd7;
  
  parameter FULL_WATER_TIME = 2'd2;
  parameter SOAK_TIME = 2'd3;
  parameter WASH_TIME = 3'd5;
  parameter RINSE_TIME = 2'd3;
  parameter SPIN_TIME = 2'd3;
  parameter DRY_TIME = 2'd3;
  
  
  always @ (posedge clock) begin 
    if (fill_Water_Counter == FULL_WATER_TIME)
      sig_Full = 1;

    if (soak_Counter == SOAK_TIME) 
      sig_Time = 1;
    
    if (wash_Counter == WASH_TIME)
      sig_Wash_Completed = 1;
    if (rinse_Counter == RINSE_TIME)
      sig_Rinse_Completed = 1;
    if (spin_Counter == SPIN_TIME)
      sig_Spin_Completed = 1; 
    if (dry_Counter == DRY_TIME)
      sig_Dry_Completed =1;
    if (state == STATE_START || state == STATE_READY) begin
      fill_Water_Counter = 0;
      soak_Counter = 0;
      wash_Counter = 0;
      rinse_Counter = 0;
      spin_Counter = 0;
      dry_Counter =0;
      sig_Full = 0;
      sig_Time = 0;
      sig_Wash_Completed = 0;
      sig_Rinse_Completed = 0;
      sig_Spin_Completed = 0; 
      sig_Dry_Completed =0;
    end 
    case (state)
      STATE_FILL_WATER: 
        fill_Water_Counter = fill_Water_Counter + 1'd1;
      STATE_SOAK: 
        soak_Counter = soak_Counter + 1'd1;
      STATE_WASH: 
        wash_Counter = wash_Counter + 1'd1;
      STATE_RINSE: 
        rinse_Counter = rinse_Counter + 1'd1;
      STATE_SPIN: 
        spin_Counter = spin_Counter + 1'd1;
      STATE_DRY:
        dry_Counter = dry_Counter + 1'd1;
    endcase
  end                    
endmodule

module Microcontroller(clock,
                       sig_Lid_Closed,
                       sig_Coin,
                       sig_Cancel,
                       sig_Time_Out,
                       sig_Out_Of_Balance,
                       sig_Motor_Failure,
                       state
                      );
  input clock;
  input sig_Lid_Closed;
  input sig_Coin;
  input sig_Cancel;
  input sig_Time_Out;
  input sig_Out_Of_Balance;
  input sig_Motor_Failure;
  output [3:0] state;
  
  
  wire start;
  wire ready;
  wire fill_Water_Operation;
  wire soak_Operation;
  wire wash_Operation;
  wire rinse_Operation;
  wire spin_Operation;
  wire dry_Operation;
  wire fault;
  wire coin_Return;
  wire water_Intake;
  wire fault_Cleared;
  wire sig_Full;
  wire sig_Time;
  wire sig_Wash_Completed;
  wire sig_Rinse_Completed;
  wire sig_Spin_Completed;
  wire sig_Dry_Completed;
  
  
  Timer timer (.clock(clock),
               .state(state),
               .sig_Full(sig_Full),
               .sig_Time(sig_Time),
               .sig_Wash_Completed(sig_Wash_Completed),
               .sig_Rinse_Completed(sig_Rinse_Completed),
               .sig_Spin_Completed(sig_Spin_Completed),
               .sig_Dry_Completed(sig_Dry_Completed)
              ); 
  Controller controller(.clock(clock),
                        .sig_Lid_Closed(sig_Lid_Closed), 
                        .sig_Coin(sig_Coin),
                        .sig_Cancel(sig_Cancel),
                        .sig_Time_Out(sig_Time_Out),
                        .sig_Out_Of_Balance(sig_Out_Of_Balance),
                        .sig_Motor_Failure(sig_Motor_Failure),
                        .sig_Full(sig_Full),
                        .sig_Time(sig_Time),
                        .sig_Wash_Completed(sig_Wash_Completed),
                        .sig_Rinse_Completed(sig_Rinse_Completed),
                        .sig_Spin_Completed(sig_Spin_Completed),
                        .sig_Dry_Completed(sig_Dry_Completed),
                        .start(start),
                        .ready(ready),
                        .fill_Water_Operation(fill_Water_Operation),
                        .soak_Operation(soak_Operation),
                        .wash_Operation(wash_Operation),
                        .rinse_Operation(rinse_Operation),
                        .spin_Operation(spin_Operation),
                        .dry_Operation(dry_Operation),
                        .fault(fault),
                        .coin_Return(coin_Return),
                        .water_Intake(water_Intake),
                        .fault_Cleared(fault_Cleared),
                        .state(state)
                       );       

endmodule