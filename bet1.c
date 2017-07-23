#include<stdio.h>
#include<math.h>
int main()
{
int v,t,i,t1,t2,re,n=0,r=0;
scanf("%d%d",&v,&t);
for(i=v;i<=t;++i)
{
t2=i;
t1=i;
while(t1!=0)
{
t1/=10;
++n;
}
while(t2!=0)
{
re=t2%10;
r+=pow(re,n);
t2/=10;
}
if(r==i)
{
printf("%d\t",i);
}
n=0;
r=0;
}
return 0;
}
