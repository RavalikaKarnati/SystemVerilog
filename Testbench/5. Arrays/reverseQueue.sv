//Create a Fixed-size array capable of storing 20 elements. Add random values to all the 20 elements by using $urandom function. 
//Now add all the elements of the fixed-size array to the Queue in such a way that the first element of the Fixed-size array should be the last element of the Queue. 
//Print all the elements of both fixed-size array and Queue on Console.

module fix_arry_queue();

int fix_arr[20];

int queue_arr[$];

// foreach (fix_arr[i]) begin
//      fix_arr[i] = $urandom;
// // end
// $display("fixed size array: %0p", fix_arr)

for ( int i=0; i<20; i++ ) begin
  fix_arr[i] = $urandom;
//queue_arr[i] = fix_arr[fix_arr.size() - 1 -i];
  queue_arr.push_front(fix_arr[i]);
end
 $display("fixed size array: %0p", fix_arr)
 $display("queue array: %0p", queue_arr)

endmodule

// output:
// fixed size array: 1 2 3 4 5 6 . . .. 19 20
// queue array: 20 19 18 . .. ..  6 5 4 3 2 1
