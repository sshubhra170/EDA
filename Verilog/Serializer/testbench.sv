// or browse Examples
module tb_serializer;
  reg tb_clk = 1'b0;        
  reg [7:0] tb_in_data = 8'b01010011;
  reg tb_valid_data =1'b1;
  wire tb_out_data ;  
  always begin
    tb_clk = ~tb_clk;
    #5;
  end
  Serializer DUT(.clk(tb_clk),
                 .in_data(tb_in_data),
                 .valid_data(tb_valid_data),
                 .out_data(tb_out_data)
                );                  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #200;
    tb_in_data = 8'b11001111;
    #500 $finish;
  end 
endmodule