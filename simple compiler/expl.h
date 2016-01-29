enum {INTEGER,BOOLEAN} Type;


typedef struct Tnode {



int TYPE; // Integer, Boolean or Void (for statements)

/* Must point to the type expression tree for user defined types */

int NODETYPE;

/* this field should carry following information:

* a) operator : (+,*,/ etc.) for expressions

* b) statement Type : (WHILE, READ etc.) for statements */

char* NAME; // For Identifiers/Functions

int VALUE; // for constants

struct Tnode *ArgList; // List of arguments for functions

struct Tnode *Ptr1, *Ptr2, *Ptr3;

/* Maximum of three subtrees (3 required for IF THEN ELSE */


} Node;

Node * makeLeafNode(int TYPE,int NODETYPE,int VALUE,char* NAME,Node* ArgList);

Node * makeOperatorNode(int TYPE,int NODETYPE,int VALUE,char* NAME,Node* ArgList,Node* Ptr1,Node* Ptr2,Node* Ptr3);

int evaluate(Node *);

