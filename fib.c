#include<stdio.h>
int main()
{
int s,t,r,i,n;
scanf("%d",&n);
s=0;
t=1;
r=0;
for(i=1;i<=n;i++)
{
printf("%d\t",r);
s=t;
t=r;
r=s+t;
}
return 0;
}
