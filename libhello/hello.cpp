#include <string.h>
#include <malloc.h>

char* hello(const char * name)
{
	const char* strHello = "Hello ";
	char* str;
	if(NULL == name || strlen(name) ==0 ){
		str = (char*)malloc(strlen(strHello));
		strcpy(str,strHello);
	}else{
		str = (char*)malloc(strlen(strHello)+strlen(name)+1);
		strcpy(str,strHello);
		strcpy(str+strlen(strHello),name);
	}
	return str;
}
