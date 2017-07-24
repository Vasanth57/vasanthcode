#include<stdio.h>
int main()
{
int n,i,s=0,s1=0;
for(i=1;i<=15;i++)
{
s=s+i;
}
printf("%d\n",s);
for(i=15;i<=45;i++)
if(i%2!=0)
{
s1=s1+i;
}
printf("%d",s1);
return 0;
}
