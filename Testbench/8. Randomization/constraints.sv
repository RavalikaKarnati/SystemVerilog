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
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      g1 = new();
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
