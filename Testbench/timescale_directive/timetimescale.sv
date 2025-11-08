`timescale 1ns / 1ps   //10^3 -> 3
// if `timescale 1ns / 1ns // 10^0 -> 0
// in this case #31.25 mentioned below for 16MHz will round off to 31
// in this case #62.5 mentioned below for 8MHz will round off to 63
 
module tb();
 

  reg clk16 = 0;
  reg clk8 = 0;  ///initialize variable
  
 
   always #31.25 clk16 = ~clk16;
   always #62.5 clk8 = ~clk8;
  
 
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
 
  initial begin
    #200;
    $finish();
  end
  
endmodule
