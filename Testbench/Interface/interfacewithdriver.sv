module add ( 
  input clk,
  input [3:0] a, b,
  output reg [5:0] sum 
);
  always @( posedge clk) begin
     sum <= a+b;
  end
endmodule

interface add_if;
  logic [3:0] a, b;
  logic [4:0] sum;  //  using logic is that it supports both procedural and continuous assignments, so we do not need to worry about those scenarios like use of reg or wire
                    //  if we use reg or wire, we need to consider whether the design uses procedural or continuous assignments, but since logic supports both, it automatically adapts to the specific situation. 
endinterface

class driver;
  virtual add_if aif;  // Virtual -- definition of an interface is defined outside the class
  task run();
    forever begin
      @(posedge aif.clk)
      aif.a <= 1;
      aif.b <= 5;    
    end
  endtask
endclass

module tb;
  
  add_if aif();     // instantiate interface
  add dut(          // instantiate DUT and connect with interface
    .a(aif.a),       // Once this connection is done, anything applied to the variables of the interface will automatically go into the DUT, and  see a response.
    .b(aif.b),
    .sum(aif.sum),
    .clk(aif.clk)
  );

  initial begin
    aif.clk = 0;
  end
  always #10 aif.clk = ~aif.clk;

  // apply stimulus
  driver drv;
  initial begin
    drv = new();
    drv.aif = aif; // connecting interface from inside class aif to the interface outside the class // this will allow to send stimulus from driver to DUT
    drv.run();
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;  // add all variable values to vcd file
    #100;
    $finish;
  end
endmodule
