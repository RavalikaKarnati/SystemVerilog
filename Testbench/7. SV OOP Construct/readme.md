STUDY ORDER:   
class.sv   
Task.sv   
function.sv   
PassByValue&PassByRef.sv   
UsingArrayInFunction.sv   
function_in_class.sv   
Task_in_class.sv   
class_in_class.sv  



The fundamental construct that we use in building the components of SystemVerilog is the class construct,   
<img width="1056" height="608" alt="image" src="https://github.com/user-attachments/assets/bf5b7fcf-0b67-4547-b952-453716c99cf4" />

**1. DATAMEMBERS**:  

**CONSTRUCTOR** : when a constructor is added to a class, all data members are initialized to default values based on their types.    
                 Eg: f = new();  // f is  handler and new() is a construct  
                 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**2. CLASS METHODS**:
we can add class method using 1. TASK    2. FUNCTIONS                                  
<img width="517" height="147" alt="image" src="https://github.com/user-attachments/assets/2d74d08e-63f9-4552-ae3b-631737f12bc1" />

FUNCTION: A function definition shlould have return Data type( atleast void return type). also function with arguments in it should have, Arguments Direction, Arguments Data type  
          Arguments Default Direction : as "Inputs" for both Task & Functions   

FUNCTION DEFINITION Syntax: 
function data_type_of_return_value function_name( direction data_type argument_1, direction data_type argument_2 );   
endfunction;  

TASK DECLARATION:  
task task_name (Direction data_type argument_1,Direction data_type argument_2); 
endtask;  
Task can be used: TIme depedent expressions, Scheduling processes in class.  
functions can be used : Printing values of Data members, initializing values of variables, TIme independent expressions, return data from class.  

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**3. PASS BY VALUE & PASS BY REFERENCE:**
_PASS BY VALUE_: When we call a task with any variables(defined in main program), the arguments inside task/function definition locally creates copy(memory) of those variables and once execution of task/function is completed that memory is cleaned up. So if any changes or updates done to the arguments of the Task/function by the execution of that task/function will not reflect at the variables(defined in main program) that we used to call the task. This is becuase of PASS BY VALUE.  
So, Whenever we use pass by value while calling Task/function it creates a copy of passed variable values locally in a stack.  

The fundamental thing is, for a function or task using pass by value, we have an independent stack storing local copies of the variables. Those will be incremented, or updated, but the variables in the main program   
or test bench stack have a different stack. They will not see any changes or updates as we only update the function's local copies.   

Eg:
task add( int x, int y);
x = x+5;      // we are trying to chnage the value of X which is passed from main program "a" where task is called. But here we are not changing the value "a" in the main program. That is refred as "PASS BY VALUE"
              // Even though we update x here by incrementing it by 5, whatever value the user specifies, since these are local to the function, even though we update the argument, the changes won’t be reflected in the                 // variables present in the main program. Here in the main program, it will still be a and b.  
sum = x+y;
endtask;

task(a,b); // a--> x, b --> y

<img width="541" height="247" alt="image" src="https://github.com/user-attachments/assets/cf6cbcfc-c6e6-4610-bff6-c801473a5ba7" />


_PASS BY REFERENCE_(ref keyword): When we call a task with any variables(defined in main program), the arguments inside task/function definition are nothing but pointers which are storing/refering to the address of variables (defined in main program). So, any update/changes done by execution of task/function also reflects at the variables(defined in main program). This is PASS BY REFERENCE

Eg:  we prefer PASS BY REFERENCE when working with arrays where you want to update the array after processing
   function automatic void init_arr(ref bit[3:0] x[15]);  
   endfunction  
Eg: But there might be situation where you want to restrict task or function from changing the value so you use **"const ref int a[]"**   
    task automatic add(const ref bit [1:0] a, b) endtask    
    function automatic bit [1:0] add( const ref  bit [1:0] a, b) endfunction   
Eg:
task automatic add( ref int x, int y);
x = x+5;      // 
              //    
              //  
sum = x+y;
endtask;

task(a,b); // a--> x, b --> y

**NOTE:** If we are using ref inside an arguments (replacing Direction of the argument)and also Task type should be of automatic task / automatic function. whenever you use pass by reference, you need to add automatic   storage for your task and function. that is, after the keyword that is function or task, you need to add the automatic keyword   

task automatic add( ref bit [1:0] a, b) endtask   
function automatic bit [1:0] add( ref  bit [1:0] a, b) endfunction   

![IMG_2060](https://github.com/user-attachments/assets/3b18f2e5-25d4-4177-969d-1dd1336ed758)  

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------          
**4.CUSTOM CONSTRUCTOR:**
Will start using Functions and Task inside a class   
(A) SPECIAL FUNCTION in SV: that won't need any return type(also we don't to use void)  
function new();  
endfunction  
(B) SPECIAL FUNCTION with 1 argument in it and PASSING 1 value from CONSTRUCTOR itself  
(C) this.class_datamember operator: SPECIAL FUNCTION with many arguments and arguments name is same as data memebers name in class.  
when we wan't to use same name for data members of class and arguments then to refer/differentiate to a data member of a class we use this.class memeber keyword  
(D) When We have multiple arguments, how do we specify or recognize the sequence of arguments while calling the functions:,  
a) we could follow the position based b) name based with help of "." (like we use during module instantiation)  
(E) Using Task inside a class and accessing it  
(F) Basic function inside a class and accessign it  

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------          
**5.COPYING OBJECT:**  

 <img width="752" height="372" alt="image" src="https://github.com/user-attachments/assets/817dfe8e-7ade-4155-8fb8-9f4922467648" />

 1. NORMAL COPY: Create a new classvariable/handler and add a constructor to the exisiting handler that keeps the original
                  first f1;
                  first f2;  
                  f1 = new ();
                  f2 = new f1; // creates a new copy               
 3. CUSTOM COPY METHOD: interested in copying only data members  
                    we can use this method and above normal method when we don't have class inside a clasS. HOW TO CREATE CUSTOM COPY METHOD?
                   i. Add function inside class and Refer to add a constructor to the function name.   
                   ii. So this will create an object, and once you have an object, you could just replace the data members of that object with the data of a claSS.  
                   iii. In the testbench, you'll just call the custom method (function) that we have added, and this will return an object which we will store in the object where we want to keep the data. 
 5. SHALLOW COPY:   Data members + other class isntance --> you get a copy of a data member, but the class handler for both the original, as well as the copied class remains the same.
 6. DEEP COPY:      Data members + other class isntance --> you get a copy of a data member as well as class handler for both the original and the copied class.
  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------          
**6.INHERITANCE:**  
In some situations,we might need to compute intermediate data to debug whether the stimulus is correctly going to a DUT or to inject an error into the stimulus that we are sending to a DUT. In that case, we require access to all the data members as well as the properties which are present in the generated class, and along with that, we will be modifying or adding certain properties into the new class that will help us to add more capabilities to the stimulus that we are generating, To achieve this, we utilize **INHERITANCE**

keyword **"EXTENDS"** is used to extend class that will inherit the properties as well as the data members of the class which we are extending.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------          
**7.POLYMORPHISM:**  

