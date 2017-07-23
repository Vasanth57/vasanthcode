#include<stdio.h>
int main()
{
int i,v,t,flag;
scanf("%d%d",&v,&t);
while(v<t)
{
flag=0;
for(i=2;i<=v/2;i++)
{
if(v%i==0)
{
flag=1;
break;
}
}
if(flag==0)
printf("%d\t",v);
++v;
}
return 0;
}
