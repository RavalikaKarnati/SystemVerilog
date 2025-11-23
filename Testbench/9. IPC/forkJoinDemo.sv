module tb;
  task first();
    $display("Task1 started at %0t", $time);
    #20;
    $display("Task1 completed at %0t", $time);
  endtask

  task second();
    $display("Task2 started at %0t", $time);
    #30;
    $display("Task2 completed at %0t", $time);
  endtask

  task third();
    $display("reached next to join at %0t", $time);
  endtask

  initial begin
    fork
      first();
      second();
    join
    third();
  end
endmodule
