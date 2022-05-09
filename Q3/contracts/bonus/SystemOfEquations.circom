pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib-matrix/circuits/matMul.circom"; // hint: you can use more than one templates in circomlib-matrix to help you
include "../node_modules/circomlib-matrix/circuits/matElemSum.circom";

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    // [bonus] insert your code here
    component ax = matMul(n,n,1);
    component sum = matElemSum(n,1);
    
    for(int i = 0; i < n; ++i)
    {
        for(int j = 0; j < n; ++j)
        {
            ax.a[i][j] <== A[i][j];
        }
        ax.b[i][0] <== x[i]; // Calculate Ax
        sum.a[i][0] <== ax.out[i][0] === b[i] ? 1 : 0; //Compare values ax and b,
                                                     // and store in sum
    }
    out <== sum.out === n ? 1 : 0;  // If sum is equal to n, means all matched
}

component main {public [A, b]} = SystemOfEquations(3);