int yyerror(s)
      char *s;
{

  printf("\n%s\n", s);
  return -1;
}
