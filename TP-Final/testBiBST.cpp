#include <iostream>
#include <algorithm>
#include "BiBST.h"

int main() {
    // g++ -o app testBiBST.cpp  BiBST.h BiBST.cpp
    BiBST t = EMPTYBB;
    // TESTEANDO insertBBNode;
    t = insertBBNode(t, 0, 0); // Se deberia insertar en la raiz.
    insertBBNode(t, 1, 1); // Se deberia insertar en el cuadrante NE
    insertBBNode(t, 2, (-2)); // Se deberia insertar en el cuadrante SE
    insertBBNode(t, 0, 1); // Se deberia insertar en el cuadrante NO
    insertBBNode(t, (-4), (-3)); // Se deberia insertar en el cuadrante SO

    cout << endl << "Tests de insertBBNode" << endl;
    cout << "CLAVES DE RAIZ deberia ser (0,0):" << endl;
    cout << "x = " << t->kx << endl;
    cout << "y = " << t->ky << endl << endl;
    cout << "CLAVES DE CUADRANTE NE deberia ser  (1,1):" << endl;
    cout << "x = " << t->hijo[0]->kx << endl;
    cout << "y = " << t->hijo[0]->ky << endl << endl;
    cout << "CLAVES DE CUADRANTE SE deberia ser (2,-2):" << endl;
    cout << "x = " << t->hijo[1]->kx << endl;
    cout << "y = " << t->hijo[1]->ky << endl << endl;
    cout << "CLAVES DE CUADRANTE NO deberia ser (0,1):" << endl;
    cout << "x = " << t->hijo[2]->kx << endl;
    cout << "y = " << t->hijo[2]->ky << endl << endl;
    cout << "CLAVES DE CUADRANTE SO deberia ser (-4,-3):" << endl;
    cout << "x = " << t->hijo[3]->kx << endl;
    cout << "y = " << t->hijo[3]->ky << endl << endl;
    
    
    
    // TESTEANDO findBBNode
    cout << "Tests de findBBNode" << endl << endl;
    cout << "Buscar "; 
    if (findBBNode(t,0,0) == nullptr) {
        cout << "Clave (0,0) FALLO, retorno nulo y no deberia :D" << endl;
    }
    else {cout << "Clave (0,0) paso el test :)" << endl; }
    cout << "Buscar ";
    if (findBBNode(t,1,1) == nullptr) {
        cout << "Clave (1,1) FALLO, retorno nulo y no deberia D:" << endl;
    }
    else {cout << "Clave (1,1) paso el test :) " << endl; }
    cout << "Buscar ";
    if (findBBNode(t,2,-2) == nullptr) {
        cout << "Clave (2,-2) FALLO, retorno nulo y no deberia D:" << endl;
    }
    else {cout << "Clave (2,-2) paso el test :)" << endl; }
    cout << "Buscar ";
    if (findBBNode(t,0,1) == nullptr) {
        cout << "Clave (0,1) FALLO, retorno nulo y no deberia D:" << endl;
    }
    else {cout << "Clave (0,1) paso el test :)" << endl; }
    cout << "Buscar ";
    if (findBBNode(t,-4,-3) == nullptr) {
        cout << "Clave (-4,-3) FALLO, retorno nulo y no deberia D:" << endl;
    }
    else {cout << "Clave (-4,-3) paso el test :D" << endl << endl; }
    

    cout << "Buscar clave que no existe: ";
    if (findBBNode(t,500,100) == nullptr) {
        cout << "Clave (500,100): Paso el test, retorno nulo como deberia ;)" << endl;
    }
    else {cout << "Clave (500,100): fallo el test, deberia ser null D:" << endl; }
    cout << "Buscar clave que no existe: ";
    if (findBBNode(t,-5,-32) == nullptr) {
        cout << "Clave (-5,-32): Paso el test, retorno nulo como deberia ;)" << endl;
    }
    else {cout << "Clave (-5,-32): fallo el test, deberia ser null D:" << endl << endl << endl; }
}

/* LO QUE DEBERIA RETORNARTE:

Tests de insertBBNode
CLAVES DE RAIZ deberia ser (0,0):
x = 0
y = 0

CLAVES DE CUADRANTE NE deberia ser  (1,1): 
x = 1
y = 1

CLAVES DE CUADRANTE SE deberia ser (2,-2): 
x = 2
y = -2

CLAVES DE CUADRANTE NO deberia ser (0,1):  
x = 0
y = 1

CLAVES DE CUADRANTE SO deberia ser (-4,-3):
x = -4
y = -3

Tests de findBBNode

Buscar Clave (0,0) paso el test :)
Buscar Clave (1,1) paso el test :)
Buscar Clave (2,-2) paso el test :)
Buscar Clave (0,1) paso el test :)
Buscar Clave (-4,-3) paso el test :D

Buscar clave que no existe: Clave (500,100): Paso el test, retorno nulo como deberia ;)
Buscar clave que no existe: Clave (-5,-32): Paso el test, retorno nulo como deberia ;)
*/