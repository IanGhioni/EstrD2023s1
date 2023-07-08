#include <iostream>
#include <algorithm>
#include "BiBST.h"
#include "TiposBasicos.h"
using namespace std;

//==========================================================================
// Invariante de representación
//==========================================================================
/*
INV.REP.:
  Siendo "kx" y "ky" las claves del nodo actual (las cuales llamare "x" e "y", respectivamente), 
  "bolitas" las bolitas de este nodo, y "hijo" los subarboles del arbol:
    * No existe un par de claves repetida en el arbol.
    * La cantidad de bolitas es mayor o igual a 0.
    * Todos los subarboles indexado por 0 cumplen que sus claves kx son menores que x y sus claves ky son menores que y.
    * Todos los subarboles indexado por 1 cumplen que sus claves kx son menores que x y sus claves ky son mayores/iguales que y.
    * Todos los subarboles indexado por 2 cumplen que sus claves kx son mayores/iguales que x y sus claves ky son menores que y.
    * Todos los subarboles indexado por 3 cumplen que sus claves kx son mayores/iguales que x y sus claves ky son mayores/iguales que y.
    * Los subarboles del array de "hijo", cumplen con estos invariantes previamente mencionados
  */











//==========================================================================

//___FUNCION AUXILIAR___
Cuadrante cuadranteCorrespondiente(int kx, int ky, int x, int y) {
  // Proposito: Dado el par de claves (kx,ky) y el par de claves (x,y), retorna el cuadrante correspondiente 
  // al comparar ambas claves.
  // * x > kx && y > ky expresa el cuadrante NE.
  // * x > kx && y <= ky expresa el cuadrante SE.
  // * x <= kx && y > ky expresa el cuadrante NO.
  // * x <= kx && y <= ky expresa el cuadrante SO.
  if (x > kx && y > ky) {
    return NE; 
  }
  else if (x > kx && y <= ky) {
    return SE;
  }
  else if (x <= kx && y > ky) {
    return NO;
  }
  else {
    return SO;
  }
}

BBNode* findBBNode(BBNode* nodo, int x, int y) {
  // Proposito: Dado un arbol BiBST y dos claves, devuelve el nodo cuyas claves sean iguales a "x" e "y".
  // Retorna NULL si no existe el nodo.
  if (nodo == EMPTYBB) { // Si el nodo recibido es NULL, significa que no existe el nodo buscado, 
    return EMPTYBB;      // por lo tanto, retorno NULL.
  }
  else if (nodo->kx == x && nodo->ky == y) { // Si las claves del nodo son iguales a la clave (x,y)
    return nodo;                             // retorno el nodo.
  }
  else { // Si no son iguales, sigue buscando en el cuadrante correspondiente la clave (x,y)
    return findBBNode(nodo->hijo[cuadranteCorrespondiente(nodo->kx, nodo->ky, x,y)], x, y);
  }
}

BBNode* insertBBNode(BBNode* nodo, int x, int y) { 
  // Proposito: Dado un nodo y dos claves, devuelve el nodo cuyas claves sean iguales a "x" e "y".
  // Si el nodo no existe, crea un nodo nuevo con esas claves.
  if (nodo == EMPTYBB) {  
    BBNode* nodoNuevo = new BBNode;       // Si la raiz es null, no hay hijos en los cuales insertar el nodo, 
    nodoNuevo->kx = x; nodoNuevo->ky = y; // por lo tanto creo el nodo y retorno ese nodo.
    return nodoNuevo;
  }
  else if(nodo->kx == x && nodo->ky == y) { // Verifico si la raiz es el nodo que estoy buscando
    return nodo;
  }
  else if (nodo->hijo[cuadranteCorrespondiente(nodo->kx, nodo->ky, x,y)] == EMPTYBB) {
    BBNode* nodoNuevo = new BBNode;
    nodoNuevo->kx = x; nodoNuevo->ky = y;
    nodo->hijo[cuadranteCorrespondiente(nodo->kx, nodo->ky, x,y)] = nodoNuevo;
    return nodoNuevo;
  }
  else {
    return insertBBNode(nodo->hijo[cuadranteCorrespondiente(nodo->kx, nodo->ky, x,y)],x,y);
  }
  
}

void LiberarBiBST(BiBST t) { 
  // Proposito: Dado un arbol, libera la memoria ocupada por el arbol. 
  if (t != EMPTYBB) { // Si t no es null, primero libero la memoria de sus hijos y luego libero la memoria de t.
    LiberarBiBST(t->hijo[NE]);
    LiberarBiBST(t->hijo[SE]);
    LiberarBiBST(t->hijo[NO]);
    LiberarBiBST(t->hijo[SO]);
    delete t;
  }
}












// Impresión para verificaciones

void PrintBBNode(BBNode* t, int tab) {
  if (t == NULL) { return; }
  INDENT(tab)
  cout << "  (" << t->kx << "," << t->ky << "): ";
  PRINTCOLORN(AZUL , t->bolitas[AZUL ]); 
  cout << ", "; PRINTCOLORN(NEGRO, t->bolitas[NEGRO]); 
  cout << ", "; PRINTCOLORN(ROJO , t->bolitas[ROJO ]); 
  cout << ", "; PRINTCOLORN(VERDE, t->bolitas[VERDE]); 
  cout << endl;
  PrintBBNode(t->hijo[NE], ++tab);
  PrintBBNode(t->hijo[SE], tab);
  PrintBBNode(t->hijo[NO], tab);
  PrintBBNode(t->hijo[SO], tab);
}

void PrintBB(BiBST t) {
  cout << "BiBST:" << endl;
  PrintBBNode(t, 0);
}
