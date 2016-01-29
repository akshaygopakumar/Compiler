%{
	#include <stdio.h>
	#include "y.tab.h"
	#include <stdlib.h>

	int number;

%}

%%

[0-9]+		{number = atoi(yytext); yylval = makeLeafNode(number); return NUM;}
"+"			{return PLUS;}
"-"			{return MINUS;}
"*"			{return MUL;}
"/"			{return DIV;}
[ \t]		{}
[()\n]		{return *yytext;}
.			{yyerror("unknown character\n");exit(1);}

%%

int open()
{
	
	{
		FILE *fp = fopen("1.txt","r");
	
			yyin = fp;
	}
	return 0;
	
}

int yywrap(void) {
	return 1;
}

