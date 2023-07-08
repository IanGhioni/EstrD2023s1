#include <iostream>
#include <algorithm>
#include "BiBST.h"
#include "QueueBiBST.h"

int main() {
    //g++ -o app QueueTest.cpp  BiBST.h BiBST.cpp QueueBiBST.h QueueBiBST.cpp
    BiBST node1 = insertBBNode(EMPTYBB, 0, 0);
    BiBST node2 = insertBBNode(node1, -1, 1);
    BiBST node3 = insertBBNode(node1, 1, 1);
    BiBST node4 = insertBBNode(node1, -5, -11);
    BiBST node5 = insertBBNode(node1, 5, -11);
    cout << endl;
    Queue q = emptyQ();
    int x = 1;
    if (isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    }
    Enqueue(node1,q);
    if (!isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    } 
    if (firstQ(q) == node1) {
        cout << "Paso = " << x << endl; x++;
    }
    Dequeue(q);
    if (isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    }
    Enqueue(node1,q);
    if (firstQ(q) == node1) {
        cout << "Paso = " << x << endl; x++;
    }
    if (!isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    }
    Enqueue(node2,q);
    if (!isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    }
    Enqueue(node3,q);
    if (!isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    }
    Dequeue(q);
    if (firstQ(q) == node2) {
        cout << "Paso = " << x << endl; x++;
    }
    if (!isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    }
    Dequeue(q);
    if (firstQ(q) == node3) {
        cout << "Paso = " << x << endl; x++;
    }
    if (!isEmptyQ(q)) {
        cout << "Paso = " << x << endl; x++;
    }
    Dequeue(q);
    if (isEmptyQ(q)) {
        cout << "Paso = " << x << endl << endl; x++;
    }
    Enqueue(node1,q);
    Enqueue(node2,q);
    Enqueue(node3,q);
    Enqueue(node4,q);
    Enqueue(node5,q);
    DestroyQ(q);
}