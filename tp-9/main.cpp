#include "par.h"
#include <iostream>
using namespace std;


// Precondición: c1 < c2
void printFromTo(char c1, char c2) {
    for(int i = 0; c1 + i <= c2; i++) {
        cout << c1 + i << ", ";
    }
    cout << endl;
}

int main() {
    Par p = divisionYResto(23,10);
    cout << "fst = " << fst(p) << endl;
    cout << "snd = " << snd(p) << endl;
}

