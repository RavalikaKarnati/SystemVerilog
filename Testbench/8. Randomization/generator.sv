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

//OUTPUT
# KERNEL: Value of a: 6 and b =5 with status 1
# KERNEL: Value of a: 3 and b =4 with status 1
# KERNEL: Value of a: 15 and b =13 with status 1
# KERNEL: Value of a: 11 and b =8 with status 1
# KERNEL: Value of a: 7 and b =8 with status 1
# KERNEL: Value of a: 10 and b =10 with status 1
# KERNEL: Value of a: 11 and b =13 with status 1
# KERNEL: Value of a: 13 and b =4 with status 1
# KERNEL: Value of a: 9 and b =9 with status 1
# KERNEL: Value of a: 1 and b =11 with status 1
# KERNEL: Simulation has finished. There are no more test vectors to simulate.


//////////////////////////////////////////////////////////////////////// randc Keyword /////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;
endclass

module tb;
  generator g1;
  initial begin
    g1 = new();
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
      $display("Value of a: %0d and b =%0d", g1.a, g1.b);
      #10;
    end
  end
endmodule

//OUTPUT
# KERNEL: Value of a: 1 and b =8
# KERNEL: Value of a: 15 and b =5
# KERNEL: Value of a: 3 and b =0
# KERNEL: Value of a: 0 and b =15
# KERNEL: Value of a: 13 and b =13
# KERNEL: Value of a: 7 and b =2
# KERNEL: Value of a: 9 and b =9
# KERNEL: Value of a: 5 and b =10
# KERNEL: Value of a: 12 and b =11
# KERNEL: Value of a: 8 and b =6
# KERNEL: Simulation has finished. There are no more test vectors to simulate.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////Randomized generator with multiple stimulus///////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;
endclass

module tb;
  generator g1, g2;
  initial begin
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      g1 = new();
      g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
      $display("Value of a: %0d and b =%0d", g1.a, g1.b);
      #10;
    end
  end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////generator with randomization status using IF-ELSE & constraint ///////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
class generator;
  rand bit [3:0] a, b;  // // repeats the value even all the possible values are not covered
  bit [3:0] y;
  constraint data { a > 15;}
endclass

module tb;
  generator g1;
  int status = 0; // hold the status of the randomization
  initial begin
    g1 = new();
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

//OUTPUT
# KERNEL: Randomization Failed at 0
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 10000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 20000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 30000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 40000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 50000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 60000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 70000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 80000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Randomization Failed at 90000
# KERNEL: Value of a: 0 and b =0 with status 0
# KERNEL: Simulation has finished. There are no more test vectors to simulate.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////generator with randomization status using ASSERT & constraint /////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
class generator;
  rand bit [3:0] a, b;  // // repeats the value even all the possible values are not covered
  bit [3:0] y;
  constraint data { a > 15;}
endclass

module tb;
  generator g1;
  int status = 0; // hold the status of the randomization
  initial begin
    g1 = new();
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      status = g1.randomize();    //  randomize(); --> This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
                                  // To check whether randomization is successful or not, we use status. If the randomization is successful, status is "1" else status is "0"
      assert (status) 
      else begin
        $display("Randomization Failed at %0t", $time);
        $finish;
      end
      $display("Value of a: %0d and b =%0d with status %0d", g1.a, g1.b, status);
      #10;
    end
  end
endmodule

//OUTPUT
# KERNEL: Randomization Failed at 0
# RUNTIME: Info: RUNTIME_0068 testbench.sv (19): $finish called.
# KERNEL: Time: 0 ps,  Iteration: 0,  Instance: /tb,  Process: @INITIAL#11_1@.
# KERNEL: stopped at time: 0 ps
# VSIM: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
