// interface is a crucial block that allows us to communicate the data between classes and DUT
// module add ( input [3:0] a, b,
// output [5:0] sum );
// assign sum = a+b;
// endmodule

//The first thing we do when starting to write an interface is to use the same names that we have for the ports. The interface will consist of a combination of all the ports present in the module

interface add_if;
  logic [3:0] a, b;
  logic [4:0] sum;  //  using logic is that it supports both procedural and continuous assignments, so we do not need to worry about those scenarios like use of reg or wire
                    //  if we use reg or wire, we need to consider whether the design uses procedural or continuous assignments, but since logic supports both, it automatically adapts to the specific situation. 
endinterface


// there’s no relationship between the interface and DUT. We need to develop a relationship so that whatever value we apply to these variables will travel to the ports and test our design.
// Once we verify that applying a value to the variables travels to the ports and we can receive the response from the DUT.

module tb;
  
  add_if aif();     // instantiate interface
  add dut(          // instantiate DUT and connect with interface
    .a(aif.a),       // Once this connection is done, anything applied to the variables of the interface will automatically go into the DUT, and  see a response.
    .b(aif.b),
    .sum(aif.sum)
  );

  // apply stimulus
  initial begin
    aif.a = 4'h0100;
    aif.b = 4;
    #1;
    $display("a : %b , b : %b and sum : %b",aif.a, aif.b, aif.sum );
    #10;
     aif.a = 3;
    #1;
    $display("a : %b , b : %b and sum : %b",aif.a, aif.b, aif.sum );
    #10;
     aif.b = 7;
    #1;
    $display("a : %b , b : %b and sum : %b",aif.a, aif.b, aif.sum );
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;  // add all variable values to vcd file
  end
endmodule

//OUTPUT
# KERNEL: a : 0100 , b : 0100 and sum : 01000
# KERNEL: a : 0011 , b : 0100 and sum : 00111
# KERNEL: a : 0011 , b : 0111 and sum : 01010
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
