// here we have a class first, where we have a data member and a method. we want to modify this class by adding a few data members that help us to generate the complex
// stimulus or an algorithm, or we want to inject random errors in between the generation process. So, instead of creating a new class where we have an instance of this class, the good idea will
// be to extend the original class, and then try to add the new data members, along with the new method that you want to have for the generation of a complex stimulus
// keyword "extends" to extend first class --> bydefault class second gets access to datamembers and methods of first class
// In most cases, we could refer to the original class as a parent class and the extended class as the child class

class first;           /// PARENT CLASS ////////
  int data =12;
  function void display();
    $display("value of data: %0d", data);
  endfunction
endclass

class second extends first;  /// CHILD CLASS ////////////
  int temp = 34;
  function void add();
    $display("value after process: %0d", temp+4);
  endfunction
endclass

module tb;
  second s;
  initial begin
    s = new();
    s.display(); // $display("value of data: %0d", s.data);
    $display("value of temp: %0d", s.temp);
    s.add();
  end
endmodule

// OUTPUT
# KERNEL: value of data: 12
# KERNEL: value of temp: 34
# KERNEL: value after process: 38

