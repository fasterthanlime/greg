#include <stdio.h>
#include <stdlib.h>

int stack[1024];
int stackp= -1;

int push(int n)	{ return stack[++stackp]= n; }
int pop(void)	{ return stack[stackp--]; }

#include "dc.leg.c"

int main()
{
  GREG g;
  yyinit(&g);
  while (yyparse(&g));
  yydeinit(&g);

  return 0;
}
