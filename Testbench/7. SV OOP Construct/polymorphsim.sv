class first;           /// PARENT CLASS ////////
  int data =12;
 function void display();
    $display("FIRST:value of data: %0d", data);
  endfunction
endclass

class second extends first;  /// CHILD CLASS ////////////
  int temp = 34;
  function void add();
    $display("value after process: %0d", temp+4);
  endfunction

  function void display();
    $display("SECOND: value of data: %0d and temp :%0d", data, temp);
  endfunction
endclass

module tb;
  first f1;
  second s1;
  initial begin
    s1 = new();
    f1 =new();
    f1 = s1;
    f1.display();
  end
endmodule

// output
# KERNEL: FIRST:value of data: 12 // even though we assign an object of the extended class to a base class (f1 = s1;), 
                                  //still the methods which are executed are from the parent class, and are not executed from an extended class
                                  // if you want to execute the method that you have mentioned in an extended class and not in parent class, you should define the method in parent class as "virtual"
                                
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////// KEYWORD: VIRTUAL /////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// If keyword "VIRTUAL" is added to the parent class what happens?
// here we have method display() in both parent class and extended class so, in this case display() method in parent class will be overridden with the extended class and the display() in extended class is executed
// if If you do not override the display() method ( or donot define display() method) in the extended class, in that case, the method that we have in the parent class will be executed

// Example: // here we have method display() in both parent class and extended class so, in this case display() method in parent class will be overridden with the extended class and 
             // the display() in extended class is executed

class first;           /// PARENT CLASS ////////
  int data =12;
 virtual function void display();
    $display("FIRST:value of data: %0d", data);
  endfunction
endclass

class second extends first;  /// CHILD CLASS ////////////
  int temp = 34;
  function void add();
    $display("value after process: %0d", temp+4);
  endfunction

  function void display();
    $display("SECOND: value of data: %0d and temp :%0d", data, temp);
  endfunction
endclass

module tb;
  first f1;
  second s1;
  initial begin
    s1 = new();
    f1 =new();
    f1 = s1;
    f1.display();
  end
endmodule

//OUTPUT
# KERNEL: SECOND: value of data: 12 and temp :34

-------------------------------------------------------------------------------------------------------
// Example: If you do not override the display() method ( or donot define display() method) in the extended class, in that case, the method that we have in the parent class will be executed

class first;           /// PARENT CLASS ////////
  int data =12;
 virtual function void display();
    $display("FIRST:value of data: %0d", data);
  endfunction
endclass

class second extends first;  /// CHILD CLASS ////////////
  int temp = 34;
  function void add();
    $display("value after process: %0d", temp+4);
  endfunction

  // function void display();
  //   $display("SECOND: value of data: %0d and temp :%0d", data, temp);
  // endfunction
endclass

module tb;
  first f1;
  second s1;
  initial begin
    s1 = new();
    f1 =new();
    f1 = s1;
    f1.display();
  end
endmodule

//OUTPUT
# KERNEL: FIRST:value of data: 12
