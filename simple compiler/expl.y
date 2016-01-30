%{
    #include <stdio.h>
	#include "expl.h"
	#include "expl.c"
	  
	int yylex(void);
    int var[26];
	#define LEAF -1
	
%}

%union{
	  int integer;
	  char* character;
	  struct Tnode * nodePtr; 
};
                                    

%token MUL PLUS MINUS  DIV READ WRITE ASGN IF THEN ELSE ENDIF L G LE GE NE EQ WHILE ENDWHILE
%token <integer> NUM
%token <character> ID

%type <nodePtr> program expr stmt stmt_list

%nonassoc L G LE GE EQ NE
%left PLUS MINUS 
%left MUL DIV



%%


program:	 //program  expr ';' '\n'				{printf("%d\n",evaluate($2));}		
			program declaration stmt_list '\n'				{evaluate($2);}
			|									{}
			; 


declaration : "decl" decls "enddecl" ; 

decls		: decls decl ';'
			  |decl ';'

decl		: INT ID			{Ginstall($2,INTEGER,1,);}
			| INT ID '[' NUM ']' {Ginstall($2,INTEGER,$4);}
			| BOOL ID 			{Ginstall($2,INTEGER,$4);}
			;

stmt_list: stmt_list stmt  ';' 	{	$$ = makeOperatorNode(INTEGER,'S',0,NULL,$1,$2,NULL); }
		|stmt ';'				{	$$ = $1 ;}
 

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
		| expr L expr           {$$ = makeOperatorNode(INTEGER,L,0,NULL,$1,$3,NULL); }
        | expr G expr           {$$ = makeOperatorNode(INTEGER,G,0,NULL,$1,$3,NULL); }
        | expr LE expr           {$$ = makeOperatorNode(INTEGER,LE,0,NULL,$1,$3,NULL); }
        | expr GE expr           {$$ = makeOperatorNode(INTEGER,GE,0,NULL,$1,$3,NULL); }
        | expr EQ expr           {$$ = makeOperatorNode(INTEGER,EQ,0,NULL,$1,$3,NULL); }
        | expr NE expr           {$$ = makeOperatorNode(INTEGER,NE,0,NULL,$1,$3,NULL); }
		|'(' expr ')'				{$$=$2;}
	    ;

%%


int main()
{
yyparse();
return 0;
}


int evaluate(Node *t){
    if(t->NODETYPE == LEAF)
		{
		
        return t->VALUE;
		}
    if(t->NODETYPE== ID)
		{
		
		return var[t->NAME-'a'];
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
						var[t->Ptr1->NAME-'a'] =  evaluate(t->Ptr2);
						break;

			case READ: 
						
						scanf("%d\n",&var[t->Ptr1->NAME-'a']);
						break;

			case WRITE:
						
						printf("%d\n",evaluate(t->Ptr1));
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




