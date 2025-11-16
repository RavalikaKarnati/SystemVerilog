////////////////////////////////////// constraint internal to class ////////////////////////////////////

class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;

  constraint data_a {a>3; a<7;} // constraint name
  constraint data_b {b==3;}
  //  constraint data_a_b {a>3; a<7; b==3;}
  // constraint with range of values
  constraint data_range {a inside {[0:8], [10:11], 15};  // 0 1 2 3 4 5 6 7 8 10 11 15
                         b inside {[3:11]};} //3 4 5 6 7 8 9 10 11
endclass

module tb;
  generator g1, g2;
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
# KERNEL: Value of a: 5 and b =3
# KERNEL: Value of a: 4 and b =3
# KERNEL: Value of a: 6 and b =3
# KERNEL: Value of a: 4 and b =3
# KERNEL: Value of a: 4 and b =3
# KERNEL: Value of a: 4 and b =3
# KERNEL: Value of a: 4 and b =3
# KERNEL: Value of a: 6 and b =3
# KERNEL: Value of a: 5 and b =3
# KERNEL: Value of a: 5 and b =3
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

///////////////////////////////////////////////////// range ////////////////////////////////////////

`timescale 1ns / 1ps
class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;
  
  constraint data_range {a inside {[0:8], [10:11], 15};  // 0 1 2 3 4 5 6 7 8 10 11 15
                         b inside {[3:11]};} //3 4 5 6 7 8 9 10 11
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

// OUTPUT
# KERNEL: Value of a: 1 and b =5
# KERNEL: Value of a: 6 and b =10
# KERNEL: Value of a: 5 and b =8
# KERNEL: Value of a: 11 and b =9
# KERNEL: Value of a: 3 and b =6
# KERNEL: Value of a: 15 and b =4
# KERNEL: Value of a: 7 and b =7
# KERNEL: Value of a: 0 and b =3
# KERNEL: Value of a: 8 and b =11
# KERNEL: Value of a: 4 and b =7
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

///////////////////////////////////////////////////// range ////////////////////////////////////////

`timescale 1ns / 1ps
class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;
  
  constraint data_range {!(a inside {[3:7]});  // 0 1 2 8 9 10 11 12 13 14 15
                         !(b inside {[5:9]});} //3 4  10 11
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

// OUTPUT
# KERNEL: Value of a: 9 and b =11
# KERNEL: Value of a: 13 and b =13
# KERNEL: Value of a: 14 and b =4
# KERNEL: Value of a: 1 and b =2
# KERNEL: Value of a: 8 and b =10
# KERNEL: Value of a: 15 and b =1
# KERNEL: Value of a: 11 and b =0
# KERNEL: Value of a: 0 and b =14
# KERNEL: Value of a: 2 and b =15
# KERNEL: Value of a: 12 and b =12
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
