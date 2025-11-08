///////////////////////////////////////  DAYNAMIC MEMORY ALLOCATION, DELETE ELEMENTS IN ARRAY , Again DYANMIC MEMORY ALLOCATION with DIFFERENT SIZE//////////////////////////////


module tb;
  int arr[]; // Declaring, no need to specify size
  initial begin 

    $display("elements in array before memory allocation %p", arr); // array is empty

    arr = new[10]; // Allocating memory 
    for ( int i =0; i < 10; i++) begin
      arr[i] = 100*i;
    end
    
    $display("elements in array after memory allocation and writing into array%p", arr);
    arr.delete();
    $display("elements in array after performing delete %p", arr); // arry is empty
    arr = new[3]; // allocate memeory using new method new[];
    for ( int i =0; i < 3; i++) begin
       arr[i] = 500*i;
    $display("elements in array after new memory allocation and writing different elements %p", arr);
    end
  end 
endmodule 
