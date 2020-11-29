#include <bits/stdc++.h>


#define SIZE 100

int main()
{
	static double A[SIZE][SIZE];
	static double B[SIZE][SIZE];
    static double D[SIZE][SIZE];
	for(int i=0; i<SIZE; i++){
		
		for(int j=0; j<SIZE; j++){
			A[i][j] = 0;
			B[i][j] = 0;
            D[i][j] = 0;
            printf("1 %x\n",&A[i][j]);
			printf("1 %x\n",&B[i][j]);
			printf("1 %x\n",&D[i][j]);
		}
        D[i][0] = i;
		B[i][i] = 2;
	}

	for(int i=0; i<SIZE; i++){
		for(int j=0; j<SIZE; j++){
			for(int k=0; k<SIZE; k++){
				A[i][j] = A[i][j] + B[i][k]*D[j][k];
                printf("0 %x\n",&A[i][j]);
				printf("0 %x\n",&B[i][k]);
				printf("0 %x\n",&D[j][k]);
				printf("1 %x\n",&A[i][j]);
			}
		}
	}


	return 0;
}