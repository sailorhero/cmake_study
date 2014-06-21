#include <string.h>
#include <malloc.h>

char* hello(const char * name)
{
    const char* strHello = "Hello ";
    char* str = (char*)malloc(strlen(strHello)+strlen(name)+1);
    strcpy(str,strHello);
    strcpy(str+strlen(strHello),name);
    return str;
}
