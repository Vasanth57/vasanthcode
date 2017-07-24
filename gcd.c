#include<stdio.h>
int main()
{
int s,t,i,gcd;
scanf("%d%d",&s,&t);
for(i=1;i<=s && i<t;i++)
{
if(s%i==0 && t%i==0)
gcd=i;
}
printf("GCD or HCF of %d and %d is %d",s,t,gcd);
return 0;
}

