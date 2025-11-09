/////////////////////////////////////////////////////////////////////// TASK IN CLASS ///////////////////////////////////////////////////////////////////
class custom
  int data1;
  bit [7:0] data2;
  shortint data3;
  
  function new(input int data1 = 0, input bit [7:0] data2 =0; input shortint data3 = 0); 
    this.data1 = data1;      //  all the three arguments which are there in a constructor are given the same name, which are used to name our data members.
    this.data2 = data2;      // keyword = "this." to refer to the datamember of the class
    this.data3 = data3; 
  endfunction

  task display();
     $display("data1 : %0d, data2 : %0d, data3 : %0d", f.data1, f.data2, f.data3);
  endtask
endclass

module tb;
custom f;
 initial begin
   f = new(.data2(4), .data3(5), .data1(6)); // follow by the position -> 11 is assigned to data1, 22 is assigned to data2 , 33 is assigned to data3
   f.display();
 end
endmodule

// OUTPUT
// data1 : 6, data2 : 4, data3 : 5
