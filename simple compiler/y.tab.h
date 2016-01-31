/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DECL = 258,
    ENDDECL = 259,
    MUL = 260,
    PLUS = 261,
    MINUS = 262,
    DIV = 263,
    READ = 264,
    WRITE = 265,
    ASGN = 266,
    IF = 267,
    THEN = 268,
    ELSE = 269,
    ENDIF = 270,
    L = 271,
    G = 272,
    LE = 273,
    GE = 274,
    NE = 275,
    EQ = 276,
    WHILE = 277,
    ENDWHILE = 278,
    BOOL = 279,
    INT = 280,
    NUM = 281,
    ID = 282
  };
#endif
/* Tokens.  */
#define DECL 258
#define ENDDECL 259
#define MUL 260
#define PLUS 261
#define MINUS 262
#define DIV 263
#define READ 264
#define WRITE 265
#define ASGN 266
#define IF 267
#define THEN 268
#define ELSE 269
#define ENDIF 270
#define L 271
#define G 272
#define LE 273
#define GE 274
#define NE 275
#define EQ 276
#define WHILE 277
#define ENDWHILE 278
#define BOOL 279
#define INT 280
#define NUM 281
#define ID 282

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 1 "expl.y" /* yacc.c:1909  */

	  int integer;
	  char* character;
	  struct Tnode * nodePtr; 

#line 114 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
