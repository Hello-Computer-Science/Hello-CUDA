#include <bits/stdc++.h>
#include "helper.h"
using namespace std;

const int info_num = 5;
string infos[]
{
	"HelloCUDA - Catrol v1.0.0",
	"Copyright © Catrol 2022",
	"Version: Beta v1.0.0 (Unrealeased)",
	"Author: Catrol (blog.catrol.cn)",
	"Base: CPP(With Visual Studio), CUDA"
};

/// <summary>
/// 打印所有信息
/// </summary>
void print_info()
{
	for (int i = 0; i < info_num; ++i) printf("%s\n", infos[i].c_str());
}

/// <summary>
/// 打印分割符
/// </summary>
/// <param name="num">分割数量</param>
/// <param name="c">分割用的符号</param>
/// <param name="e">分割完成是否换行</param>
void sep(int num, char c, bool e)
{
	for (int i = 1; i <= num; ++i) printf("%c", c);
	if (e) printf("\n");
}