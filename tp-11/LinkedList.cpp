#include "LinkedList.h"

struct NodeL {
    int elem;
    NodeL* next;
};

struct LinkedListSt {
    int cantidad;
    NodeL* first;
    NodeL* last;
};

struct IteradorSt {
    NodeL* current;
};

LinkedList nil() {
    LinkedListSt* xs = new LinkedListSt;
    xs->first = nullptr;
    xs->last = nullptr;
    xs->cantidad = 0;
    return(xs);
}

bool isEmpty(LinkedList xs) {
    return xs->cantidad == 0;
}

int length(LinkedList xs) {
    return xs->cantidad;
}

int head(LinkedList xs) {
    return xs->first->elem;
}

void tail(LinkedList xs) {
    NodeL* temp = xs->first;
    if (temp->next != nullptr) {
        xs->first = temp->next;
    }
    else {xs->first = nullptr; xs->last = nullptr; }
    delete temp;
}

void cons(int x, LinkedList xs) {
    NodeL* n = new NodeL; n->elem = x;
    if (!isEmpty(xs)) { 
        n->next = xs->first;
    }
    else { 
        n->next = nullptr;
        xs->last = n;
    }
    xs->first = n;
    xs->cantidad++;
}

void append(LinkedList xs, LinkedList ys) {
    xs->last->next = ys->first;
    delete ys;
}

ListIterator getIterator(LinkedList xs) {
    IteradorSt* it = new IteradorSt;
    it->current = xs->first;
    return it;
}

int current(ListIterator it) {
    return it->current->elem;
}

void setCurrent(int x, ListIterator it) {
    it->current->elem = x;
}

void next(ListIterator it) {
    it->current = it->current->next;
}

bool atEnd(ListIterator it) {
    return it->current->next == nullptr;
}

void disposeIterator(ListIterator it) { 
    delete it;
}

void snoc(int x, LinkedList xs) {
    NodeL* n = new NodeL; n->elem = x; n->next = nullptr;
    if (isEmpty(xs)) {
        xs->first = n;
        xs->last = n;
    }
    else {
        xs->last->next = n;
    }
    xs->cantidad++;
}

void destroyL(LinkedList xs) {
    if (isEmpty(xs)) {
        delete xs;
    }
    else {
        IteradorSt* it = getIterator(xs);
        NodeL* n = it->current;
        while (!atEnd(it)) {
            delete n;
            next(it);
            n = it->current;
        }
        delete n; disposeIterator(it);
        delete xs;
    }
}