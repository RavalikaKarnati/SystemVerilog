module top ( 
  input clk,
  input [3:0] a, b,
  output reg [7:0] mul 
);
  always @( posedge clk) begin
     mul <= a*b;
  end
endmodule


//// testbench
//transaction

class transaction;
  randc bit [3:0] a, b;
  bit [7:0] mul;

function void display();
$display("value of a : %0d b: %0d mul: %0d", a , b, mul);
endfunction

// create a deep copy
function transaction copy();
copy = new();
copy.a = this.a;
copy.b = this.b;
endfunction

endclass

//interface

interface mul_if;
logic [3:0] a, b;
logic [7:0] mul;
logic clk;
  
  modport DRV (
    output a, b,
    input mul, clk
  );

endinterface

// generator

class generator;
transaction t;
event done;
event next;
mailbox #(transaction) gen2drv_mbx;
  
function new (mailbox #(transaction) gen2drv_mbx);
this.gen2drv_mbx = gen2drv_mbx;
t = new();
endfunction

task run();
int status=0;
for( int i=0; i<10; i++) begin
status = t.randomize();
assert(status) 
else $display("[GEN] randomization failed");
$display("[GEN] data sent to driver");
t.display();
gen2drv_mbx.put(t.copy);
#10;
wait(next.triggered);
end
-> done;
endtask
endclass

//driver

class driver;
transaction dc;
event next; 
mailbox #(transaction) drv2gen_mbx;
virtual mul_if.DRV mif;
  
function new (mailbox #(transaction) drv2gen_mbx);
this.drv2gen_mbx = drv2gen_mbx;
endfunction

task run();
forever begin
drv2gen_mbx.get(dc);
$display("[DRV] data RCVd from generator to driver");
@(posedge mif.clk)
mif.a <= dc.a;
mif.b <= dc.b;
dc.display();
#10;
  -> next;
end
endtask
endclass

// testbench top

module tb_top();
mailbox #(transaction) mbx;
generator gen;
driver drv;
event done;
event next;
mul_if mif();

top dut(
.a (mif.a),
.b(mif.b),
.mul(mif.mul),
.clk(mif.clk)
);
  
initial begin
  mif.clk = 0;
end
  
always #10 mif.clk <= ~ mif.clk;
initial begin
mbx = new();
gen = new(mbx);
drv = new(mbx);
drv.mif = mif;
done = gen.done;
drv.next = next;
gen.next = drv.next;
end

task wait_event();
wait(done.triggered);
$display("Completed Sending all Stimulus");
endtask

initial begin
fork 
gen.run();
drv.run();
join
wait_event();
end
  
initial begin
 $dumpfile("dump.vcd");
 $dumpvars;  // add all variable values to vcd file
 #250;
$finish;
  end
endmodule

//output
# KERNEL: value of a : 13 b: 8 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 13 b: 8 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 7 b: 14 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 7 b: 14 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 14 b: 5 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 14 b: 5 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 2 b: 10 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 2 b: 10 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 0 b: 13 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 0 b: 13 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 12 b: 7 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 12 b: 7 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 3 b: 9 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 3 b: 9 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 9 b: 11 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 9 b: 11 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 15 b: 3 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 15 b: 3 mul: 0
# KERNEL: [GEN] data sent to driver
# KERNEL: value of a : 8 b: 0 mul: 0
# KERNEL: [DRV] data RCVd from generator to driver
# KERNEL: value of a : 8 b: 0 mul: 0
# RUNTIME: Info: RUNTIME_0068 testbench.sv (138): $finish called.
# KERNEL: Time: 250 ns,  Iteration: 0,  Instance: /tb_top,  Process: @INITIAL#134_6@.
# KERNEL: stopped at time: 250 ns
# VSIM: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
