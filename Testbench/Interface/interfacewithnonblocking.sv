// why it is recommended to work with a non-blocking assignment operator, whenever you are assigning a value to the signals present in an interface????
module add ( 
  input clk,
  input [3:0] a, b,
  output reg [4:0] sum 
);
  always @( posedge clk) begin
     sum <= a+b;
  end
endmodule

// if we use an interface with all reg types, then we are not allowed to connect the variables that we have in an interface to the output port of the DUT. 
// And if you declare an interface with all wire types in that case, we are not allowed to apply a stimulus,  using initial or always blocks. 
// if we declare an interface with a reg type or an interface with a wire type. For that reason, okay, we utilize the logic type.

interface add_if;
  logic clk;
  logic [3:0] a, b;
  logic [4:0] sum;  //  using logic is that it supports both procedural and continuous assignments, so we do not need to worry about those scenarios like use of reg or wire
                    //  if we use reg or wire, we need to consider whether the design uses procedural or continuous assignments, but since logic supports both, it automatically adapts to the specific situation. 
endinterface

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
    aif.a <= 1;
    aif.b <= 5;
    repeat(3) @(posedge aif.clock)        // allows us to wait for 3 clock cycles
    #22;
     aif.a <= 3;
    #20;
     aif.a <= 4;
    #8;
     aif.a <= 5;
    #20;
     aif.a <= 6;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;  // add all variable values to vcd file
    #100;
    $finish;
  end
endmodule

// 
