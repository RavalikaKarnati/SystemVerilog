class generator;
  
  randc bit [3:0] raddr, waddr;
  rand bit wr; ///write to mem
  rand bit oe; ///output enable
  
  constraint wr_c {
    wr dist {0:= 50, 1 := 50};
  }
  
  constraint oe_c {
    oe dist {1:= 50, 0 := 50};
  }
  
  constraint wr_oe_c {
    ( wr == 1 ) -> (oe == 0); 
  }
endclass

module tb;  
  generator g;  
  initial begin
    g = new();    
    g.wr_oe_c.constraint_mode(0);              // call function "constraint_mode" to turn off/on constraint. 0: OFF , 1:ON
  //  if(g.oe_c.constraint_mode(0)) begin
      $display("Value of status oe_c: %0d", g.oe_c.constraint_mode());
  //  end
    for (int i = 0; i<15 ; i++) begin
      assert(g.randomize()) else $display("Randomization Failed");
      $display("Value of wr : %0b | oe : %0b |", g.wr, g.oe);
    end  
  end
endmodule

//output
# KERNEL: Value of status oe_c: 1
# KERNEL: Value of wr : 0 | oe : 1 |
# KERNEL: Value of wr : 0 | oe : 1 |
# KERNEL: Value of wr : 0 | oe : 1 |
# KERNEL: Value of wr : 1 | oe : 1 |
# KERNEL: Value of wr : 0 | oe : 1 |
# KERNEL: Value of wr : 1 | oe : 1 |
# KERNEL: Value of wr : 0 | oe : 1 |
# KERNEL: Value of wr : 0 | oe : 0 |
# KERNEL: Value of wr : 1 | oe : 1 |
# KERNEL: Value of wr : 1 | oe : 1 |
# KERNEL: Value of wr : 1 | oe : 0 |
# KERNEL: Value of wr : 1 | oe : 0 |
# KERNEL: Value of wr : 1 | oe : 0 |
# KERNEL: Value of wr : 1 | oe : 0 |
# KERNEL: Value of wr : 1 | oe : 1 |
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
