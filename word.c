#include<stdio.h>
int main()
{
char str[100];
int i=0,w=1;
gets(str);
while(str[i]!='\0')
{
if(str[i]==' ' || str[i]=='\n' || str[i]=='\t')
{
w++;
}
i++;
}
printf("The total number of words=%d\n",w);
return 0;
}
