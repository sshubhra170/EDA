module tb;
  reg clk;
  reg [1:0] coin;
  reg rstn;
  wire coffee;
  vendingmachine vend(.coin(coin),
                      .clk(clk),
                      .rstn(rstn),
                      .coffee(coffee));
  initial begin
    $display("\t\t Time  Reset Coffee \n");
    $monitor("%d  %d  %d",$time,rstn,coffee);
    $dumpvars;
    $dumpfile("tb.vcd");
  end
  always begin
    #20 clk=~clk;
  end
  initial begin
    clk=0;
    coin=0;
    rstn=1;
    #50 rstn=0;
    @(negedge clk);
    #80 coin=1; #40 coin=0;
    #80 coin=1; #40 coin=0;
    #80 coin=1; #40 coin=0;
    
    #180 coin=1; #40 coin=0;
    #80 coin=2; #40 coin=0;
    
    #180 coin=2; #40 coin=0;
    #80 coin=2; #40 coin=0;
    
    #180 coin=2; #40 coin=0;
    #80 coin=1; #40 coin=0;
    
    #80 $finish;
  end
endmodule