
1. **Verification Plan**:
   - Verification Process starts with a verification plan. Let's say if we are verifying a single-port RAM, First we need to go through the specification sheet for the RAM which consists of the entire behavior of the RAM            along with necessary waveforms that predict the behavior of the RAM and Analyzing the waveform  
   - once we successfully verify the basic functionality of the DUT, we can proceed to add complex scenarios to verify more intricate behaviors   
   - Understaning Verification is very Important          
       - Three main parts of Verification plan are  
           1. Testcase  -  The first step is to list the signals present in the DUT ( That means we are defining the testcase for each port) considering the waveform, we identify their respective behaviors
           2. Description - The description explains what we are doing in that testcase. In a verification plan, each test case represents a signal and the specific condition applied to the DUT.    
                          - The description indicates the specific values applied to the DUT    
           3. Feature Covered - what feature is covered by running this testcase  
              
Summary: The process starts with a specification sheet. By analyzing the specification sheet, you recognize all the signals in the DUT and their behaviors. By analyzing the waveforms in the specification sheet, you can understand the system's behavior. The next step is to prepare the verification plan.This involves listing important features to test the basic functionality of the design. A series oftest cases are listed to apply to the DUT. For each test case, the description specifies what to do. For instance, for the reset signal, the description details the values of reset to apply to the DUT and the specific situations in which to apply them. This represents the description. The expected behavior upon applying the signal to the DUT represents the feature covered.  

For CRV: we have few extra features that we add to the Verifictaion Plan. Define Covergroup for each testcase
<img width="306" height="337" alt="image" src="https://github.com/user-attachments/assets/64e8d4e0-dc74-4ee7-bbc0-7cfe81c0ff09" />

Once the verification plan is ready, there are two alternatives for applying tests to the DUT.   

2. **Types of Verifictaion**:
   Once the verification plan is ready, the next step is to choose the type of test to perform. There are two types of tests.
     1. Directed Tests
     2. Random Tests
     3. Constrained Random Tests
**DIRECTED TESTS**:
   - We take testcase1 and apply to the DUT one by one and then anaylze the response. Once the design is behaving correctly for the testcase1, we consider this testcase1 as PASS athen move to the next testcase2.
   - We apply the next testcase2 to DUT, analyze, once the design behaves correctly, consider as PASS.
   - This method of applying test cases to a DUT is referred to as a DIRECTED TESTS.
   - Disadvantages:
   - If the design is simple and you have less number of testcase then DT is good, but as no. of testcases increases and the time span to verify the complete behavior of a DUT decreases, we have an alternative method             referred to as a constrained random tests.
     
**CONSTRAINED RANDOM TESTS**:   
   - Here now we won't apply each and every test case to the DUT. Instead, we will develop a cover group for each test case. For every test case, we create an independent cover group.
   - In each cover group, we list the levels of signals expected for a that specific test case.
