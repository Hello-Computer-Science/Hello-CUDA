#include "strhelper.h"

void trim_start(string *in, char c)
{
    string rst; int si = -1;
    for (int i = 0; i < (*in).length(); ++i)
        if (si == -1 && (*in)[i] != c)
        {
            si = i;
            rst += (*in)[i];
        }
        else if (si != -1) rst += (*in)[i];
    (*in) = rst;
}

void trim_end(string *in, char c)
{
    string rst; int si = -1;
    for (int i = (*in).length() - 1; i >= 0; --i)
        if (si == -1 && (*in)[i] != c)
        {
            si = i;
            rst += (*in)[i];
        }
        else if (si != -1) rst += (*in)[i];
    reverse(&rst);
    (*in) = rst;
}

void reverse(string* in)
{
    string rst;
    for (int i = (*in).length() - 1; i >= 0; --i) rst += (*in)[i];
    (*in) = rst;
}

bool startWith(string* in, string s)
{
    for (int i = 0; i < s.length(); ++i)
        if ((*in)[i] != s[i]) return false;
    return true;
}

string get_start(string* in, char sep)
{
    string rst;
    for (int i = 0; i < (*in).length(); ++i)
        if ((*in)[i] == sep) break;
        else rst += (*in)[i];
    return rst;
}

int int_parse(string* in)
{
    string pro = string((*in));
    trim_start(&pro, ' '); trim_end(&pro, ' ');
    int rst = 0; int bit = 0;
    for (int i = pro.length() - 1; i >= 0; --i)
    {
        int tmp = pro[i] - '0';
        for (int j = 1; j <= bit; ++j) tmp *= 10;
        ++bit;
        rst += tmp;
    }
    return rst;
}
