- /////////////////////_____Two ways of Declaration of Arrays__________//////////////////////////
1. bit arr1[8];             // specify the size when declaring an array --> creates an array capable of storing 8 elements  
2. bit arr2[] = {1,0,1,1}   // you do not specify the size, but provide an initial value for the elements, Based on the initial value compiler will predict the size of array    

bit arr2[]; if you don't specify the size or provide any initial value. what happens when writing to the array?  
initial begin      
   arr2[0] = 1;     
   $display("elements of an array2: %0p", arr2); // Gives warning by saying that array is empty and index 0 is out of range.   
end  

- /////////////////////_____Four ways of Array Initialization__________//////////////////////////  
<img width="1180" height="446" alt="image" src="https://github.com/user-attachments/assets/414e755f-e67b-402d-b075-3d233335655b" />  

1. Unique Values   arr[] = `{1,2,3,4}  
2. Repetitive Values arr = 1{ 6{1} }  
3. Default Value  = `{default : 0}  
4. Un-initialized = arr[8];  // if the datatype is 2-state , All elements are initilazied to "0" else 4-state initialized to "X"  
     eg1: bit arr[5] ;  
         $display("array: %0p",arr); // console shows "arry: 0 0 0 0 0"  
     eg2: logic arr[5] ;  
         $display("array: %0p",arr); // console shows "arry: x x x x x"

- /////////////////////_____REPITITIVE OPERATIONS__________//////////////////////////
<img width="776" height="322" alt="image" src="https://github.com/user-attachments/assets/3c63437c-3ae7-49dc-86ac-63d8adc30d40" />
1. **For loop** ::                                      <br/>
    ex->          arr[10];                              <br/>
          initial begin                                 <br/>
            **for ( int i =0; i < 10 ; i++)** begin     <br/>
               arr[i] =i;                               <br/>
            end                                         <br/>
           end                                          <br/>
3. **repeat** ::                                        <br/>
     ex->      int i=0; arr[10];                        <br/>
         initial begin                                  <br/>
             **repeat(10)** begin                       <br/>
               arr[i] = i;                              <br/>
               i++;                                     <br/>
             end                                        <br/>
          end                                           <br/>
5. **foreach** :: mostly used for an arrays                                      <br/>
      ex->     arr[10];                                 <br/>
             initial begin                              <br/>
                   **foreach(arr[j])** begin    // j referring to elements in array goes from 0 to 9(since we declared arr with 10       <br/>
                      arr[j] = j;                       <br/>
                      end                               <br/>
              end                                       <br/>
- ////////////////////_______operation of ARRAY___________///////////////////////////////
-COPY::: Storing entire elements in an array into different array.[arr_2 = arr_1]   

-COMPARE::: COmparing element by element between two arrays.[ (arr_1 == arr_2) or (arr_1 != arr_3) these two return True or false since these are equality and inequality comparision]  
( ex: comparing o/p results of DUT and expected outputs in a scorboard) Conditions to do COPY and COMPARE: Both arrays should have same array data type and size (number of elements).  

////////////////////______Type of ARRAYS_________///////////////////// 
1. **Fixed Type Array** 
   - int arr[8];
   - int arr[] = {1,2,3,4};
2. **Dynamic Array**   
   - int arr[];  // For a Dynamic array, no need to specify the size but if we don't specify if give so what to we do? we specify the size dynamically using a menthod new[];
   - arr = new[8]; // while creating a constructor/object of a class we use " new( ) " , but here we use " new[ ] " to declare size of an array.
3. **Queue**

////////////////////______How we use arrays in SystemVerilog?_________///////////////////// 

<img width="411" height="286" alt="image" src="https://github.com/user-attachments/assets/6d524cfc-ba39-483b-b129-7de5fa97feb7" />  

For testing the DUT, we will be generating a number of stimuli (Generator), that will be sent to the driver and then finally applied to the DUT. Then the monitor will collect the response from the DUT, and all the responses that we have for all the multiple stimuli that the generator generates will be collected in a scoreboard.    

So for each unique transaction in the generator will be applied to the DUT, and then it will be stored in a scoreboard, which could be further compared with golden data  
To collect the multiple transactions of the same type, we need to have an array.



