/////////////////////////////////////////////////// PASS BY VALUE ////////////////////////////////////////////////////////////////////

module tb;
  task swap ( input bit [1:0] a, input bit [1:0] b);
    bit [1:0] temp;
    temp = a;
    a = b;
    b = temp;
    $display("value of a : %0d and b: %0d", a, b);
  endtask

  bit [1:0] a, b;
  initial begin
    a =1;
    b =2;
    swap(a,b);
    $display("Value of a: %0d and b: %0d", a,b);
  end
  
endmodule

// OUTPUT
// value of a : 2 and b: 1
// value of a : 1 and b: 2

//  when we call a task and utilize pass by value, local copies of the variables are created for the function. As soon as the execution completes, the changes won’t be reflected in the variables that we have 
//  in the main code. So here, the variables we have in the testbench, a and b, still have the values 1 and 2. Even though we updated the values of a and b in the swap function swap()—updating the value 
// of a with b and b with temp—these changes won’t be reflected in the variables in the testbench,

/////////////////////////////////////////////////// PASS BY REFERENCE ////////////////////////////////////////////////////////////////////
module tb;
  task automatic swap (ref input bit [1:0] a, b);
    bit [1:0] temp;
    temp = a;
    a = b;
    b = temp;
    $display("value of a : %0d and b: %0d", a, b);
  endtask

  bit [1:0] a, b;
  initial begin
    a =1;
    b =2;
    swap(a,b);
    $display("Value of a: %0d and b: %0d", a,b);  // this points to the actual memory of the main code, or this points to the variables that are in the main code, if you try to change the value of
                                                  // the variable, or an argument, these changes will automatically be reflected in the variables which are present in the testbench. 
  end
  
endmodule

// OUTPUT
// value of a : 2 and b: 1
// value of a : 2 and b: 1

/////////////////////////////////////////////////// PASS BY REFERENCE with const////////////////////////////////////////////////////////////////////
module tb;
  task automatic swap ( const ref input bit [1:0] a, ref input bit [1:0] b);  // you don't want to chnage the reference data and restrict the fucn or task from the chnaging the value you add "const"
                                                                               // here you are restrict the change of a from main program but "b" will be chnaged.
    bit [1:0] temp;
    temp = a;
//    a = b;   // we have use const for "a" but trying to update the value of a with b, this will through compile error.
             // let's say if we reomve "a=b", b will be updated with temp and a remains the same as main testbench.
    b = temp;
    $display("value of a : %0d and b: %0d", a, b);
  endtask

  bit [1:0] a, b;
  initial begin
    a =1;
    b =2;
    swap(a,b);
    $display("Value of a: %0d and b: %0d", a,b);  // this points to the actual memory of the main code, or this points to the variables that are in the main code, if you try to change the value of
                                                  // the variable, or an argument, these changes will automatically be reflected in the variables which are present in the testbench. 
  end
  
endmodule

// OUTPUT
// value of a : 1 and b: 1
// value of a : 1 and b: 1
