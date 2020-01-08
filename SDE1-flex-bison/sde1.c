#include "sde1.tab.c"
#include "lex.yy.c"
#include "yyerror.c"
//#define YYERROR_VERBOSE

int main(){
  printf("\n>>>> CONTEXTUAL parsing of string <<<<<<");
  int a = yyparse();
  if(a == 0) printf("\n\n***** congratulations; parse successful *****\n");
  else printf("\nSorry, Charlie, input string not in L(G)\n");
  return 1;
}
