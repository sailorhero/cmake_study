#include "linklist.h"
#include<iostream>
using namespace std;

#define Len 10
int main(int argc, char *argv[])
{
    int array[Len];
    for(int i = 0; i < Len; ++i)
    {
        array[i] = Len-i;
    }
    LinkList L = NULL;
    Construct_LinkList(L, array, Len);
    Print_LinkList(L);
    Destroy_LinkList(L);
  int zyx = 10;
  cout<<"zyx inputs "<<GetOrigin(zyx)<<endl;
    return 0;
}