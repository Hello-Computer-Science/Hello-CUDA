#include <bits/stdc++.h>
#include "cmd.h"
#include "cuda_list.h"
#include "helper.h"
#include "strhelper.h"
using namespace std;

int exe(string* cmd)
{
    if (*cmd == "exe")
    {
        sep(100, '-', true);
        list_cuda_apps();
        sep(100, '-', true);
        printf("Choose one CUDA app (0 to cancel): ");
        string in;
        getline(cin, in);
        int cmd_index = int_parse(&in);
        if (cmd_index != 0)
            if (cmd_index >= 1 && cmd_index <= list_num)
                execute(cmd_index - 1);
            else printf("Your selection is out of the range.\n");
    }
    return 0;
}

typedef int (*cmdfunc)(string* cmd);
const cmdfunc cmdfuncs[]
{
    &exe
};

void execute_cmd(int index, string *cmd)
{
    (*cmdfuncs[index])(cmd);
}
