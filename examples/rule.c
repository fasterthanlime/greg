#include <stdio.h>
#include <stdlib.h>

#include "rule.peg.c"

int main()
{
  GREG g;
  yyinit(&g);
  while (yyparse(&g));
  yydeinit(&g);

  return 0;
}
