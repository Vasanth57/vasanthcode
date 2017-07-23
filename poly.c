#include<stdio.h>
int main()
{
int n,r=0,o,re;
printf("Enter an integer:\n");
scanf("%d",&n);
o=n;
while(n!=0)
{
re=n%10;
r=r*10 + re;
n=n/10;
}
if(o==r)
printf("%d is a polindrome",o);
else
printf("%d is not a polindrome",o);
return 0;
}
