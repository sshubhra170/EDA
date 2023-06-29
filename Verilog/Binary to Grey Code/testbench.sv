// Code your testbench here
// or browse Examples
module tb();

  reg [3:0] bin;
  wire [3:0] G,bin_out;
  $dumpfile("dump.vcd");
  $dumpvars(0,tb);
  bin2gray uut1(bin,G);
    
   // stimulus
   always
   begin        
      bin <= 0; #10;
        bin <= 1;   #10;
        bin <= 2;   #10;
        bin <= 3;   #10;
        bin <= 4;   #10;
        bin <= 5;   #10;
        bin <= 6;   #10;
        bin <= 7;   #10;
        bin <= 8;   #10;
        bin <= 9;   #10;
        bin <= 10;  #10;
        bin <= 11;  #10;
        bin <= 12;  #10;
        bin <= 13;  #10;
        bin <= 14;  #10;
        bin <= 15;  #10;
        #100;   
      $stop;
   end
endmodule