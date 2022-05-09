pragma circom 2.0.0;

// [assignment] Modify the circuit below to perform a multiplication of three signals

template Multiply () {
   signal input a;
   signal input b;
   signal output out;

   out <== a*b;
}

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   signal output d; 

   component m1 = Multiply();

   a ==> m1.a;
   b ==> m1.b;
   d <== c * m1.out;
}

component main = Multiplier3();