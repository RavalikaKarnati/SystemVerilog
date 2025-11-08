// `timescale timeunit / timeprecision = 1 ns / 1ps = 10^3 = So time is rounded till 3 decimal points
// eg: #62.25 ==> 62.25
//     #62.251 ==> 62.251
//     #62.2514 ==> 62.251
//     #62.2516 ==> 62.252
`timescale 1ns / 1ps  
 
module tb();
 
  
  reg clk; //initial value = X
  
  reg clk50;
  reg clk25 = 0;  ///initialize variable
  
 
  initial begin
    clk = 1'b0;
    clk50 = 0; 
  end

//  always #(clock_period/2) clk = ~clk;
  always #5 clk = ~clk; // #5 is half clock period
  
// generate clocks with phase shift
// always #10 clk50 = ~clk50;
// always #20 clk25 = ~clk25;
 
 // generate clocks without phase shift
  always begin // // whenever you use an always block without a sensitivity list, see that you forcefully call a finish after you execute your stimuli for the specified duration
  #5;
   clk50 = 1;
  #10;
   clk50 = 0; 
   #5; 
  end
  
  always begin
    #5;
    clk25 = 1;
    #20;
    clk25 = 0;
    #15;  
  end
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
 
  initial begin
    #200;
   $finish();   // whenever you use an always block without a sensitivity list, see that you forcefully call a finish after you execute your stimuli for the specified duration
  end
  
endmodule
