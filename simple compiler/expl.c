extern int var[26];

Node * makeLeafNode(int TYPE,int NODETYPE,int VALUE,char NAME)
{
	Node *temp;
    temp = (Node*) malloc(sizeof(Node));
    temp->NAME = NAME;
	temp->TYPE = TYPE;
	temp->NODETYPE = NODETYPE;
	temp->VALUE=VALUE;

	return temp;
}



Node * makeOperatorNode(int TYPE,int NODETYPE,int VALUE,char NAME,Node* Ptr1,Node* Ptr2,Node* Ptr3)
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
 
