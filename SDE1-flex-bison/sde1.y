%{
  #include <stdio.h>
  #include <ctype.h>
  int yylex(void);
  int yyerror(char *s);
  int aCount;
  int bCount;
  int cCount;
  int dCount;
  int eCount;
%}

/* tokens*/
%token BEGINA
%token A
%token B
%token C
%token D
%token E
%token ENDE
%token ENDA
%token BEGINE
%start starthere

%% /*Grammar rules*/
starthere: BEGINA gotoa ENDE  | BEGINE E gotoetwo ENDA
;
gotoa: A gotoa E | B gotob | A {return -1;}
;
gotob: B gotob | C gotoc D
;
gotoc: C gotoc D |
;
/* 2nd part of grammar rules strings starting with E*/

gotoetwo: E E gotoetwo A  | D D gotoctwo
;
gotoctwo: C C C gotoctwo B |
;
%%
