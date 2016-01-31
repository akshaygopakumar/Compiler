%union{
	  int integer;
	  char* character;
	  struct Tnode * nodePtr; 

};
                                    

%token DECL ENDDECL MUL PLUS MINUS  DIV READ WRITE ASGN IF THEN ELSE ENDIF L G LE GE NE EQ WHILE ENDWHILE BOOL INT
%token <integer> NUM
%token <character> ID

%type <nodePtr> program expr stmt stmt_list

%nonassoc L G LE GE EQ NE
%left PLUS MINUS 
%left MUL DIV


%{

	#include <stdlib.h>
	#include <string.h>
    #include <stdio.h>
	#include "expl.h"

	extern FILE* yyin;
	struct Gsymbol *beg;
	
	
	#include "expl.c"
	
  

	int yylex(void);

	#define LEAF -1
	
%}




%%


program:		
			declaration  stmt_list 		{evaluate($2);}
			|									{}
			; 


declaration : DECL decls ENDDECL    
			;

decls		: decls decl ';'
			  |decl ';'
			  ;

decl		: INT ID			{Ginstall($2,INTEGER,1);}
			| INT ID '[' NUM ']' {Ginstall($2,INTEGER,$4);}
			| BOOL ID 			{Ginstall($2,BOOLEAN,1);}
			;

stmt_list: stmt_list stmt  ';' 	{	$$ = makeOperatorNode(INTEGER,'S',0,NULL,$1,$2,NULL); }
		|stmt  ';'				{	$$ = $1 ;}
 		;
	
stmt : ID ASGN expr 			{
									
									$$ = makeOperatorNode(INTEGER,ASGN,0,NULL,makeLeafNode(INTEGER,ID,0,$1),$3,NULL);
									 																																					
								}
     | READ '(' ID ')'			{
									$$ =  makeOperatorNode(INTEGER,READ,0,NULL,makeLeafNode(INTEGER,ID,0,$3),NULL,NULL);
								}
     | WRITE '(' expr ')'		{
									$$ =  makeOperatorNode(INTEGER,WRITE,0,NULL,$3,NULL,NULL);
								}
	|IF '(' expr ')' THEN stmt_list ENDIF 					{$$ = makeOperatorNode(INTEGER,IF,0,NULL,$3,$6,NULL);}
	|IF '(' expr ')' THEN stmt_list ELSE stmt_list ENDIF 	{$$ = makeOperatorNode(INTEGER,IF,0,NULL,$3,$6,$8);}
	|WHILE '(' expr ')'THEN stmt_list ENDWHILE 				{$$ = makeOperatorNode(INTEGER,WHILE,0,NULL,$3,$6,NULL);}
   
     ;

expr:	NUM					 	  {$$ = makeLeafNode(INTEGER,LEAF,$1,NULL);}			
		|ID						  {
										$$ = makeLeafNode(INTEGER,ID,0,$1);
								  }	
        | expr PLUS expr           {$$ =  makeOperatorNode(INTEGER,PLUS,0,NULL,$1,$3,NULL);}
        | expr MINUS expr           {$$ = makeOperatorNode(INTEGER,MINUS,0,NULL,$1,$3,NULL); }
		| expr MUL expr           {$$ = makeOperatorNode(INTEGER,MUL,0,NULL,$1,$3,NULL); }
		| expr DIV expr           {$$ = makeOperatorNode(INTEGER,DIV,0,NULL,$1,$3,NULL); }        
		| expr L expr           {$$ = makeOperatorNode(BOOLEAN,L,0,NULL,$1,$3,NULL); }
        | expr G expr           {$$ = makeOperatorNode(BOOLEAN,G,0,NULL,$1,$3,NULL); }
        | expr LE expr           {$$ = makeOperatorNode(BOOLEAN,LE,0,NULL,$1,$3,NULL); }
        | expr GE expr           {$$ = makeOperatorNode(BOOLEAN,GE,0,NULL,$1,$3,NULL); }
        | expr EQ expr           {$$ = makeOperatorNode(BOOLEAN,EQ,0,NULL,$1,$3,NULL); }
        | expr NE expr           {$$ = makeOperatorNode(BOOLEAN,NE,0,NULL,$1,$3,NULL); }
		|'(' expr ')'				{$$=$2;}
	    ;

%%


int main()
{
yyin = fopen("pr","r");
yyparse();
return 0;
}


int evaluate(Node *t)
{
	
	struct Gsymbol * symbolTable;

    if(t->NODETYPE == LEAF)
		{
        return t->VALUE;
		}

    if(t->NODETYPE== ID)
		{
		symbolTable = Glookup(t->NAME);
		return *(int *)(symbolTable->BINDING);
		}

    else{
        switch((t->NODETYPE)){
            case PLUS : 
					   return evaluate(t->Ptr1) + evaluate(t->Ptr2);
                       break;
            case MINUS : return evaluate(t->Ptr1) - evaluate(t->Ptr2);
                       break;
            case MUL : return evaluate(t->Ptr1) * evaluate(t->Ptr2);
                       break;
            case DIV : return evaluate(t->Ptr1) / evaluate(t->Ptr2);
                       break;
			case ASGN :	
						symbolTable = Glookup(t->Ptr1->NAME);
						
						*(int *)symbolTable->BINDING =  evaluate(t->Ptr2);
						break;

			case READ: 
						symbolTable = Glookup(t->Ptr1->NAME);
						scanf("%d",(int *)symbolTable->BINDING);
						break;

			case WRITE:
						if(t->Ptr1->NODETYPE != ID)
							{	
							printf("%d",evaluate(t->Ptr1));
							break;
							}
												
						symbolTable = Glookup(t->Ptr1->NAME);
						printf("%d\n",*(int *)symbolTable->BINDING);
						break;

			case 'S':
						evaluate(t->Ptr1);
						evaluate(t->Ptr2);
						break;

			case IF:	
						if(evaluate(t->Ptr1))
							evaluate(t->Ptr2);
						else if(t->Ptr3)
							evaluate(t->Ptr3);
						break;
			case WHILE:
						while(evaluate(t->Ptr1))
							evaluate(t->Ptr2);
						break;
			case  L :  return evaluate(t->Ptr1) < evaluate(t->Ptr2);
                       break;
		    case  G : return evaluate(t->Ptr1) > evaluate(t->Ptr2);
                       break;
		    case  LE : return evaluate(t->Ptr1) <= evaluate(t->Ptr2);
                       break;
		    case  GE : return evaluate(t->Ptr1) >= evaluate(t->Ptr2);
                       break;
		    case  EQ : return evaluate(t->Ptr1) == evaluate(t->Ptr2);
                       break;
		    case  NE : return evaluate(t->Ptr1) != evaluate(t->Ptr2);
                       break;
		        
		}
}
    
}




