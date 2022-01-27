#include <bits/stdc++.h>
#include "strhelper.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
using namespace std;
int maxn, * src, * sorted, err_detecter;
__global__ void numAdd(int* a, int* f)
{
	int i = threadIdx.x + blockIdx.x * blockDim.x;
	//atomicAdd(&f[i], 1);
}
extern "C" int sort_3()
{
	printf("Choose one way to test: \n");
	printf("\t1. Type in all data.\n");
	printf("\t2. Use random data produced by computer.\n");
	printf("Your selection: ");
	string in;
	getline(cin, in);
	int chosen = int_parse(&in);
	switch (chosen)
	{
		case 1:
			printf("Type the max num of the data: ");
			err_detecter = scanf("%d", &maxn);
			src = new int[maxn], sorted = new int[maxn];
			printf("Array init ...\nType your data one by one separated by space:\n");
			for (int i = 0; i < maxn; ++i) err_detecter = scanf("%d", &src[i]);
			printf("Data inputing ended !\n");
			break;
		case 2:
			printf("Starting generate random data ...\n");
			maxn = 10000000;
			src = new int[maxn], sorted = new int[maxn];
			memset(sorted, 0, sizeof(int) * maxn);
			srand(time(0));
			for (int i = 0; i < maxn; ++i) src[i] = rand() % 100000;
			printf("Random data generated !\n");
			break;
		default: printf("No this selection.\n"); break;
	}
	int* d_src, * d_rst;
	#pragma region CUDA
	cudaMalloc((void**)&d_src, sizeof(int) * maxn);
	cudaMalloc((void**)&d_rst, sizeof(int) * maxn);
	cudaMemcpy(d_src, src, sizeof(int) * maxn, cudaMemcpyHostToDevice);
	cudaMemcpy(d_rst, sorted, sizeof(int) * maxn, cudaMemcpyHostToDevice);
	numAdd << <1000, 10000 >> > (d_src, d_rst);
	#pragma endregion
	delete[] src, sorted;
	return 0;
}