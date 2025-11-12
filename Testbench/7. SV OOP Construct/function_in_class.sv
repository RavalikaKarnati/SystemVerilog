/// create a custom construction instead of new() which we usually use with the class.
///////////////////////////////////// FUNCTION IN CLASS //////////////////////////////////////////////////

class custom;
    int data;
  function new();
    data = 32;
  endfunction
endclass

module tb;
custom f;
 initial begin
   f = new();
   $display("data : %0d", f.data);
 end
endmodule

// OUTPUT
// date : 32

/////////////////////////////////////////////////// FUNCTION IN CLASS --> create data on GO //////////////////////////////////

class custom;
  int data;
  function new(input int datain = 0); // specify the default value so that when we don't pass any argument when calling fucntion, it will take the default value
    data = datain;
  endfunction
endclass

module tb;
custom f;
 initial begin
   data_on_go = 24;
   f = new(data_on_go); // f = new(24)
   $display("data : %0d", f.data);
 end
endmodule

// OUTPUT
// date : 24

///////////////////////////////////// FUNCTION IN CLASS //////////////////////////////////////////////////
/////////////////////////////////////////////////// create multiple arguments for our custom constructor -- follow by the position //////////////////////////////////

class custom;
  int data1;
  bit [7:0] data2;
  shortint data3;
  
    function new(input int data1 = 0, input bit [7:0] data2 =0, input shortint data3 = 0); 
    this.data1 = data1;      //  all the three arguments which are there in a constructor are given the same name, which are used to name our data members.
    this.data2 = data2;      // keyword = "this." to refer to the datamember of the class
    this.data3 = data3; 
  endfunction
endclass

module tb;
custom f;
 initial begin
   f = new(11,22,33); // follow by the position -> 11 is assigned to data1, 22 is assigned to data2 , 33 is assigned to data3
   $display("data1 : %0d, data2 : %0d, data3 : %0d", f.data1, f.data2, f.data3);
 end
endmodule

// OUTPUT
// data1 : 11, data2 : 22, data3 : 33

/////////////////////////////////////////////////////////////////////// FUNCTION IN CLASS ///////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// create multiple arguments for our custom constructor -- follow by name //////////////////////////////////

class custom;
  int data1;
  bit [7:0] data2;
  shortint data3;
  
    function new(input int data1 = 0, input bit [7:0] data2 =0, input shortint data3 = 0); 
    this.data1 = data1;      //  all the three arguments which are there in a constructor are given the same name, which are used to name our data members.
    this.data2 = data2;      // keyword = "this." to refer to the datamember of the class
    this.data3 = data3; 
  endfunction
endclass

module tb;
custom f;
 initial begin
   f = new(.data2(4), .data3(5), .data1(6)); // follow by the position -> 11 is assigned to data1, 22 is assigned to data2 , 33 is assigned to data3
   $display("data1 : %0d, data2 : %0d, data3 : %0d", f.data1, f.data2, f.data3);
 end
endmodule

// OUTPUT
// data1 : 6, data2 : 4, data3 : 5

