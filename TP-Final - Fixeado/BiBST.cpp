#include <iostream>
#include <algorithm>
#include "BiBST.h"
#include "TiposBasicos.h"
#include "QueueBiBST.h"
#include "StackBiBST.h"
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

int cantDeBolitasBFS(BiBST t) {
  BiBST actual; int bolitas = 0; Queue q = emptyQ();
  if (t != EMPTYBB) { Enqueue(t,q); }
  while (!isEmptyQ(q)) {
    actual = firstQ(q); Dequeue(q);
    bolitas += actual->bolitas[0] + actual->bolitas[1] + actual->bolitas[2] + actual->bolitas[3];
    if (actual->hijo[0] != EMPTYBB) { Enqueue(actual->hijo[0],q); }
    if (actual->hijo[1] != EMPTYBB) { Enqueue(actual->hijo[1],q); }
    if (actual->hijo[2] != EMPTYBB) { Enqueue(actual->hijo[2],q); }
    if (actual->hijo[3] != EMPTYBB) { Enqueue(actual->hijo[3],q); }
  }
  DestroyQ(q);
  return bolitas;
}

int cantDeBolitasDFS(BiBST t) {
  BiBST actual;  
  int bolitas = 0; 
  Stack s = emptyS(); 
  if (t != EMPTYBB) { apilar(t,s); }
  while (!isEmptyS(s)) {
    actual = firstS(s); desapilar(s); 
    bolitas += actual->bolitas[0] + actual->bolitas[1] + actual->bolitas[2] + actual->bolitas[3];
    if (actual->hijo[3] != EMPTYBB) { apilar(actual->hijo[3],s); }
    if (actual->hijo[2] != EMPTYBB) { apilar(actual->hijo[2],s); }
    if (actual->hijo[1] != EMPTYBB) { apilar(actual->hijo[1],s); }
    if (actual->hijo[0] != EMPTYBB) { apilar(actual->hijo[0],s); }
  }
  destroyS(s);
  return bolitas;
}

BBNode* findBBNodeBFS(BBNode* t, int x, int y) {
  BiBST actual; Queue q = emptyQ();
  BiBST ret = EMPTYBB;
  if (t != EMPTYBB) { Enqueue(t,q); }
  while (!isEmptyQ(q)) {
    actual = firstQ(q); Dequeue(q);
    if (actual->kx == x && actual->ky == y) {
      ret = actual;
      break;
    }
    if (actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)] != EMPTYBB) { 
      Enqueue(actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)], q); 
    }
  }
  DestroyQ(q);
  return ret;
}

BBNode* findBBNodeDFS(BBNode* t, int x, int y) {
  BiBST actual; Stack s = emptyS();
  BiBST ret = EMPTYBB;
  if (t != EMPTYBB) { apilar(t,s); }
  while (!isEmptyS(s)) {
    actual = firstS(s); desapilar(s);
    if (actual->kx == x && actual->ky == y) {
      ret = actual;
      break;
    }
    if (actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)] != EMPTYBB) { 
      apilar(actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)], s); 
    }
  }
  destroyS(s);
  return ret;
}

BBNode* insertBBNodeBFS(BBNode* t, int x, int y) {
  BiBST actual; 
  BiBST ret = EMPTYBB;
  if (t != EMPTYBB) { 
    Queue q = emptyQ();
    Enqueue(t,q);
    while (!isEmptyQ(q)) {
      actual = firstQ(q); Dequeue(q); 
      if (actual->kx == x && actual->ky == y) {
        DestroyQ(q);
        return actual;
      }
      else if (actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)] != EMPTYBB) { 
        Enqueue(actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)], q);
      }
      else {
        DestroyQ(q); 
        BBNode* ret = new BBNode;    
        ret->kx = x; ret->ky = y; 
        actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)] = ret; 
        return ret;
      }
    }
  }
  else {
    BBNode* ret = new BBNode; 
    ret->kx = x; ret->ky = y;
    return ret;
  }
}

BBNode* insertBBNodeDFS(BBNode* t, int x, int y) {
  BiBST actual;
  BiBST ret = EMPTYBB;
  if (t != EMPTYBB) { 
    Stack s = emptyS();
    apilar(t,s); 
    while (!isEmptyS(s)) {
      actual = firstS(s); desapilar(s); 
      if (actual->kx == x && actual->ky == y) {
        destroyS(s);
        return actual;
      }
      else if (actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)] != EMPTYBB) { 
        apilar(actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)], s);    
      }
      else {
        destroyS(s); 
        BBNode* ret = new BBNode; 
        ret->kx = x; ret->ky = y; 
        actual->hijo[cuadranteCorrespondiente(actual->kx,actual->ky,x,y)] = ret; 
        return ret;
      }
    }
  }
  else {
    BBNode* ret = new BBNode; 
    ret->kx = x; ret->ky = y;
    return ret;
  }
}
