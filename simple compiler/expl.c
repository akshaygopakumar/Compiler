
Node * makeLeafNode(int TYPE,int NODETYPE,int VALUE,char* NAME)
{
	Node *temp;
	
	 temp = (Node*) malloc(sizeof(Node));
	if (NODETYPE == ID)
	{	
		struct Gsymbol *tempSymbol;
		
		tempSymbol = Glookup(NAME);
		if(tempSymbol==NULL)
			{
			printf("The variable %s is not defined\n",NAME);
			exit(0);	
			}
		
		temp->NAME = (char *)malloc(sizeof(NAME));
    	strcpy(temp->NAME,NAME);
	}
	
	
   
	
	temp->TYPE = TYPE;
	temp->NODETYPE = NODETYPE;
	temp->VALUE=VALUE;
	
	return temp;
}



Node * makeOperatorNode(int TYPE,int NODETYPE,int VALUE,char* NAME,Node* Ptr1,Node* Ptr2,Node* Ptr3)
{
	
    Node *temp;
	
    temp = (Node *) malloc(sizeof(Node));
    temp->TYPE=TYPE;
	temp->NODETYPE = NODETYPE;
	temp->Ptr1 = Ptr1;
	temp->Ptr2 = Ptr2;
	temp->Ptr3 = Ptr3;
	
    return temp;
}
 

struct Gsymbol *Glookup(char * NAME)
{

	struct Gsymbol *temp;
	
	temp = beg;
	while(temp!=NULL)
		{
			
			if(strcmp(temp->NAME,NAME)==0)
				return temp;		
			temp = temp->NEXT;
		}
		
		return NULL;
}

void Ginstall(char * NAME, int TYPE,int SIZE)
{
	
	if(Glookup(NAME)!=NULL)
		printf("Redeclaration of variable\n");
	else
	{
	
	struct Gsymbol *temp;
	struct Gsymbol *newSymbol;	
	temp = beg;
	if(!beg)
		{
		newSymbol = (struct Gsymbol*) malloc(sizeof(struct Gsymbol));
		newSymbol->NAME = (char*) malloc(sizeof(char));
		strcpy(newSymbol->NAME,NAME);
		newSymbol->TYPE = TYPE;
		newSymbol->BINDING = (int *)malloc(sizeof(int)*SIZE);
		newSymbol->SIZE = SIZE;
		newSymbol->NEXT = NULL;
		beg = newSymbol;	
		}
	else
	{
		while(temp->NEXT!=NULL)
		{
			temp = temp->NEXT;
		}
	newSymbol = (struct Gsymbol*) malloc(sizeof(struct Gsymbol));
	newSymbol->NAME = (char*) malloc(sizeof(char));
	strcpy(newSymbol->NAME,NAME);
	newSymbol->TYPE = TYPE;
	newSymbol->BINDING = (int *)malloc(sizeof(int)*SIZE);
	newSymbol->SIZE = SIZE;
	newSymbol->NEXT = NULL;
	temp->NEXT = newSymbol;	
	}
}		
	

}
