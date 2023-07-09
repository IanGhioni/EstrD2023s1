#include "BiBST.h"
#include <iostream>
using namespace std;
struct QueueBiBST;
typedef QueueBiBST* Queue;

Queue emptyQ();
//Crea una lista vacía.
//Costo: O(1).
bool isEmptyQ(Queue q);
//Indica si la lista está vacía.
//Costo: O(1).
BiBST firstQ(Queue q);
//Devuelve el primer elemento.
//Costo: O(1).
void Enqueue(BiBST nodo, Queue q);
//Agrega un elemento al final de la cola.
//Costo: O(1).
void Dequeue(Queue q);
//Quita el primer elemento de la cola.
//Costo: O(1).
void DestroyQ(Queue q);
//Libera la memoria ocupada por la lista.
//Costo: O(n).