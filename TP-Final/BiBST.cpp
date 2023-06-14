#include <iostream>
#include <algorithm>
#include "BiBST.h"
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
// Implementación
//==========================================================================
BBNode* findBBNode(BBNode* nodo, int x, int y) { 
  return NULL; // TODO: REEMPLAZAR
}

BBNode* insertBBNode(BBNode* nodo, int x, int y) { 
  return NULL; // TODO: REEMPLAZAR
  //! PISTA: Guardar el nodo anterior al actual para poder realizar la insercion.
}

void LiberarBiBST(BiBST t) { 
  // TODO: COMPLETAR
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

