#include<stdio.h>
int main()
{
int n,i,flag=0;
printf("Enter the number\n");
scanf("%d",&n);
for(i=2;i<n;i++)
{
if(n%i==0)
{
flag=1;
break;
}
}
if(flag==0)
printf("%d is prime",n);
else
printf("%d is not a prime",n);
return 0;
}
