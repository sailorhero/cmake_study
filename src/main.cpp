//main.c
#include "hello.h"
#include "helloconfig.h"
#include <stdio.h>

int main()
{
	printf("Welcome use hello program!\n");
	/*
	printf("Version: %d.%d\n",
		HELLO_VERSION_MAJOR,
		HELLO_VERSION_MINOR);
	*/
    char *str = hello("World");
    printf("%s!\n",str);
    return 0;
}
