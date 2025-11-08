//////////////////////////// BASIC QUEUE DECLARATION /////////////////////////////////

module tb;
  int arr[$]; // declaring queue
 initial begin 
   arr = {1,2,3,4,5};
   $display("elements in queue %0p",arr);
  end 
endmodule 




////////////////////////// DATA MANUPULATIONS on to the Queue ///////////////////////
module tb;
  int arr[$]; // declaring queue
  int x=0;
  
 initial begin 
   ///////////////////////////// ADDING ELEMENTS INTO A QUEUE///////////////////////////////
   arr = {1,2,3,4,5};
   $display("elements in queue %0p",arr);
   
    ///////////////////////////// PUSHING ELEMENT AT FRONT OF QUEUE///////////////////////////////
   arr.push_front(6);      // pushes the element at front( zeroth index)
                           // syntax: arr.push_front(element);
   $display("elements in queue after pushing element at front %0p",arr);
   
     ///////////////////////////// PUSHING ELEMENT AT BACK OF QUEUE///////////////////////////////
   
   arr.push_back(7);         // pusshes the element at back(max index)
                             // syntax: arr.push_back(element);
   $display("elements in queue after pushing element at back %0p",arr);
   
      ///////////////////////////// REMOVES ELEMENT AT FRONT OF QUEUE///////////////////////////////
   x = arr.pop_front();      // removes the element at front of queue
   $display("elements in queue after popping front %0p and poped element is %0d",arr,x);
   
     ///////////////////////////// REMOVES ELEMENT AT BACK OF QUEUE///////////////////////////////
   x= arr.pop_back();       // removes the element at back of queue
   $display("elements in queue after popping front %0p and poped element is %0d",arr,x);
   

     ///////////////////////////// INSERT ELEMENT AT SPECIFIC INDEX OF QUEUE///////////////////////////////
   arr.insert(2,8);        // adding the element at nth index and moves existing elements right 
                           // syntax: arr.insert(index_number,element);
   $display("elements in queue after insert at index-2 :%0p",arr);

    ///////////////////////////// DELETE ELEMENT AT SPECIFIC INDEX OF QUEUE///////////////////////////////
   arr.delete(2);           // specifically delete element at nth index
                            // syntax: arr.delete(index_number);
   $display("elements in queue after delete at index-2 :%0p",arr);

   
  end 
endmodule 


// OUTPUT: 
// # KERNEL: elements in queue 1 2 3 4 5
// # KERNEL: elements in queue after pushing element at front 6 1 2 3 4 5
// # KERNEL: elements in queue after pushing element at back 6 1 2 3 4 5 7
// # KERNEL: elements in queue after popping front 1 2 3 4 5 7 and poped element is 6
// # KERNEL: elements in queue after popping front 1 2 3 4 5 and poped element is 7
// # KERNEL: elements in queue after insert at index-2 :1 2 8 3 4 5
// # KERNEL: elements in queue after delete at index-2 :1 2 3 4 5
