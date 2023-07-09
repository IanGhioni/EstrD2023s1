#include "BiBST.h"
#include <iostream>
using namespace std;
struct NodeBiBST;
typedef NodeBiBST* Node;

struct StackBiBST;
typedef StackBiBST* Stack;

Stack emptyS();
bool isEmptyS(Stack s);
void apilar(BiBST n, Stack s);
void desapilar(Stack s);
BiBST firstS(Stack s);
void destroyS(Stack s);