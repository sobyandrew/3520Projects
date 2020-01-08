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

/*%token ENDE
%token ENDA*/

%token BEGINE
%start stargrammarone

%% /*Grammar rules*/

stargrammarone: BEGINA {aCount++; printf("\n>>>> CONTEXTUAL parsing of string <<<<<<\n");} goa |
                BEGINE {eCount++; printf("\n>>>> CONTEXTUAL parsing of string <<<<<<\n");} goe2
;

/* first part of grammar rules */
goa: A {aCount++;} goa |
     B {bCount++;} gob |
       {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n");}
;
gob: B {bCount++;} gob |
     C {cCount++;} goc |
       {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n");}
;
goc: C {cCount++;} goc |
     D {dCount++;} god |
       {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n");}
;
god: D {dCount++;}god |
     E {eCount++; printf("here");
        if((eCount == aCount) && (cCount == dCount) && (aCount > 0) && (bCount > 0) && (cCount > 0) && (dCount > 0) && (eCount > 0)){
          printf("\n***** congratulations; parse successful *****\n");
        }
        else{
          printf("\nSorry, Charlie, input string not in L(G)\n");
        }
       } | //add go finish here???????????????????
     E {eCount++;} goe |
       {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n"); return 1;}
;
goe: E {eCount++;
        if((eCount == aCount) && (cCount == dCount) && (aCount > 0) && (bCount > 0) && (cCount > 0) && (dCount > 0) && (eCount > 0)){
          printf("\n***** congratulations; parse successful *****\n");
        }
        else{
          printf("\nSorry, Charlie, input string not in L(G)\n");
        }
      } |
     E {eCount++;} goe
;


/*{
  if((eCount == aCount) && (cCount == dCount) && (aCount > 0) && (bCount > 0) && (cCount > 0) && (dCount > 0) && (eCount > 0)){
    printf("***** congratulations; parse successful *****\n");
  }
  else{
    printf("Sorry, Charlie, input string not in L(G)\n");
  }
}*/

/*2nd part of grammar rules*/
goe2: E {eCount++;} goe2 |
      D {dCount++;} god2 |
        {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n");}
;
god2: D {dCount++;} god2 |
      C {cCount++;} goc2 |
        {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n");}
;
goc2: C {cCount++;} goc2 |
      B {bCount++;} gob2 |
        {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n"); return 1;}
;
gob2: B {bCount++;} gob2 |
      A {aCount++;} goa2 |
      A {aCount++;
        if((eCount == 2*aCount) && (cCount == 3*bCount) && dCount == 2 && eCount != 0 && cCount != 0 && bCount != 0 && aCount != 0 ){
            printf("\n***** congratulations; parse successful *****\n");
        }
        else{
            printf("\nSorry, Charlie, input string not in L(G)\n");
        }
      }                   |
        {printf("syntax error\n\nSorry, Charlie, input string not in L(G)\n");}
;
goa2: A {aCount++;} goa2 |
      A {aCount++;
        if((eCount == 2*aCount) && (cCount == 3*bCount) && dCount == 2 && eCount != 0 && cCount != 0 && bCount != 0 && aCount != 0 ){
            printf("\n***** congratulations; parse successful *****\n");
        }
        else{
            printf("\nSorry, Charlie, input string not in L(G)\n");
        }
      } //end case here
;
