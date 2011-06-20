start = foo | "foobar" { printf("succes!\n"); }
foo = @"a greeting" "hello"|"bye"

%%

int main() {
  GREG g;
  yyinit(&g);
  while (yyparse(&g));
  printf("error: %d - %d - expected: %s\n", g.error.line, g.error.pos, g.error.msg);
  yydeinit(&g);
  return 0;
}

