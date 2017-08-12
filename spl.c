#include<stdio.h>
int main()
{
char str[100];
int d=0,a=0,s=0,spl=0,i;
gets(str);
for(i=0;str[i]!='\0';i++)
{
if(str[i]>='0'&&str[i]<='9')
{
d++;
}
else if((str[i]>='a'&&str[i]<='z')||(str[i]>='A'&&str[i]<='Z'))
a++;
else if(str[i]==' ')
s++;
else
spl++;
}
printf("\n special charcter %d",spl);
return 0;
}
