#include<stdio.h>
void main()
{
int v;
printf("Enter the chracter");
scanf("%c",&v);
if( ( v>='a' && v<='z' ) || (v>='A' && v<='Z') )
{
printf("%c is a alphabet",v);
}
else
{
printf("%c is not a alpha bet",v);
}
}
