module add ( 
  input clk,
  input [3:0] a, b,
  output reg [4:0] sum 
);
  always @( posedge clk) begin
     sum <= a+b;
  end
endmodule

class transaction;
  randc bit [3:0] a, b;
  bit [4:0] sum;
  function void display();
    $display("value of a : %0d \t b: %0d \t sum: %0d", a , b, sum);
  endfunction
endclass

// interface
interface add_if;
  logic clk;
  logic [3:0] a, b;
  logic [4:0] sum;  //  using logic is that it supports both procedural and continuous assignments, so we do not need to worry about those scenarios like use of reg or wire
                    //  if we use reg or wire, we need to consider whether the design uses procedural or continuous assignments, but since logic supports both, it automatically adapts to the specific situation. 
endinterface

class monitor;
  transaction t;
  mailbox #(transaction) mon_mbx;
  virtual add_if aif;  // to access the interface --> access output signals from DUT to monitor
  
   function new(mailbox #(transaction) mon_mbx);   // custom constrcutor for generator to connect mailboxfrom tb top
    this.mon_mbx = mon_mbx;
  endfunction
  
  task run();
    t = new();
    forever begin
      repeat(2) @(posedge aif.clk);
      t.a = aif.a;
      t.b = aif.b;
      t.sum = aif.sum;
      $display("[MON] data sent to scoreboard");
      t.display();
      mon_mbx.put(t);
    end
  endtask
  
endclass

class scoreboard;
  transaction data;
  mailbox #(transaction) score_mbx;
  
  function new(mailbox #(transaction) score_mbx);   // custom constrcutor for generator to connect mailboxfrom tb top
    this.score_mbx = score_mbx;
  endfunction
  
  task run();
    forever begin
      score_mbx.get(data);
      $display("[SCOREBOARD] data rcvd from Monitor");
      data.display();
      #40;
    end
  endtask
  
endclass
//manual stimulus

module tb;
  
  add_if aif();     // instantiate interface
  add dut(          // instantiate DUT and connect with interface
    .a(aif.a),       // Once this connection is done, anything applied to the variables of the interface will automatically go into the DUT, and  see a response.
    .b(aif.b),
    .sum(aif.sum),
    .clk(aif.clk)
  );

  initial begin
    aif.clk <= 0;
  end
   always #10 aif.clk <= ~aif.clk;

  // apply stimulus
  initial begin
    for(int i=0; i<20; i++) begin
       repeat(2) @(posedge aif.clk);
      aif.a <= $urandom_range(0,15);
      aif.b <= $urandom_range(0,15);
    end
  end
  
   monitor mon;
   scoreboard score;
   mailbox #(transaction) mbx;
  initial begin
    mbx = new();
    mon = new(mbx);
    score = new(mbx); 
    mon.aif = aif;
  end

  initial begin
    fork
      mon.run();
      score.run();
    join
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;  // add all variable values to vcd file
    #500;
    $finish;
  end
endmodule

//output
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 0 	 b: 0 	 sum: 0
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 0 	 b: 0 	 sum: 0
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 3 	 b: 11 	 sum: 14
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 3 	 b: 11 	 sum: 14
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 11 	 b: 3 	 sum: 14
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 11 	 b: 3 	 sum: 14
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 4 	 b: 9 	 sum: 13
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 4 	 b: 9 	 sum: 13
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 15 	 b: 15 	 sum: 30
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 15 	 b: 15 	 sum: 30
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 4 	 b: 1 	 sum: 5
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 4 	 b: 1 	 sum: 5
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 10 	 b: 12 	 sum: 22
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 10 	 b: 12 	 sum: 22
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 11 	 b: 9 	 sum: 20
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 11 	 b: 9 	 sum: 20
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 5 	 b: 15 	 sum: 20
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 5 	 b: 15 	 sum: 20
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 11 	 b: 13 	 sum: 24
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 11 	 b: 13 	 sum: 24
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 14 	 b: 9 	 sum: 23
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 14 	 b: 9 	 sum: 23
# KERNEL: [MON] data sent to scoreboard
# KERNEL: value of a : 8 	 b: 3 	 sum: 11
# KERNEL: [SCOREBOARD] data rcvd from Monitor
# KERNEL: value of a : 8 	 b: 3 	 sum: 11
# RUNTIME: Info: RUNTIME_0068 testbench.sv (106): $finish called.
# KERNEL: Time: 500 ns,  Iteration: 0,  Instance: /tb,  Process: @INITIAL#102_7@.
# KERNEL: stopped at time: 500 ns
# VSIM: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Finding VCD file...
./dump.vcd
[2025-12-03 04:23:50 UTC] Opening EPWave...
Done
