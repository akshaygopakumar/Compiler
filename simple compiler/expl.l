%{
	#include <stdio.h>
	#include "y.tab.h"
	#include <stdlib.h>

	int number;

%}

%%

[a-z]    { yylval.character = yytext[0];return ID;}
[0-9]+   { yylval.integer = atoi(yytext); return NUM;}
"read"    { return READ;}
"write"    {return WRITE;}
"if"		{return IF;}
"then"		{return THEN;}
"else"		{return ELSE;}
"endif"		{return ENDIF;}
[=]         { return ASGN;}
[+]		{ return PLUS;}
[-]		{return MINUS;}
[*]		{return MUL;}
[/]		{return DIV;}
[<]		{return L;}
"<="	{return LE;}
"=="	{return EQ;}
">="	{return GE;}
[>]		{return G;}
"!="	{return NE;}

[();\n]   {return *yytext;}
[ \t]      ;

%%

yyerror(char const *s)
{
	printf("yyerror %s",s);
}

int yywrap()
{
return 1;
}
