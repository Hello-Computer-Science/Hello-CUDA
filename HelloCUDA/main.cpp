#include <bits/stdc++.h>

#include "helper.h"
#include "cuda_list.h"
#include "strhelper.h"
#include "cmd.h"

using namespace std;

const int cmd_list_num = 1;
const string cmd_list[]
{
    "exe"
};
const string null_str = "";

int main(int argc, char* argv)
{
    print_info();
    sep(100, '-', true);
    while (true) {
        printf("# > ");
        string cmd;
        getline(cin, cmd);
        trim_start(&cmd, ' ');
        trim_end(&cmd, ' ');
        if (cmd == "exit") break;
        else
        {
            bool cmd_found = false;
            string cmd_pro = get_start(&cmd, ' ');
            for (int i = 0; i < cmd_list_num; ++i)
                if (cmd_pro == cmd_list[i])
                {
                    cmd_found = true;
                    execute_cmd(i, &cmd);
                    break;
                }
            if (cmd != null_str && !cmd_found) printf("Command (%s) not found.\n", cmd_pro.c_str());
            // printf("%s\n", cmd.c_str()); // 测试字符串辅助函数
        }
    }
    return 0;
}