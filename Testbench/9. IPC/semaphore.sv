class first;
  randc int data;
  constraint data_c { data >0; data<10;}
endclass

class second;
  randc int data;
  constraint data_c { data >10; data<20;}
endclass

class main;
  semaphore sem;
  first f;
  second s;
  int data;

  task send_first();
    sem.get(1);
    for (int i=0; i<10; i++) begin
      f.randomize;
      data = f.data;
      $display("first access Semaphore and Data sent %0d", f.data);
    end
    sem.put(1);
    $display("Semaphore Unoccupied");
  endtask

  task send_second();
    sem.get(1);
    for (int i=0; i<10; i++) begin
      s.randomize();
      data = s.data;
      $display("second access Semaphore and Data sent %0d", s.data);
    end
     sem.put(1);
     $display("Semaphore Unoccupied");
  endtask

  task run();
    sem = new(1);
    f = new();
    s = new();

    fork 
    send_first();
    send_second();
    join
  endtask

endclass

module tb;
  main m;

  initial begin
    m = new();
    m.run();
  end

   initial begin
    #250;
    $finish();
  end
endmodule

//output
# KERNEL: first access Semaphore and Data sent 4
# KERNEL: first access Semaphore and Data sent 6
# KERNEL: first access Semaphore and Data sent 1
# KERNEL: first access Semaphore and Data sent 7
# KERNEL: first access Semaphore and Data sent 5
# KERNEL: first access Semaphore and Data sent 9
# KERNEL: first access Semaphore and Data sent 3
# KERNEL: first access Semaphore and Data sent 8
# KERNEL: first access Semaphore and Data sent 2
# KERNEL: first access Semaphore and Data sent 8
# KERNEL: Semaphore Unoccupied
# KERNEL: second access Semaphore and Data sent 13
# KERNEL: second access Semaphore and Data sent 15
# KERNEL: second access Semaphore and Data sent 11
# KERNEL: second access Semaphore and Data sent 17
# KERNEL: second access Semaphore and Data sent 18
# KERNEL: second access Semaphore and Data sent 19
# KERNEL: second access Semaphore and Data sent 14
# KERNEL: second access Semaphore and Data sent 12
# KERNEL: second access Semaphore and Data sent 16
# KERNEL: second access Semaphore and Data sent 12
# KERNEL: Semaphore Unoccupied
