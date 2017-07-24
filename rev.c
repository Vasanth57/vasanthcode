#include<stdio.h>
int main()
{
int n,r,rn=0;
scanf("%d",&n);
while(n!=0)
{
r=n%10;
rn=rn*10+r;
n/=10;
}
printf("Reverse number is %d",rn);
return 0;
}
