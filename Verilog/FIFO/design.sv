// Code your design here
`define DATA_WIDTH 8
`define DEPTH 8
`define PTR_WIDTH 4

module fifo(
  input clk, rst,
  input wr_enb, rd_enb,
  input [`DATA_WIDTH-1:0] data_in,
  output reg [`DATA_WIDTH-1:0] data_out,
  output full, empty
);
  
  reg [`PTR_WIDTH-1:0] w_ptr, r_ptr;
  reg [`DATA_WIDTH-1:0] fifo[`DEPTH];
  reg [`DEPTH-1:0] count;
  
  //Assign value to Full and Empty signals
  assign full = (count == `DEPTH);
  assign empty = (count == 0);
  
  // Set Default values on reset.
  always@(posedge clk or posedge rst) begin
    if(!rst) begin
      w_ptr <= 0; 
	  r_ptr <= 0;
      data_out <= 0;
      count <= 0;
    end
    else begin
      if(wr_enb && !full) 
        count <= count +1;
	  else if (rd_enb && !empty) 
        count <= count -1;
      else if((wr_enb && !full) && (rd_enb && !empty)) 
        count <= count;
	  else count <= count;
    end
  end
  
  // To write data to FIFO
  always@(posedge clk) begin
    if(wr_enb & !full)begin
      fifo[w_ptr] <= data_in;
      w_ptr <= w_ptr + 1;
    end
    if(full) begin
      w_ptr <= 0;
    end
  end
  
  // To read data from FIFO
  always@(posedge clk) begin
      if(rd_enb & !empty) begin
        data_out <= fifo[r_ptr];
        r_ptr <= r_ptr + 1;  
      end
    else begin
      data_out<=data_out;
    end
  end
endmodule