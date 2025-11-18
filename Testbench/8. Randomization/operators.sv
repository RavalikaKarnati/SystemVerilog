/////////////////////////////////// IMPLICATION OPERATOR //////////////////////////////////////////////////

class generator;
  
  randc bit [3:0] a;
  rand bit ce;
  rand bit rst;
  
  constraint control_rst {
    rst dist {0:= 80, 1 := 20};
  }
   
  constraint control_ce {
    ce dist {1:= 80, 0 := 20};
  }  
  constraint control_rst_ce {
    ( rst == 0 ) -> (ce == 1); 
  }  
endclass
 
module tb;
  
  generator g1; 
  initial begin
    g1 = new();
    for (int i = 0; i<10 ; i++) begin
      assert(g1.randomize()) else $display("Randomization Failed");
      $display("Value of rst : %0b and ce : %0b", g1.rst, g1.ce);
    end 
  end
 
endmodule

//output
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Value of rst : 1 and ce : 0
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Value of rst : 1 and ce : 0
# KERNEL: Value of rst : 0 and ce : 1
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.

/////////////////////////////////// EQUIVALENCE OPERATOR //////////////////////////////////////////////////
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
    ( wr == 1 ) <-> (oe == 0);  // when wr is "1", oe is "0". when oe is "1" wr is "0"
  }  
endclass 
module tb;  
  generator g;  
  initial begin
    g = new();   
    for (int i = 0; i<10 ; i++) begin
      assert(g.randomize()) else $display("Randomization Failed");
      end   
  end 
endmodule

/////////////////////////////////// IF-ELSE OPERATOR //////////////////////////////////////////////////
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
    ( wr == 1 ) <-> (oe == 0); 
  }

  constraint wr_addr {

( wr == 1 ) -> (addr inside {[0:7]});

( wr == 0) -> (addr inside {[8:15]});

}
  constraint write_read {   
    if(wr == 1)
    {
      waddr inside {[11:15]};
      raddr == 0;
    }
      else
      {
      waddr == 0;
      raddr inside {[11:15]};  
      }    
  }  
endclass
 
module tb;  
  generator g;  
  initial begin
    g = new();    
    for (int i = 0; i<15 ; i++) begin
      assert(g.randomize()) else $display("Randomization Failed");
      $display("Value of wr : %0b | oe : %0b |  raddr : %0d | waddr : %0d |", g.wr, g.oe,g.raddr, g.waddr);
    end  
  end
endmodule

//output
# KERNEL: Value of wr : 0 | oe : 1 |  raddr : 14 | waddr : 0 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 11 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 14 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 13 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 12 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 15 |
# KERNEL: Value of wr : 0 | oe : 1 |  raddr : 13 | waddr : 0 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 15 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 14 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 12 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 11 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 13 |
# KERNEL: Value of wr : 0 | oe : 1 |  raddr : 11 | waddr : 0 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 15 |
# KERNEL: Value of wr : 1 | oe : 0 |  raddr : 0 | waddr : 11 |
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
