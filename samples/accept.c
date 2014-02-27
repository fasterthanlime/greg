#include <stdio.h>
#include "accept.leg.c"

int main()
{
  GREG g;
  yyinit(&g);
  while (yyparse(&g));
  yydeinit(&g);
  return 0;
}
