// Code your testbench here
// or browse Examples
module tb;
  reg clk,rst;
  reg wr_enb;
  reg [`ADDR_WIDTH-1:0] wr_addr;
  reg [`DATA_WIDTH-1:0] wr_data;
  reg rd_enb;
  reg [`ADDR_WIDTH-1:0] rd_addr;
  reg [`DATA_WIDTH-1:0] rd_data;
  
  ram uut (.clk(clk),
           .rst(rst),
           .wr_enb(wr_enb),
           .wr_addr(wr_addr),
           .wr_data(wr_data),
           .rd_enb(rd_enb),
           .rd_addr(rd_addr),
           .rd_data(rd_data));
  always #10 clk = ~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,tb);
  end
  
  initial begin
    clk =0;
    rst=0;
    @(negedge clk) 
    rst = 1;
    @(negedge clk)
    rst = 0;
    
    repeat(10) begin
    @(negedge clk)
      wr_enb = 1;
      wr_addr = {$random};
      wr_data = {$random};
    end
    
    @(negedge clk)
    wr_enb = 0;
    
    repeat(10) begin
    @(negedge clk)
      rd_enb = 1;
      rd_addr = {$random};
      //rd_data = {$random};
    end
      
    /*rd_enb=0;
    rd_addr=4'h9;
    wr_addr=rd_addr;
    #20 rst=0;
    
    $display("Read data");
    #5 rd_enb=1;
    $display("data[%0h] : %0h",rd_addr,rd_data);
    #20 rd_enb=0;
    
    $display("Write data");
    #5 wr_enb=1;
    wr_data=8'hA6;
    #20 wr_enb=0;
    
    $display("Read data");
    #5 rd_enb=1;
    $display("data[%0h] : %0h",rd_addr,rd_data);
    #20 rd_enb=0; */
    #20
    $finish;
  end
endmodule;