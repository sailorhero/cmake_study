#include "linklist.h"
//注意，这里没有使用相对路径，因为CMake已经把路径替我们做了
#include <iostream>
using std::cout;
using std::endl;

void Construct_LinkList(LinkList &L, int a[], int len)
{
    LNode *p;
    L = new LNode();
    L->next = NULL;
    for(int i = 0; i < len; ++i)
    {
        p = new LNode();
        p->data = a[i];
        p->next = L->next;
        L->next = p;
    }
}
void Print_LinkList(LinkList L)
{
    if(L == NULL)
        return;
    LNode *p = L->next;
    while(p!=NULL)
    {
        cout<<p->data<<" ";
        p = p->next;  
    }
    cout<<endl;
}
void Destroy_LinkList(LinkList &L)
{
    if(L == NULL)
        return;
    LNode *p = L->next;
    LNode *q;
    while(p != NULL)
    {
        q = p->next;
        delete p;
        p = q;
    }
    delete L;
    L = NULL;
}
int GetOrigin(int a)
{
  return a;
}