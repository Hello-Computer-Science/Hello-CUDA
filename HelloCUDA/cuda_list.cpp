#include <bits/stdc++.h>
#include "helper.h"

using namespace std;

typedef int (*funcp)();

extern "C" int test_1();
extern "C" int info_2();
extern "C" int sort_3();

const int list_num = 3;
const string app_list[]
{
    "[1][Test(Time)]Two array produce and add up to another array.",
    "[2][Info(CUDA)]List your CUDA info and your NVIDIA cards.",
    "[3][Test(Time)]Count sort with CUDA & GPU"
};

const int funcs_num = list_num;
const funcp funcs[]
{
    &test_1,
    &info_2,
    &sort_3
};

/// <summary>
/// 列出所有CUDA函数
/// </summary>
void list_cuda_apps()
{
    for (int i = 0; i < list_num; ++i) printf("%s\n", app_list[i].c_str());
}

/// <summary>
/// 执行CUDA函数
/// </summary>
/// <param name="index">编号</param>
void execute(int index)
{
    sep(100, '~', true);
    sep(100, '~', true);
    (*funcs[index])();
    sep(100, '~', true);
    sep(100, '~', true);
}