#include<stdio.h>
#include<string.h>
int main()
{
int s=0,i=0;
char a[100];
gets(a);
while(a[i]!='\0')
{
if(a[i]!=' ')
s++;
i++;
}
printf("%d",s);
return 0;
}
