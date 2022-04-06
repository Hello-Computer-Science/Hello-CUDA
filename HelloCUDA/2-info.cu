#include <bits/stdc++.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
using namespace std;
extern "C" int info_2()
{
    int device_Count = 0;
    cudaGetDeviceCount(&device_Count);
    if (device_Count == 0)
    {
        printf("There are no available device(s) that support CUDA\n");
    }
    else
    {
        printf("Detected %d CUDA Capable device(s)\n\n", device_Count);
        for (int i = 0; i < device_Count; i++)
        {
            cudaDeviceProp deviceProp;
            cudaGetDeviceProperties(&deviceProp, i);
            int driverVersion = 0, runtimeVersion = 0;
            cudaDriverGetVersion(&driverVersion);
            cudaRuntimeGetVersion(&runtimeVersion);
            printf("Device %d: \"%s\"\n", i + 1, deviceProp.name);
            printf("\tCUDA Driver Version / Runtime Version: %d.%d / %d.%d\n",
                driverVersion / 1000, (driverVersion % 100) / 10,
                runtimeVersion / 1000, (runtimeVersion % 100) / 10);
            printf("\tTotal amount of global memory: %lld MB (%lld Bytes)\n",
                deviceProp.totalGlobalMem / 1024 / 1024, deviceProp.totalGlobalMem);
            printf("\tCUDA Capability Major/Minor version number: %d.%d\n",
                deviceProp.major, deviceProp.minor);
            printf("\tGPU Clock rate: %.0f MHz (%0.2f GHz)\n",
                deviceProp.clockRate * 1.0 * 1e-3f, deviceProp.clockRate * 1.0 * 1e-6f);
            printf("\tMemory Clock rate: %d Mhz\n", deviceProp.memoryClockRate / 1024);
            printf("\tMemory Bus Width: %d-bit\n", deviceProp.memoryBusWidth);
            if (deviceProp.l2CacheSize)
                printf("\tL2 Cache Size: %d bytes\n", deviceProp.l2CacheSize);
            printf("\tMax Texture Dimension Size (x,y,z): 1D=(%d), 2D=(%d, %d), 3D=(%d, %d, %d)\n",
                deviceProp.maxTexture1D, deviceProp.maxTexture2D[0], deviceProp.maxTexture2D[1],
                deviceProp.maxTexture3D[0], deviceProp.maxTexture3D[1],
                deviceProp.maxTexture3D[2]);
            printf("\tMax Layered 1D Texture Size, (num) layers: 1D=(%d) x %d\n",
                deviceProp.maxTexture1DLayered[0], deviceProp.maxTexture1DLayered[1]);
            printf("\tMax Layered 2D Texture Size, (num) layers: 2D=(%d,%d) x %d\n",
                deviceProp.maxTexture2DLayered[0], deviceProp.maxTexture2DLayered[1],
                deviceProp.maxTexture2DLayered[2]);
            printf("\tTotal amount of constant memory: %lld bytes\n", deviceProp.totalConstMem);
            printf("\tTotal amount of shared memory per block: %lld Bytes\n",
                deviceProp.sharedMemPerBlock / 1024);
            printf("\tTotal number of registers available per block: %d\n",
                deviceProp.regsPerBlock);
            printf("\tWarp size: %d\n", deviceProp.warpSize);
            printf("\tMaximum number of multiprocessors: %d\n", deviceProp.multiProcessorCount);
            printf("\tMaximum number of threads per multiprocessor: %d\n",
                deviceProp.maxThreadsPerMultiProcessor);
            printf("\tMaximum number of threads per block: %d\n", deviceProp.maxThreadsPerBlock);
            printf("\tMaximum sizes of each dimension of a block:  %d x %d x %d\n",
                deviceProp.maxThreadsDim[0], deviceProp.maxThreadsDim[1],
                deviceProp.maxThreadsDim[2]);
            printf("\tMaximum sizes of each dimension of a grid:  %d x %d x %d\n",
                deviceProp.maxGridSize[0], deviceProp.maxGridSize[1], deviceProp.maxGridSize[2]);
            printf("\tMaximum memory pitch %lld bytes\n", deviceProp.memPitch);
        }
    }
    return 0;
}