#include<stdio.h>
void main()
{
int s,t,r;
printf("Enter the three numbers");
scanf("%d%d%d",&s,&t,&r);
if(s>t && s>r)
{
printf("%d is large",s);
}
else if(t>s && t>r)
{
printf("%d is large",t);
}
else
{
printf("%d is large",r);
}
}
