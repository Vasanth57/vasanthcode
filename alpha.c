#include<stdio.h>
int main()
{
char str[100];
int alpha=0,dig=0,other=0,i=0;
gets(str);
while(str[i]!='\0')
{
if((str[i]>='a'&&str[i]<='z')||(str[i]>='A'&&str[i]<='Z'))
{
alpha++;
}
else if(str[i]>='0'&&str[i]<='9')
{
dig++;
}
else
{
other++;
}
i++;
}
printf("Alphabets = %d\n",alpha);
printf("Digits = %d\n",dig);
printf("Other character = %d\n",other);
return 0;
}
