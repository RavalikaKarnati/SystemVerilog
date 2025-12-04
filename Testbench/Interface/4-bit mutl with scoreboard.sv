////////Design Code:

module top
(
  input clk,
  input [3:0] a,b,
  output reg [7:0] mul
);
  
  always@(posedge clk)
    begin
     mul <= a * b;
    end
  
endmodule

////////////Transaction
class transaction;
  randc bit [3:0] a, b;
  bit [7:0] mul;
  function void display();
    $display("value of a : %0d \t b: %0d \t mul: %0d", a , b, mul);
  endfunction
endclass

////////////Interface Code:

interface top_if;
  logic clk;
  logic [3:0] a, b;
  logic [7:0] mul;
  
endinterface


///////////// Monitor:
class monitor;
  bit [3:0] a, b;
  bit [7:0] mul;
  virtual top_if vif;

  function void display();
    $display("value of a : %0d \t b: %0d \t mul: %0d", vif.a , vif.b, vif.mul);
  endfunction
  
  task run();
    forever begin
      repeat(2) @(posedge aif.clk);
      this.a = vif.a;
      this.b = vif.b;
      this.mul = vif.mul;
      $display("[MON] data sent to scoreboard");
    end
  endtask
  
endclass
//////////// Scoreboard:
class scoreboard;
  
endclass
//////////////Testbench Top Code:

module tb;
  
  top_if vif();
  
  top dut (vif.clk, vif.a, vif.b, vif.mul);
  
  initial begin
    vif.clk <= 0;
  end
  
  always #5 vif.clk <= ~vif.clk;
  
  initial begin
    for(int i = 0; i<20; i++) begin
      @(posedge vif.clk);
      vif.a <= $urandom_range(1,15);
      vif.b <= $urandom_range(1,15);
    end
    
  end
  
  initial begin
    $dumpfile("dump.vcd");
     $dumpvars;    
    #300;
    $finish();
  end
  
endmodule
