#include "Tree.h"

struct NodeT {
    int elem;
    NodeT* left;
    NodeT* right;
};

Tree emptyT() {
    return nullptr;
};

bool isEmpty(Tree t) {
    return (t == nullptr);
};

Tree nodeT(int e, Tree left, Tree right) {
    NodeT* n = new NodeT;
    n->elem = e; n->left = left; n->right = right;
    return n;
};

int rootT(Tree t) {
    return t->elem;
};

Tree left(Tree t) {
    return t->left;
};

Tree right(Tree t) {
    return t->right;
};



