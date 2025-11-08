`timescale 1ns / 1ps
 
module tb();
 
/////global signal clk , rst
  
  reg clk;
  reg rst;
  
  reg [3:0] temp;
  
  //1. Initialized Global Variable
  initial begin
    clk = 1'b0;
    rst = 1'b0;
  end
  ////2. Random signal for data/ control 


 // the initial block starts its execution at the start of a simulation and will be executing the sequence that you have mentioned inside this block right from 0ns.
 // As soon as we execute all the statements that you mentioned,  this will complete the execution of the initial block. And then, as soon as we complete the execution of all the statements,
// that basically completes the span of the initial block. but when we work with the reg type, this basically holds the value. So, even though our execution finishes
//over here, for example, if we consider below initial block: rst = 1 from 0 to 30 ns, and after a delay of 30,
//we are making rst = 0. so at this instance, we complete the execution of the initial block, but the variable will still hold its value till the end of the simulation. 
// since this is the last statement that we have in the initial block, it will still hold its value till the end of the simulation due to the reg data type. 
// Reg has memory that keeps the last value till the end of the simulation. 
 
  initial begin
    rst = 1'b1;
    #30;
   rst = 1'b0;  // this will hold the value to the end of simulation as this is the last statement and rst is of "reg" type.
 end
  
  
  initial begin
  temp = 4'b0100;
  #10;
  temp = 4'b1100;
  #10; 
  temp = 4'b0011;
  #10;  
  end
  
  
  ///////3. System Task at the start of simulation
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  /////4. Analyzing Values of variable on COnsole
  initial begin
    $monitor("Temp : %0d at time : %0t", temp, $time);
  end
  
  ///5. Stop simulation by forcefully calling $finish
  initial begin
    #200;
    $finish();
  end
  
endmodule
