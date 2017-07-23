#include<stdio.h>
int main()
{
int base,exponent;
long long result=1;
printf("Enter a base number:\n");
scanf("%d",&base);
printf("Enter an exponent:\n");
scanf("%d",&exponent);
while(exponent!=0)
{
result=result*base;
--exponent;
}
printf("%lld",result);
return 0;
}
