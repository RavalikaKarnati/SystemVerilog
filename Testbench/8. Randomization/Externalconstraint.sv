`timescale 1ns / 1ps
class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;
  extern constraint data_a_b;    // KEYWORD: EXTERN
  extern function void display;
endclass

constraint generator::data_a_b {
  a inside {[0:3]}; 
  b inside {[12:15]};
};

function void generator::display ();
  $display("Value of a: %0d and b =%0d", a, b);
endfunction      

module tb;
  generator g1;
  initial begin
    g1 = new();
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      status = g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
      g1.display();
      #10;
    end
  end
endmodule

//OUTPUT
# KERNEL: Value of a: 3 and b =14
# KERNEL: Value of a: 1 and b =12
# KERNEL: Value of a: 0 and b =15
# KERNEL: Value of a: 2 and b =13
# KERNEL: Value of a: 0 and b =13
# KERNEL: Value of a: 2 and b =12
# KERNEL: Value of a: 1 and b =14
# KERNEL: Value of a: 3 and b =15
# KERNEL: Value of a: 0 and b =13
# KERNEL: Value of a: 3 and b =12
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
