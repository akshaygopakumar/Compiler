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


struct Tnode *Ptr1, *Ptr2, *Ptr3;

/* Maximum of three subtrees (3 required for IF THEN ELSE */


} Node;

Node * makeLeafNode(int TYPE,int NODETYPE,int VALUE,char* NAME);

Node * makeOperatorNode(int TYPE,int NODETYPE,int VALUE,char* NAME,Node* Ptr1,Node* Ptr2,Node* Ptr3);

int evaluate(Node *);


/* Sample Global and Local Symbol Table Structure */

/** Symbol Table Entry is required for variables, arrays and functions**/

struct Gsymbol {

char *NAME; // Name of the Identifier

int TYPE; // TYPE can be INTEGER or BOOLEAN

/***The TYPE field must be a TypeStruct if user defined types are allowed***/

int SIZE; // Size field for arrays

int BINDING; // Address of the Identifier in Memory



struct Gsymbol *NEXT; // Pointer to next Symbol Table Entry */

};

struct Gsymbol *Glookup(char *NAME); // Look up for a global identifier

void Ginstall(char *NAME, int TYPE, int SIZE); // Installation

 

