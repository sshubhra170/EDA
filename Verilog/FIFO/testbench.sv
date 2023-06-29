// Code your testbench here
// or browse Examples
module tb();

  reg clk, rst;
  reg wr_enb, rd_enb;
  reg [`DATA_WIDTH-1:0] data_in;
  wire [`DATA_WIDTH-1:0] data_out;
  wire full, empty;
  
  fifo uut(.clk(clk), 
           .rst(rst), 
           .wr_enb(wr_enb), 
           .rd_enb(rd_enb), 
           .data_in(data_in), 
           .data_out(data_out), 
           .full(full), 
           .empty(empty));
  
  always #10 clk = ~clk;
  
  initial begin
    clk = 0; 
    rst = 0;
    wr_enb = 0; 
    rd_enb = 0;
    @(negedge clk) rst = 1;
    start();
    #50
    start();
    #50
    $finish;
  end
  
  task push();
    if(!full) begin
      wr_enb = 1;
      data_in = $random;
    end
    else $display("-----FIFO Full!!-----");
  endtask : push
  
  task pop();
    if(!empty) begin
      rd_enb = 1;
    end
    else $display("-----FIFO Empty!!-----");
  endtask : pop
  
  task start();
    @(negedge clk)wr_enb = 0; 
    @(negedge clk)rd_enb = 0;
    //rst=0;
    fork
      //@(negedge clk) rst = 1;
      begin
        repeat(10) @(negedge clk) begin 
          push(); 
        end
        wr_enb = 0;
      end
      begin
        repeat(10) @(negedge clk) begin
          pop(); 
        end
        rd_enb = 0;
      end
    join
  endtask : start
  
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars(0,tb);
  end
endmodule : tb