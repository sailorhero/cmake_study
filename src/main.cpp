//main.c
#include "hello.h"
#include <stdio.h>
int main()
{
    char *str = hello("World");
    printf("%s!\n",str);
    return 0;
}
