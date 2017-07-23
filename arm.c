#include<stdio.h>
#include<math.h>
int main()
{
int num,on,re,r=0,n=0;
scanf("%d",&num);
on=num;
while(on!=0)
{
on/=10;
++n;
}
on=num;
while(on!=0)
{
re=on%10;
r+=pow(re,n);
on/=10;
}
if(r==num)
printf("%d is a armstrong number",num);
else
printf("%d is a not a armstrong number",num);
return 0;
}
