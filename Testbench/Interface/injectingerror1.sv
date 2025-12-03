// Injecting error
//when we send the deep copy of a transaction object instead of the original transaction object, we gain the capability to inject errors through a method or a constraint. 
// This is not possible if we send the transaction object directly from the generator to the driver and from the driver to a DUT.
// That way, we can check how our system responds to an error. This is primarily useful, for example, when working with Ethernet packets, where you may want to alter the CRC 
// Or when working with a UART, we already have a method developed—a method tocalculate the parity bit for a UART depending on the data being sent. You could inject an error such that the original parity bit will not
// send the original parity but instead an erroneous parity. How our system responds to that input or stimulus can also be analyzed.

//if you want to inject an undefined value to the system, how your system responds to it can also be verified


class transaction;
 randc bit [3:0] a;
 randc bit [3:0] b;
  bit [4:0] sum;
  
   function void display();
    $display("a : %0d \t b: %0d \t sum : %0d",a,b,sum);
  endfunction 
endclass
 
class error extends transaction; 
  constraint data_c {a ==  0; b == 0;}  // this constriant does not work
endclass
 
 
class generator;
  
  transaction trans;
  mailbox #(transaction) mbx;
  event done;
 
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  
  task run();
    trans = new();
    for(int i = 0; i<10; i++) begin
      trans.randomize();
      mbx.put(trans);  // sending the original transaction object , not the deep copy
      $display("[GEN] : DATA SENT TO DRIVER");
      trans.display();
      #20;
    end
   -> done;
  endtask
  
endclass
 
interface add_if;
  logic [3:0] a;
  logic [3:0] b;
  logic [4:0] sum;
  logic clk;
  
  modport DRV (input a,b, input sum,clk); 
endinterface
 
 
class driver;
  
  virtual add_if aif;
  mailbox #(transaction) mbx;
  transaction data;
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction 
  
  
  task run();
    forever begin
      mbx.get(data);
      @(posedge aif.clk);  
      aif.a <= data.a;
      aif.b <= data.b;
      $display("[DRV] : Interface Trigger");
      data.display();
    end
  endtask 
endclass
 
 
module tb;
  
 add_if aif();
 driver drv;
 generator gen;
  error err;  
  event done;
   mailbox #(transaction) mbx;
  
  add dut (aif.a, aif.b, aif.sum, aif.clk );
  
  initial begin
    aif.clk <= 0;
  end
  
  always #10 aif.clk <= ~aif.clk;
 
   initial begin
     mbx = new();
     err = new();
     drv = new(mbx);
     gen = new(mbx);
     
     gen.trans = err;
     
     drv.aif = aif;
     done = gen.done;  
   end
  
  initial begin
  fork
    gen.run();
    drv.run();
  join_none
    wait(done.triggered);
    $finish();
  end
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;  
  end
  
endmodule
