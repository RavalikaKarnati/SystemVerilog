/////////////////////////////////////////////generator////////////////////////////////
`timescale 1ns / 1ps
class generator;
  rand bit [3:0] a, b;  // // repeats the value even all the possible values are not covered
  bit [3:0] y;
endclass

module tb;
  generator g1;
  int status = 0; // hold the status of the randomization
  initial begin
    g1 = new();
    g1.a.rand_mode(0); // disable randomization for variable "a"
    g1.b.rand_mode(1); // enable randomization for variable "b"
    // Turns off randomization for all variables
    g1.rand_mode (0);
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      status = g1.randomize();    //  randomize(); --> This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
                                  // To check whether randomization is successful or not, we use status. If the randomization is successful, status is "1" else status is "0"
      if (!status)  begin
        $display("Randomization Failed at %0t", $time);
      end
      $display("Value of a: %0d and b =%0d with status %0d", g1.a, g1.b, status);
      #10;
    end
  end
endmodule
