module tb;
  task fork_join();
    $display("FOR FORK_JOIN ");
  	fork
    	begin
          $display("%0t: fork join statement 1",$time);
          #5
          $display("%0t: fork join statement 2",$time);
        end
      begin     
        #10
        $display("%0t: fork join statement 3",$time);
      end
    join
    $display("%0t: fork join statement 4",$time);
    //$display("-----END TASK-----");
  endtask: fork_join
  
  task fork_join_any();
    $display("FOR FORK_JOIN_ANY ");
  	fork
    	begin
          $display("%0t: fork join any statement 1",$time);
          #5;
          $display("%0t: fork join any statement 2",$time);
        end
      begin
        #10;
        $display("%0t: fork join any statement 3",$time);
        //$display("%0t: statement 4",$time);
      end
    join_any
    $display("%0t: fork join any statement 4",$time);
    //$display("-----END TASK-----");
  endtask: fork_join_any
  
  task fork_join_none();
    $display("FOR FORK_JOIN_NONE ");
  	fork
    	begin
          $display("%0t: fork join none statement 1",$time);
          #5
          $display("%0t: fork join none statement 2",$time);
        end
      begin
        #10
        $display("%0t: fork join none statement 3",$time);
      end
    join_none
    $display("%0t: fork join none statement 4",$time);
    //$display("-----END TASK-----");
  endtask: fork_join_none
  initial begin
  	
    fork_join_any();
    fork_join();  	
  	fork_join_none();
    #50
    $finish;
  end

endmodule: tb