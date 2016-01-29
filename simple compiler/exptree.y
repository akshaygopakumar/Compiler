%{
	#include <stdio.h>
	#include <stdlib.h>
	#define YYSTYPE tnode *
	#include "exptree.h"
	#include "exptree.c"
	int yylex(void);
%}

%token NUM PLUS MINUS MUL DIV 
%left PLUS MINUS
%left MUL DIV

%%

program :  expr '\n'	{
				$$ = $2;
				printf("= %d\n",evaluate($1));
				exit(1);
			}
	
		;

expr : expr PLUS expr		{$$ = makeOperatorNode('+',$1,$3);}
	 | expr MINUS expr  	{$$ = makeOperatorNode('-',$1,$3);}
	 | expr MUL expr	{$$ = makeOperatorNode('*',$1,$3);}
	 | expr DIV expr	{$$ = makeOperatorNode('/',$1,$3);}
	 | '(' expr ')'		{$$ = $2;}
	 | NUM			{$$ = $1;}
	 ;

%%

yyerror(char const *s)
{
    printf("yyerror %s",s);
}


int main(void) {
	int t;	
	t=open();
	yyparse();
	return 0;
}


