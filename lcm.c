#include<stdio.h>
int main()
{
int a,b,m;
scanf("%d%d",&a,&b);
m=(a>b) ? a : b;
while(1)
{
if(m%a==0 && m%b==0)
{
printf("LCM of %d and %d is %d\n",a,b,m);
break;
}
++m;
}
return 0;
}
