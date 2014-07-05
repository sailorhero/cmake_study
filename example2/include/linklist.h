#ifndef DS_INCLUDE_LINKLIST_H_
#define DS_INCLUDE_LINKLIST_H_

typedef struct LNode
{
  int data;
  LNode *next;
}LNode, *LinkList;

void Construct_LinkList(LinkList &L, int a[], int len);
void Print_LinkList(LinkList L);
void Destroy_LinkList(LinkList &L);
int GetOrigin(int a);
#endif