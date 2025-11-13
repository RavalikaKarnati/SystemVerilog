class first;             /// parent class //
  int data = 12;
  
    function new(input int data); 
    this.data = data;      //  all the three arguments which are there in a constructor are given the same name, which are used to name our data members.
                            // keyword = "this." to refer to the datamember of the class
  endfunction
endclass

class second extends first;            /// child class //
  int temp;
  
  function new(input int data, input int temp); 
     super.new(data);
    this.temp = temp;      //  all the three arguments which are there in a constructor are given the same name, which are used to name our data members.
                          // keyword = "this." to refer to the datamember of the class
  endfunction
endclass

module tb;
  second s1;
  initial begin
    s1 = new(10, 10);
    $display("value of data: %0d, temp: %0d", s1.data, s1.temp);
  end
endmodule

// output
# KERNEL: value of data: 10, temp: 10
