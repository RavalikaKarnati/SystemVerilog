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
gen.done = done;
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
