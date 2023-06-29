// Code your testbench here
// or browse Examples
module seqdet_tb;
  localparam T =20;
  reg clk,rst;
  reg [5:0] match;
  reg [23:0] data;
  wire z,x;
  wire [5:0] q;
  assign x = data[23];
  
  seqdet U1(.x(x),.z(z),.clk(clk),.q(q),.rst(rst),.match(match));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
  initial begin
    clk =0;
    rst =1;
    #2 rst =0;
    #30 rst =1;
    match=6'b110011;
    data =20'b11001100110000_1001_0100;
    #(T*1000) $stop;
  end
  always #T clk = ~clk;
  always @ (posedge clk)
   #2 data = {data[22:0],data[23]};
endmodule