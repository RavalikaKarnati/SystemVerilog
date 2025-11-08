`timescale 1ns / 1ps  
// `timescale __timeunit________ / _____timeprecision_____
//  `timescale 1ns / 1ps   --> 1ns --> TimeUnit
//                         --> 1ps --> TimePrecison
//  `timescale 1ns / 1ps --> T. U / T.P = 1 ns/ 1ps = 1000 = 10^3 , so here "3" is the power for a ten that represent the number of precision digit

// in this case #31.25 mentioned below for 16MHz will round off to 31 as precision bit is "3"
// in this case #62.5 mentioned below for 8MHz will round off to 63 as precision bit is "3"

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
