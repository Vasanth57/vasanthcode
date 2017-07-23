#include<stdio.h>
int main()
{
int n,count=0;
printf("Enter the number:");
scanf("%d",&n);
while(n!=0)
{
count++;
n=n/10;
}
printf("The total digit is %d",count);
return 0;
}

