%{
#include <stdio.h>

int vars[26];

%}

# this is a simple parser that will parse until a end of line or end of input
# it ignores empty lines
Line    = - (EOL|EOF)
        | @"a statement" e:Stm @"end of line" (EOL|EOF) { printf("%d\n", e); }

# after we have hit an error, consume a full line
Garbage = (!EOL .)* EOL

Stm     = i:ID ASSIGN @"an expression" s:Sum { $$= vars[i]= s; }
        | s:Sum                              { $$= s; }

Sum     = l:Product
                ( PLUS  @"an expression" r:Product { l += r; }
                | MINUS @"an expression" r:Product { l -= r; }
                )*                                 { $$= l; }

Product = l:Value
                ( TIMES  @"an expression" r:Value  { l *= r; }
                | DIVIDE @"an expression" r:Value  { l /= r; }
                )*                      { $$= l; }

Value   = i:NUMBER                      { $$= atoi(yytext); }
        | i:ID !ASSIGN                  { $$= vars[i]; }
        | OPEN @"an expression" i:Sum
               @"a closing ')'" CLOSE   { $$= i; }

NUMBER  = < [0-9]+ >    -               { $$= atoi(yytext); }
ID      = < [a-z]  >    -               { $$= yytext[0] - 'a'; }

ASSIGN  = '='           -
PLUS    = '+'           -
MINUS   = '-'           -
TIMES   = '*'           -
DIVIDE  = '/'           -
OPEN    = '('           -
CLOSE   = ')'           -

-       = [ \t]*
EOL     = '\n' | '\r\n' | '\r' | ';'
EOF     = !.

%%

int main() {
    // stack allocate a GREG parser and initialize it
    GREG g;
    yyinit(&g);

    // loop forever over the input
    for (;;) {
        // first we try if we are at end of file (input); if so, stop
        if (yyparse_from(&g, yy_EOF)) break;
        if (!yyparse(&g)) {
            // if we tried to parse a line, but no success, report the error
            // TODO here we might be better off with API to get error, position, and text directoy after ...
            g.buf[g.limit] = 0;
            printf("error: expected %s - at char %d; instead of '%s'\n", g.error.msg, g.error.pos, g.buf+g.error.pos);
            // then eat the line until a line separator shows up, ignoring any errors
            yyparse_from(&g, yy_Garbage);
        }
    }

    // forever is not that long if the input ends
    // free any resources used by the parser
    yydeinit(&g);
    return 0;
}

