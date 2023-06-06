#include "LinkedList.h"
#include <iostream>
using namespace std;

int main() {
    //g++ -o app main.cpp LinkedList.h LinkedList.cpp
    LinkedList xs = nil();
    cons(1,xs); snoc(2,xs);
    cout << length(xs) << endl;
}