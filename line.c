#include<stdio.h>
int main()
{
char v[1000];
int i,count=0;
gets(v);
for(i=0;i<strlen(v);i++)
{
if(v[i]=='.')
{
++count;
}
}
printf("%d",count);
return 0;
}
