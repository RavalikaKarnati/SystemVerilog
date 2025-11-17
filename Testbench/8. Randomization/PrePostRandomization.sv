// pre-randomize
// post-randomize
`timescale 1ns / 1ps
class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;
  int min, max;  // used to set constraints for the data members

  function void pre_randomize(input int min, input int max);
    this.min = min;
    this.max = max; 
  endfunction

  constraint data {
    a inside {[min:max]};
    b inside {[min:max]};
  }
  function void post_randomize();
    $display("value of a %0d and b %0d", a, b);
  endfunction

endclass

module tb;
  generator g1;
  initial begin
    g1 = new();
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      g1.pre_randomize(3,8);
      g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
      #10;
    end
  end
endmodule

//output
# KERNEL: value of a 5 and b 5
# KERNEL: value of a 6 and b 3
# KERNEL: value of a 7 and b 4
# KERNEL: value of a 8 and b 7
# KERNEL: value of a 4 and b 6
# KERNEL: value of a 3 and b 8
# KERNEL: value of a 7 and b 4
# KERNEL: value of a 5 and b 3
# KERNEL: value of a 8 and b 8
# KERNEL: value of a 3 and b 6
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// pre-randomize
// post-randomize
`timescale 1ns / 1ps
class generator;
  randc bit [3:0] a, b;  // Do not repeat the value until all the possible values are covered
  bit [3:0] y;
  int min, max;  // used to set constraints for the data members

  function void pre_randomize(input int min, input int max);
    this.min = min;
    this.max = max; 
  endfunction

  constraint data {
    a inside {[min:max]};
    b inside {[min:max]};
  }
  function void post_randomize();
    $display("value of a %0d and b %0d", a, b);
  endfunction

endclass

module tb;
  generator g1;
  initial begin
    g1 = new();
     $display("SPACE 1");
    g1.pre_randomize(3,8);
    for ( int i=0; i<10; i++) begin  // 3, 4, 5, 6, 7, 8
      g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
      #10;
    end
    $display("SPACE 2");
    g1.pre_randomize(3,8);
    for ( int i=0; i<10; i++) begin  // repeat (10) or foreach ( size)
      g1.randomize();    //  This will generate the random value for the signals modified with the keyword rand, both a and b are modified with the rand keyword, so for a and b, we will generate random values
      #10;
    end
  end
endmodule

# KERNEL: SPACE 1
# KERNEL: value of a 5 and b 5
# KERNEL: value of a 6 and b 3
# KERNEL: value of a 7 and b 4
# KERNEL: value of a 8 and b 7
# KERNEL: value of a 4 and b 6
# KERNEL: value of a 3 and b 8
# KERNEL: SPACE 2
# KERNEL: value of a 7 and b 4
# KERNEL: value of a 5 and b 3
# KERNEL: value of a 8 and b 8
# KERNEL: value of a 3 and b 6
# KERNEL: value of a 4 and b 5
# KERNEL: value of a 6 and b 7
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
