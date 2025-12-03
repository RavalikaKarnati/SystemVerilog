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
      @(posedge aif.clk);
      t.a <= aif.a;
      t.b <= aif.b;
      t.sum <= aif.sum;
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
      #20;
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
      @(posedge aif.clk)
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
