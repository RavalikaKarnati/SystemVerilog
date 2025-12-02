//// Trigger : ->
// edge-senstive_blocking @()
/// level-sensitive_nonblocking wait()
// whenever we are working with @(), if we miss sensing an edge at the current simulation time, we may go into a blocking state and won’t execute the next statement until we again sense the edge of an event. 
// Whereas, when we consider the wait operator for the current simulation time, if our event is triggered, we will execute the next statement. This is non-blocking in nature, and we are able to sense
// an event for the current simulation time

module tb;
  event a;
  initial begin
    #10;
    -> a;  // trigger an event after some time span
  end

  initial begin
//    @(a);  // blocking operator
    wait(a.triggered); // 
    $display("Received Event at %0t", $time);
  end
endmodule

//OUTPUT
# KERNEL: Received Event at 10
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

/////////////////////////////////////////////////////////////////////////////// edge-senstive_blocking @() vs level-sensitive_nonblocking wait()////////////////////////////////////////////////////
module tb;
  event a1, a2;
  initial begin
    -> a1;  // trigger an event after some time span
    -> a2;
  end

  initial begin
    @(a1);    // if we miss sensing that a1 is triggered then it blocks here and does not proceed in executing further
    $display("Received A1 trigged %0t", $time);
    @(a2); 
    $display("Received A2 trigged %0t", $time);
  end
endmodule

//OUTPUT
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

/////////////////////////////////////////////////////////////////////////////// edge-senstive_blocking @() vs level-sensitive_nonblocking wait()////////////////////////////////////////////////////
module tb;
  event a1, a2;
  initial begin
    -> a1;  // trigger an event after some time span
    -> a2;
  end

  initial begin
    wait(a1.triggered);    // if we miss sensing that a1 is triggered then it blocks here and does not proceed in executing further
    $display("Received A1 trigged %0t", $time);
    wait(a2.triggered); 
    $display("Received A2 trigged %0t", $time);
  end
endmodule

//OUTPUT
# KERNEL: Received A1 trigged 0
# KERNEL: Received A2 trigged 0
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

/////////////////////////////////////////////////////////////////////////////// edge-senstive_blocking @() vs level-sensitive_nonblocking wait()////////////////////////////////////////////////////
module tb;
  event a1, a2;
  initial begin
    -> a1;  // trigger an event after some time span
    #10;
    -> a2;
  end

  initial begin
    wait(a1.triggered);    // if we miss sensing that a1 is triggered then it blocks here and does not proceed in executing further
    $display("Received A1 trigged %0t", $time);
    @(a2); 
    $display("Received A2 trigged %0t", $time);
  end
endmodule

//OUTPUT
# KERNEL: Received A1 trigged 0
# KERNEL: Received A2 trigged 10
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
