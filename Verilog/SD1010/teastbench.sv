module sequence_test_bench;
reg clk;
reg rst;
reg data_in; 
wire  data_out;

sd1010_moore_over seq( clk, rst,data_in,data_out);
initial begin
  $dumpvars;
  $dumpfile("dump.vcd");
end
initial begin 
clk = 1'b1;
forever #5 clk = ~clk;
end

initial begin
#5;
rst = 1'b1;
#10; 
rst = 1'b0;
#5;
data_in = 1'b1;
#8;
data_in = 1'b1;
#8;
data_in = 1'b0;
#8;
data_in = 1'b0;
#8;
data_in = 1'b1;
#8;
data_in = 1'b1;
#8;
data_in = 1'b0;
#8;
data_in = 1'b0;
#8;
data_in = 1'b1;
#8;
data_in = 1'b1;
#12;
data_in = 1'b0;
#8;
data_in = 1'b0;
#8;
data_in = 1'b1;
#8;
data_in = 1'b1;
#8;
$finish;
end
endmodule