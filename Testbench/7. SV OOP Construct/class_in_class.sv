// Situation to use a class inside another class. This will always be the case because we will be dividing our test bench into small components.
// Finally, there will be abstract classes connecting the multiple classes together.
// fundamentals of class inside a class:
// by default, the scope for a data member of a class is public

class first
  int data = 34;  
  task display_first();
    $disaply("value of data is class first %0d", data)
  endtask
endclass

class second
  first f1;
  function new();
    f1 = new();
  endfunction
  task display_second();
    $disaply("value of data is class first inside class second %0d", f1.data)
  endtask
endclass

module tb;  
  initial begin
    second s2;
    s2 = new();
    $disaply("value of data in module %0d", s2.f1.data);
    s2.display_second();
    s2.f1.display_first();
    s2.f1.data = 24;
    s2.display_second();
    s2.f1.display_first();  
  end
endmodule

// OUTPUT
// value of data in module 34
// value of data is class first inside class second 34
// value of data is class first 34
// value of data is class first inside class second 24
// value of data is class first 24


///////////////////////////////////////////////////// local/ protected member /////////////////////////////////////////////////
class first
  local int data = 34;   // when you add "local" to the varible in a class, you cannot access the data from another class
                         // data is restricted or visible to only class first
                         // this is done to protect some of the data members
  task display_first();
    $disaply("value of data is class first %0d", data)
  endtask
endclass

class second
  first f1;
  function new();
    f1 = new();
  endfunction
endclass

module tb;  
  initial begin
    second s2;
    s2 = new();
    $disaply("value of data in module %0d", s2.f1.data);
    s2.f1.display_first();  
  end
endmodule

// OUTPUT
// compile error: cannot access local/protected

///////////////////////////////////////////////////// local/ protected member /////////////////////////////////////////////////
class first
  local int data = 34;   // when you add "local" to the varible in a class, you cannot access the data from another class
                         // data is restricted or visible to only class first
                         // this is done to protect some of the data members
  // But if other classes required to access we provide a unique method
  // user can call that method to access the data
  task set ( input int data);
    this.data = data;
  endtask

  function int get()
    return data;
  endfunction

  task display_first();
    $disaply("value of data is class first %0d", data)
  endtask
endclass

class second
  first f1;
  function new();
    f1 = new();
  endfunction
endclass

module tb;  
  initial begin
    second s2;
    s2 = new();
    s2.f1.set(123); 
    $disaply("value of data is class first %0d", s2.f1.get())
  end
endmodule

// OUTPUT
// 

