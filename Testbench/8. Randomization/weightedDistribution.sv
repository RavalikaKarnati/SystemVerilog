`timescale 1ns / 1ps
class generator;
  rand bit wr;
  rand bit rd;
  
  constraint control {
    wr dist { 0 := 30, 1:= 70};  // //0 = 30/100 , 1 = 70/100
    rd dist {0:/ 30, 1:/70}; //0 = 30/100 , 1 = 70/100
  }
endclass

module tb;
  generator g1;
  initial begin
    g1 = new();
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
      $display("Value of wr: %0d and rd =%0d", g1.wr, g1.rd);
      #10;
    end
  end
endmodule

// output
# KERNEL: Value of wr: 0 and rd =1
# KERNEL: Value of wr: 1 and rd =1
# KERNEL: Value of wr: 0 and rd =0
# KERNEL: Value of wr: 1 and rd =1
# KERNEL: Value of wr: 1 and rd =1
# KERNEL: Value of wr: 1 and rd =0
# KERNEL: Value of wr: 1 and rd =0
# KERNEL: Value of wr: 1 and rd =1
# KERNEL: Value of wr: 0 and rd =1
# KERNEL: Value of wr: 0 and rd =1
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

-------------------------------------------------------------------------------------------
////////////////////////////////////////////////////// := vs :/ /////////////////////////////////////////

`timescale 1ns / 1ps
class generator;
  rand bit wr;
  rand bit rd;

  rand bit [1:0] a, b;
  constraint data {
    a dist { 0 := 30, [1:3] := 90 }; // dist= 30+90+90+90= 300(total) :::::: 0 = 30/300 , 1,2,3 = 90/300 
    b dist {0 :/ 30, [1:3] :/ 90};   // dist= 30+90= 120(total) :::: 0 has 30/120, an value btw [1:3] has 90/120 chance
  }
  
  constraint control {
    wr dist { 0 := 30, 1:= 70};
    rd dist {0:/ 30, 1:/70};
  }
endclass

module tb;
  generator g1;
  initial begin
    g1 = new();
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
 //     $display("Value of wr: %0d and rd =%0d", g1.wr, g1.rd);
      $display("Value of a: %0d and b =%0d", g1.a, g1.b);
      #10;
    end
  end
endmodule

// output
# KERNEL: Value of a: 0 and b =1
# KERNEL: Value of a: 2 and b =0
# KERNEL: Value of a: 1 and b =1
# KERNEL: Value of a: 0 and b =2
# KERNEL: Value of a: 1 and b =2
# KERNEL: Value of a: 0 and b =1
# KERNEL: Value of a: 2 and b =1
# KERNEL: Value of a: 2 and b =1
# KERNEL: Value of a: 0 and b =2
# KERNEL: Value of a: 3 and b =1
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
