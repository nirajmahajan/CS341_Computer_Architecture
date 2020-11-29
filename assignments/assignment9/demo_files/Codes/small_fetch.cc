#include <bits/stdc++.h>


#define SIZE 257

int main()
{
	static int A[SIZE];

	for(int i=0; i<SIZE; i++){

		A[i] = 0;
		printf("1 %x\n",&A[i]);

	}

	for(int i=SIZE-1; i>-1; i--){

		A[i] = A[i] + 1;

		printf("0 %x\n",&A[i]);
		printf("1 %x\n",&A[i]);

	}

	return 0;

}

