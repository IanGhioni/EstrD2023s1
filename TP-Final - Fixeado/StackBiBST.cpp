#include "StackBiBST.h"
#include <iostream>
using namespace std;

struct NodeBiBST {
    BiBST nodo;
    NodeBiBST* sig;
};

struct StackBiBST {
    NodeBiBST* tope;
    int size;
};

Stack emptyS() {
    StackBiBST* s = new StackBiBST;
    s->size = 0; s->tope = NULL;
}
bool isEmptyS(Stack s) {
    return s->size == 0;
}
void apilar(BiBST t, Stack s) { //!push()
    NodeBiBST* n = new NodeBiBST; 
    n->nodo = t;
    if (s->tope != NULL) {
        n->sig = s->tope;
    }
    s->tope = n;
    s->size++;
}
void desapilar(Stack s){ //!pop()
    if (s->size > 0) {
        NodeBiBST* x = s->tope;
        s->tope = x->sig;
        delete x;
        s->size--;
    }
}
BiBST firstS(Stack s){ // !top()
    return s->tope->nodo;
}

void destroyS(Stack s){
    if (s->size == 0) {
        delete s;
    }
    else {
        NodeBiBST* n = s->tope;
        NodeBiBST* next;
        while(n->sig != NULL) {
            next = n->sig;
            delete n; 
            n = next; 
        }
        delete n; 
        delete s;
    }
}
