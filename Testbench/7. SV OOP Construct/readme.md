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

------------------------------------------------
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

_PASS BY REFERENCE_(ref keyword): When we call a task with any variables(defined in main program), the arguments inside task/function definition are nothing but pointers which are storing/refering to the address of variables (defined in main program). So, any update/changes done by execution of task/function also reflects at the variables(defined in main program). This is PASS BY REFERENCE

Eg:  we prefer PASS BY REFERENCE when working with arrays where you want to update the array after processing
   function automatic void init_arr(ref bit[3:0] x[15]);  
   endfunction  
Eg: But there might be situation where you want to restrict task or function from changing the value so you use **"const ref int a[]"**
Eg:
task automatic add( ref int x, int y);
x = x+5;      // 
              //    
              //  
sum = x+y;
endtask;

task(a,b); // a--> x, b --> y

**NOTE:** If we are using ref inside an arguments (replacing Direction of the argument)and also Task type should be of automatic task / automatic function.
          task automatic add( ref bit [1:0] a, b) endtask  
          function automatic bit [1:0] add( ref  bit [1:0] a, b) endfunction  
   
