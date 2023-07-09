#include "QueueBiBST.h"
#include <iostream>
using namespace std;

struct NodeBiBST {
    BiBST nodo;
    NodeBiBST* sig;
};

typedef NodeBiBST* Node;
struct QueueBiBST {
    int cantidad; // cantidad de elementos
    NodeBiBST* primero; // puntero al primer nodo
    NodeBiBST* ultimo; // puntero al ultimo nodo
};
/*
INV.REP.:
    * Si primero es EMPTYBB <=> ultimo es EMPTYBB.
*/

Queue emptyQ(){
//Crea una lista vacía.
//Costo: O(1).
    QueueBiBST* q = new QueueBiBST;
    q->cantidad = 0;
    q->primero = NULL;
    q->ultimo = NULL;
}

bool isEmptyQ(Queue q){
//Indica si la lista está vacía.
//Costo: O(1).
    return q->cantidad == 0;

}

BiBST firstQ(Queue q){
//Devuelve el primer elemento.
//Costo: O(1).
    return q->primero->nodo;
}

void Enqueue(BiBST nodo, Queue q){
//Agrega un elemento al final de la cola.
//Costo: O(1).
    Node n = new NodeBiBST;
    n->nodo = nodo; n->sig = NULL;
    if (q->cantidad == 0) {
        q->primero = n;
        q->ultimo = n;
        q->cantidad++;
    }
    else {
        q->ultimo->sig = n;
        q->ultimo = n;
        q->cantidad++;
    }
}

void Dequeue(Queue q){
//Quita el primer elemento de la cola.
//Costo: O(1).
    if (q->cantidad == 0) {}
    else if (q->primero == q->ultimo) {
        delete q->primero;
        q->primero == NULL;
        q->ultimo == NULL;
        q->cantidad--; 
    }
    else {
        Node n = q->primero;
        q->primero = n->sig;
        delete n;
        q->cantidad--;
    }
}

void DestroyQ(Queue q){
//Libera la memoria ocupada por la lista.
//Costo: O(n).
    int x = 0;
    if (q->cantidad == 0) {
        delete q;
    }
    else {
        Node n = q->primero;
        Node next;
        while(n->sig != NULL) {
            next = n->sig;
            delete n; 
            x++;
            n = next; 
        }
        delete n; 
        x++;
        delete q;
    }
}


