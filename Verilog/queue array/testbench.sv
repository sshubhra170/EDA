module tb;
  int que[$] ={26,45,67,13,32,8,90};
  int dq[$];
  initial begin
    $display("%p",que);
    que.sort();
        
    $display("%p",que);
    $display("%p",que[$-1]);
  end
endmodule