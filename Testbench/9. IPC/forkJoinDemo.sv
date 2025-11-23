/////////////////////////////////////////////////////////////////////// fork--- join ///////////////////////////////////////////////////////////////////////////////////////
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

//output
# KERNEL: Task1 started at 0
# KERNEL: Task2 started at 0
# KERNEL: Task1 completed at 20
# KERNEL: Task2 completed at 30
# KERNEL: reached next to join at 30
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.


/////////////////////////////////////////////////////////////////////// fork--- join_any ///////////////////////////////////////////////////////////////////////////////////////
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
    join_any
    third();
  end
endmodule

//output
# KERNEL: Task1 started at 0
# KERNEL: Task2 started at 0
# KERNEL: Task1 completed at 20
# KERNEL: reached next to join at 20
# KERNEL: Task2 completed at 30
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
