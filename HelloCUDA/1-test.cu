#include <bits/stdc++.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
using namespace std;
const int maxn = 1000000; // 元素值上限 - 一百万
const int maxl = 1000000; // 数组长 - 一百万
int* h_a, * h_b, * h_sum, * h_cpusum, tot = 0; // 数据指针
clock_t pro_start, pro_end, sum_start, sum_end; // CPU 时钟计数
cudaEvent_t e_start, e_stop; // CUDA 性能测试点
__global__ void numAdd(int* a, int* b, int* sum) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    sum[i] = a[i] + b[i];
}
extern "C" int test_1() {
    srand(time(0)); // 设定随机数种子
    h_a = new int[maxl], h_b = new int[maxl], h_sum = new int[maxl], h_cpusum = new int[maxl]; // 动态分配内存
    pro_start = clock();
    for (int i = 0; i < maxl; ++i) {
        h_a[i] = rand() % maxn; h_b[i] = rand() % maxn; // 初始化随机数据
    }
    pro_end = clock();
    // 输出 生成随机数 用时 （由于 CUDA 上无法完成随机数的初始化，遂不进行对比）
    printf("produce %d random number to two array use time : %0.3f ms\n", maxl, double(pro_end - pro_start) / CLOCKS_PER_SEC * 1000);
    system("pause");
    int* d_a, * d_b, * d_sum;
    cudaEventCreate(&e_start); cudaEventCreate(&e_stop); // 创建 CUDA 事件
    cudaEventRecord(e_start, 0); // 记录 CUDA 事件
    // 在显存上分配单元
    cudaMalloc((void**)&d_a, sizeof(int) * maxl);
    cudaMalloc((void**)&d_b, sizeof(int) * maxl);
    cudaMalloc((void**)&d_sum, sizeof(int) * maxl);
    /*printf("memory allocated!\n");*/
    // 拷贝内存数据到显存
    cudaMemcpy(d_a, h_a, sizeof(int) * maxl, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, sizeof(int) * maxl, cudaMemcpyHostToDevice);
    /*printf("copy finished!\n");*/
    numAdd << <1000, 1000 >> > (d_a, d_b, d_sum); // 调用 Kernel 函数传入参数并执行代码
    cudaDeviceSynchronize(); // 同步GPU上的所有线程，等待所有线程结束后再继续
    /*printf("sum finished!\ncopy backing...\n");*/
    cudaMemcpy(h_sum, d_sum, sizeof(int) * maxl, cudaMemcpyDeviceToHost); // 从显存拷贝结果数据到内存
    /*printf("copy backed!\n");*/
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_sum); // 释放GPU上分配的显存
    /*printf("device RAM released!\n");*/
    cudaEventRecord(e_stop, 0); cudaEventSynchronize(e_stop); // 记录用时
    float elapsedTime;
    cudaEventElapsedTime(&elapsedTime, e_start, e_stop);
    printf("CUDA sum use time : %0.3f ms\n", elapsedTime);
    sum_start = clock();
    for (int i = 0; i < maxl; ++i) h_cpusum[i] = h_a[i] + h_b[i]; // CPU 进行加法计算
    sum_end = clock();
    printf("CPU  sum use time : %0.3f ms\n", double(pro_end - pro_start) / CLOCKS_PER_SEC * 1000);
    for (int i = 0; i < maxl; ++i) if (h_cpusum[i] != h_sum[i]) ++tot; // 检验 CPU 计算结果 与 GPU 计算结果是否一致，统计不一致个数
    printf("error sum num : %d\n", tot);
    system("pause");
    delete h_a; delete h_b; delete h_sum; // 释放内存
    return 0;
}