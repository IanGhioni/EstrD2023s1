struct NodeT;
typedef NodeT* Tree;

Tree emptyT();
Tree nodeT(int e, Tree left, Tree right);
bool isEmpty(Tree t);
int rootT(Tree t);
Tree left(Tree t);
Tree right(Tree t);