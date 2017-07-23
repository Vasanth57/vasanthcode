#include<stdio.h>
int main()
{
int i,v,t;
scanf("%d%d",&v,&t);
for(i=v;i<=t;i++)
{
if(i%2==0)
{
printf("%d\t",i);
}
}
return 0;
}
