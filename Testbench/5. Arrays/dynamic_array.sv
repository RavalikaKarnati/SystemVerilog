///////////////////////////////////////  DYNAMIC MEMORY ALLOCATION, DELETE ELEMENTS IN ARRAY , Again DYANMIC MEMORY ALLOCATION with DIFFERENT SIZE//////////////////////////////

module tb;
  int arr[]; // Declaring, no need to specify size
  
  initial begin 
    $display("elements in array before memory allocation %p", arr); // array is empty
    arr = new[10]; // Allocating memory 
    for ( int i =0; i < 10; i++) begin
      arr[i] = 100*i;
    end 
    $display("elements in array after memory allocation and writing into array: %0p", arr);
    
    arr.delete();
    $display("elements in array after performing delete %0p", arr); // arry is empty
    
    arr = new[3]; // allocate memeory using new method new[];
    for ( int i =0; i < 3; i++) begin
       arr[i] = 500*i;
      $display("elements in array after new memory allocation and writing different elements %0p", arr);
    end
  end 
endmodule 

///////////////////////////////////////  DYNAMIC MEMORY ALLOCATION- change to new size will delete old array elements//////////////////////////////

module tb;
  int arr[]; // Declaring, no need to specify size
  
  initial begin 
    $display("elements in array before memory allocation: %0p", arr); // array is empty
    arr = new[5]; // Allocating memory 
    for ( int i =0; i < 5; i++) begin
      arr[i] = 5*i;
    end 
    $display("elements in array after memory allocation and writing into array: %0p", arr);
    
    arr = new[30]; // allocate memeory using new method new[]; // this will delete all the elements in array and overrides with all "0"
    $display("elements in array after NEW memory allocation: %0p", arr);
  end 
endmodule 

//output:
//elements in array before memory allocation `{}
//elements in array after memory allocation and writing into array: 5 10 15 20 25
//elements in array after NEW memory allocation: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

///////////////////////////////////////  DYNAMIC MEMORY ALLOCATION- change to new array with the existing array elements//////////////////////////////

module tb;
  int arr[]; // Declaring, no need to specify size
  
  initial begin 
    $display("elements in array before memory allocation: %0p", arr); // array is empty
    arr = new[5]; // Allocating memory 
    for ( int i =0; i < 5; i++) begin
      arr[i] = 5*i;
    end 
    $display("elements in array after memory allocation and writing into array: %0p", arr);
    
    arr = new[30](arr); // to keep the existing array elements and append with rest "0"
    $display("elements in array after NEW memory allocation: %0p", arr);
  end 
endmodule 

//output:
//elements in array before memory allocation `{}
//elements in array after memory allocation and writing into array: 5 10 15 20 25
//elements in array after NEW memory allocation: 0 5 10 15 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

///////////////////////////////////////  DYNAMIC MEMORY COPY FIXED SIZE ARRAY//////////////////////////////
module tb;
  int dyn_arr[]; // Declaring, no need to specify size
  int fix_arr[30]; // fixed size array
  
  initial begin 
    dyn_arr = new[5]; // Allocating memory for dynamic array
    for ( int i =0; i < 5; i++) begin
      dyn_arr[i] = 5*i;
    end 
    $display("elements in array after memory allocation and writing into array: %0p", dyn_arr);
    
    dyn_arr = new[30](arr); // to keep the existing array elements and append with rest "0"
    $display("elements in dynamic array: %0p", dyn_arr);
    
    fix_arr = dyn_arr;
    $display("elements in after copied from dynamic to fixed size array: %0p", fix_arr);
    
  end 
endmodule 

//output:
//elements in array after memory allocation and writing into array: 5 10 15 20 25
//elements in dynamic array: 0 5 10 15 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
//elements in after copied from dynamic to fixed size array: 0 5 10 15 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
