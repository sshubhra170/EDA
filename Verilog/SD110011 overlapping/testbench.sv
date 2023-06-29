module testbench;
  reg x;
  reg clk;
  reg reset;
  wire z;
  integer i;
  reg [20:0] data;
  always #5 clk = ~ clk; 
  sd110011_moore_over uut (.in(x), .clk(clk), .reset(reset), .out(z));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, testbench); 
    $monitor("reset=%b  in=%b  out=%b",reset,x,z);
    clk=0;
    reset=0;
    #10
    reset=1;
    data=20'b11001100110110011001;
    i=0;
    #500;
    $finish;
  end
  always @(posedge clk) begin
    x=data>>i;
    i=1+i;
  end
endmodule