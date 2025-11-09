The fundamental construct that we use in building the components of SystemVerilog is the class construct,   
<img width="905" height="497" alt="image" src="https://github.com/user-attachments/assets/1f3b18ac-bd95-4a80-8402-b452a233bcae" />

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



---------------------------------------
