#include<stdio.h>
void main()
{
char v;
printf("Enter the character");
scanf("%c",&v);
if( v=='a' || v=='e' || v=='i' || v=='o' || v=='u' || v=='A' || v=='E' || v=='I' || v=='O' || v=='U' ) 
{
printf("%c is an vowel",v);
}
else
{
printf("%c is an consonant",v);
}
}
