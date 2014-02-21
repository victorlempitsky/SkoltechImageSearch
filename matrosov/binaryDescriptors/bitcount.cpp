#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[],
                int nrhs, const mxArray *prhs[]) 
{
    #define OUT plhs[0]
    #define IN1 prhs[0]
    #define IN2 prhs[1]
    
    if(nlhs<1 || nrhs<2) {
        mexErrMsgTxt("Requires 2 input arguments of type int32 and 1 output int32");
        return;
    }
    
    int M = mxGetM(IN1);
    int N = mxGetN(IN1);
    
    int *A = (int *)mxGetData(IN1);
    int *B = (int *)mxGetData(IN2);
    
    OUT = mxCreateNumericMatrix(M, N, mxINT32_CLASS, 0);
    int *C = (int *)mxGetData(OUT);
    
    int R = M*N;
    for(int i=0; i<R; i++) {
        C[i] = __builtin_popcount( A[i]^B[i] );
    }
}
