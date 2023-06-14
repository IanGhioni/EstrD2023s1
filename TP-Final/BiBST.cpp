#include <iostream>
#include <algorithm>
#include "BiBST.h"
//! VER ESTO CON ALGUIEN QUE SEPA xD
#include "TiposBasicos.h"
using namespace std;

//==========================================================================
// Invariante de representación
//==========================================================================
/* 
  ?INV.REP.
  Siendo "kx" y "ky" las claves del nodo actual (las cuales llamare "x" e "y", respectivamente), 
  "bolitas" las bolitas de este nodo, y "hijo" los subarboles del arbol:
    * kx es un numero entero.
    * ky es un numero entero.
    * No existe una clave repetida en el arbol.
    * "bolitas" son las 4 cantidades de bolitas de color azul, negro, rojo y verde, indexadas en ese orden.
        * La cantidad de bolitas por color es mayor o igual a 0.
    * "hijo" son los 4 subarboles indexados por cuadrante en el siguiente orden: NE, SE, NO, SO.
        * El subarbol indexado por NE cumple que su clave kx es menor que x y su clave ky es menor que y.
        * El subarbol indexado por SE cumple que su clave kx es menor que x y su clave ky es mayor/igual que y.
        * El subarbol indexado por NO cumple que su clave kx es mayor/igual que x y su clave ky es menor que y.
        * El subarbol indexado por SO cumple que su clave kx es mayor/igual que x y su clave ky es mayor/igual que y.
    
    * Los subarboles de cada subarbol del arreglo de "hijo, cumplen con estos invariantes previamente mencionados
  */











//==========================================================================
//TODO: Implementación
//==========================================================================

//? ___FUNCION AUXILIAR_____
Cuadrante cuadranteCorrespondiente(int kx, int ky, int x, int y) {
  // Proposito: Dado el par de claves (kx,ky) y el par de claves (x,y), retorna el cuadrante correspondiente 
  // al comparar ambas claves.
  if (x > kx && y > ky) {
    return NE; 
  }
  else if (x > kx && y <= ky) {
    return SE;
  }
  else if (x <= kx && y > ky) {
    return NO;
  }
  else if (x <= kx && y <= ky) {
    return SO;
  }
}

//? ___FUNCION AUXILIAR_____
BBNode* insertNextBBNode(BBNode* nodoPadre, BBNode* nodo, int x, int y) {
  // Proposito: Dado 2 nodos y un par de claves x e y, devuelve el nodo cuyas claves sean iguales a "x" e "y".
  // Si el nodo no existe, crea un nodo nuevo con esas claves y lo inserta como hijo del nodo "nodoPadre".
  // Precondicion: "nodo" debe ser un nodo hijo de "nodoPadre".
  if (nodo == nullptr) {                  // Si nodo es NULL, significa que no existe nodos con las claves x e y.
    BBNode* nodoNuevo = new BBNode;       // Por lo tanto, creo un nodo con esas claves, lo inserto como hijo de nodoPadre
    nodoNuevo->kx = x; nodoNuevo->ky = y; // en el cuadrante que corresponde, y finalmente retorno el nodo creado
    nodoPadre->hijo[cuadranteCorrespondiente(nodoPadre->kx,nodoPadre->ky, x, y)] = nodoNuevo; 
    return nodoNuevo;
  }
  else if (nodo->kx == x && nodo->ky == y) { // Si no es NULL, entonces verifico que las claves de nodo sea las mismas
    return nodo;                             // que la clave (x,y) y si lo son, retorno el nodo. 
  }
  else { // Si no son iguales, sigo buscando en el hijo de "nodo" del cuadrante correspondiente.
    BBNode* nodoHijo = nodo->hijo[cuadranteCorrespondiente(nodoPadre->kx,nodoPadre->ky, x, y)];
    return insertNextBBNode(nodo, nodoHijo, x, y);
  }
}


BBNode* findBBNode(BBNode* nodo, int x, int y) {
  // Proposito: Dado un arbol BiBST y dos claves, devuelve el nodo cuyas claves sean iguales a "x" e "y".
  // Retorna NULL si no existe el nodo.
  if (nodo == nullptr) { // Si el nodo recibido es NULL, significa que no existe el nodo buscado, 
    return nullptr;      // por lo tanto, retorno NULL.
  }
  else if (nodo->kx == x && nodo->ky == y) { // Si las claves del nodo son iguales a la clave (x,y)
    return nodo;                             // retorno el nodo.
  }
  else { // Si no son iguales, sigue buscando en el cuadrante correspondiente la clave (x,y)
    findBBNode(nodo->hijo[cuadranteCorrespondiente(nodo->kx, nodo->ky, x,y)], x, y);
  }
  // TODO: ¿REFACTORIZAR?
}

/*
BBNode* sigNodoCorespondiente(BBNode* nodo, int x, int y) {
  //! Proposito: Dado un nodo y dos claves, retorna el hijo correspondiente en base a las claves dadas.
  //! Precondicion: nodo no es NULL.
  if (nodo->kx > x && nodo->ky > y) {
    return nodo->hijo[0];
  }
  else if (nodo->kx > x && nodo->ky <= y) {
    return nodo->hijo[1];
  }
  else if (nodo->kx <= x && nodo->ky > y) {
    return nodo->hijo[2];
  }
  else if (nodo->kx <= x && nodo->ky <= y) {
    return nodo->hijo[3];
  }
}
*/

BBNode* insertBBNode(BBNode* nodo, int x, int y) { 
  // Proposito: Dado un nodo y dos claves, devuelve el nodo cuyas claves sean iguales a "x" e "y".
  // Si el nodo no existe, crea un nodo nuevo con esas claves.
  if (nodo == nullptr) {  
    BBNode* nodoNuevo = new BBNode;      // Como explicar este caso borde de que la raiz es null entonces lo creo
    nodoNuevo->kx = x; nodoNuevo->ky = y;// al nodo y retorno eso nada mas.
    return nodoNuevo;
  }
  else { // El otro caso de que la raiz no sea null, entonces busco en el hijo correspondiente y me guardo el nodo padre.
    return insertNextBBNode(nodo, nodo->hijo[cuadranteCorrespondiente(nodo->kx, nodo->ky, x,y)], x, y);
  }
}


void LiberarBiBST(BiBST t) { 
  // Dado un arbol, libera la memoria ocupada por el arbol. 
  if (t != nullptr) { // Si t no es null, primero libero la memoria de sus hijos y luego libero la memoria de t.
    LiberarBiBST(t->hijo[0]);
    LiberarBiBST(t->hijo[1]);
    LiberarBiBST(t->hijo[2]);
    LiberarBiBST(t->hijo[3]);
    delete t;
  }
}











//==========================================================================
// Impresión para verificaciones
//==========================================================================
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

