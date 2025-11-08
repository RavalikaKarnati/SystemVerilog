
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
     <img width="577" height="341" alt="image" src="https://github.com/user-attachments/assets/7566c3cb-4ad0-4258-b96d-b8459195e1c2" />

**CONSTRAINED RANDOM TESTS**:   
   - Here now we won't apply each and every test case to the DUT. Instead, we will develop a **covergroup** for each test case. For every test case, we create an independent cover group.
   - In each cover group, we list the levels of signals ( also called as **coverpoints** ) expected for a that specific test case.
   - we write a cover group and compute the functional coverage, ensuring the targeted signal values are covered or not. For example, when wr==1, we get a hit here, and for an address from 0 to 10, we get a hit there. If      all cover points are covered, it means the signal values expected in testcase1 were successfully applied to the DUT. Without applying the test case, just analyzing the cover group and its hits allows us to                verify if the testcase was applied to the DUT.
   - In constrained random testing, we use a **random signal generator**, usually with **constraints**, to get the values we are expecting. These signals are applied to the DUT, and the DUT's response is analyzed using a scoreboard to check for correctness. Additionally, functional coverage is calculated based on the verification plan. Depending on the random signals generated, we analyze the hits for the specific cover group to verify test case coverage. If not all test cases are covered initially, constraints are modified, and the process is repeated until all test cases are covered.
<img width="936" height="747" alt="image" src="https://github.com/user-attachments/assets/44e5bf06-ffc4-4cd3-bc1d-9108e6296921" />

**DIRECTED TESTS VS CONSTRAINED RANDOM TESTS**
- Comparing DT to CRT, DT proceeds incrementally test case1, then the second, third, and so on. This takes a finite amount of time to achieve 100% verification. In CRT, developing the functional coverage model consumes some time initially. However, with an optimized setup, we may achieve 100% functional coverage in the first attempt, verifying all expected functionalities. Thus,constrained random testing is generally much faster compared to directed testing.
- Eg: Testcase1: wr --> high --> wr =1,  addr = 8bit 0 to 255, din = 8bit (0 to 255)  
                 In DT, we focus on valid values of wr, addr, din and apply to the DUT. We check all possible values by manually specifying the testcase is bit difficult. And we will never be considering the corner cases                  when we have a directed test case, and that basically gives us a possibility to keep some of the bugs present in our design. For example, let us assume when wr=1, and the address value consists of one                     of the bits having an undefined value (X), and D in is having some valid value, Such cases could not be tested by a directed test case. because DV engineer predominantly focus on wr=1 and valid values                     for the addr ( 0 TO 255) and DIN ( 0 TO 255).So such corner cases, when the address has one undefined bit, similarly, one bit of D in is unknown, will not be tested. This leads to some of the hidden bugs                  present in the design
  - But in CRT, when we generate random signals for wr, addr, din. we add constraints to such scenerios that are never expected to happen with DT. We generate random values where wr=1 or wr is also undefined, addr and         din consists of undefined values and see how system responds or all of them unknown values. That is the advantage of Random Testing w.r.t DT. But it takes infinite time to test all the random genearted values. That      is why we refer as constraint random testing where we will not generate all the possible random values but add constraints to generate minimum no. of random tests.
  - How do we choose the min no. of random tests ? That is decided by the functional coverage. our goal is 100% FC.
  - Even though we generate random values, it will not be pure random generation or generate all possible combinations for the signal in a test case. Instead, we add constraints to the values generated for a test case,       and the number of random values sent to a DUT after adding constraints. We add constraints to the signals, then start generating values, apply to a DUT. But how many random values should be sent to a DUT to correctly     verify system behavior depends on functional coverage. As long as we do not get 100% functional coverage, we will continuously add new constraints, generate random values, and stop when we reach 100%. That decides        the number of random stimuli, as well as constraints applied to DUT
  - 
