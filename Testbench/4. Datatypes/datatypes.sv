//////////////////////////////////////// Hardware datatypes////////////////////////////////////////////////////////////////////
module top (
  input a , b, sel,
  output reg y );

  always @(*) begin 
    if ( sel == 1'b0)
      y = a;
    else
      y = b;
  end
endmodule

//////////////////////////////////////// Variable datatypes////////////////////////////////////////////////////////////////////
module tb;

  bit a = 0;
  byte b = 0; // If initial value is not defined. 2-state will have initial value "0", 4-state will have "X" as initial value
  shortint c = 0;
  int d = 0;
  longint e = 0;

  bit [7:0] f = 8'h0; // unsigned variable

  real h = 0;
endmodule

module tb;

  byte var = -130 // range of bye is -2^(8-1) to (2^8)-1 = -128 to 127

  initial begin
    $display("value of var: %0d", var); // -130 is not within the range so it displays some random number
  end

endmodule
//////////////////////////////////////// Simulation datatypes////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module tb;
  time fix_time = 0;
  realtime real_time =0;
  ///// $time() --> returns current simulation time in fixed point format
  ///// $realtime() --> returns current simulation time in floating point format
  initial begin
  #12;
    fix_time = $time();
    $display("Current Simulation time: %0t", fix_time); // console shows "12"
  #12.23;
    real_time = $real_time();
    fix_time = $time();
    $display("Current Simulation time: %0t", fix_time);  // cannot hold 12.23 so display only "12"
    $display("Current Simulation time: %0t", real_time); // console shows "12.23"
  #12.678;
    real_time = $real_time();
    fix_time = $time();
    $display("Current Simulation time: %0t", fix_time);  // cannot hold 12.678 round off to "13"
    $display("Current Simulation time: %0t", real_time); // console shows "12.678" as precision is "3" (1ns/1ps = 1000)  
  end
endmodule


