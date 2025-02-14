#include <iostream>
#include <iomanip>
#include <algorithm>
#include "TiposBasicos.h"
#include "TableroInfinito.h"
#include "BiBST.h"
using namespace std;

//==========================================================================
// Implementación de TableroInfinito
//==========================================================================
struct TableroInfinitoHeader {
  int x; // Coordenada x de la celda actual.
  int y; // Coordenada y de la celda actual.
  BiBST tablero; // Tablero
}; 
/* INV.REP.: 
    * No se pueden sacar bolitas de una celda si no hay suficientes.
*/

//--------------------------------------------------------------------------
TableroInfinito TInfInicial(){
  // Proposito: Retorna un tablero infinito vacio de bolitas, dejando el cabezal en la celda (0, 0).
  TableroInfinitoHeader* t = new TableroInfinitoHeader;
  t->x = 0; t->y = 0;
  t->tablero = EMPTYBB;
  return t;
}

//--------------------------------------------------------------------------
void PonerNTInf(TableroInfinito t, Color color, int n){
  // Proposito: Dado un tablero, un color y un numero, pone n bolitas del color dado en la celda actual
  // PRECOND: 
  //      * el color es válido
  //      * n es un numero mayor a 0.
  if (!VALIDCOLOR(color)) {
    BOOM("El color dado es invalido.");
  }
  else if (t->tablero == EMPTYBB) { 
    t->tablero = insertBBNode(t->tablero, t->x, t->y);
    findBBNode(t->tablero, t->x, t->y)->bolitas[color]+=n;
  }
  else {insertBBNode(t->tablero, t->x, t->y)->bolitas[color]+=n;}
}

//--------------------------------------------------------------------------
void SacarNTInf(TableroInfinito t, Color color, int n){
  // Proposito: Dado un tablero, un color y un numero n, 
  // saca de la celda actual n bolitas del color dado.
  // PRECONDICION:
  //      * el color es válido
  //      * hay al menos n bolitas en la celda actual en t
  //      * n es un numero mayor a 0.
  BiBST celdaActual = findBBNode(t->tablero,t->x,t->y);
  if (!VALIDCOLOR(color)) {
    BOOM("El color dado es invalido.");
  }
  else if (celdaActual == EMPTYBB || celdaActual->bolitas[color]-n < 0) { 
    // Si en la celda actual no hay al menos n bolitas para sacar, hago un BOOM.
    BOOM("No se puede sacar una bolita del color dado. No hay suficientes bolitas de ese color.");
  }
  else { // En caso de que haya, actualizo las bolitas de la celda actual.
    celdaActual->bolitas[color] -= n;
  } 
}

//--------------------------------------------------------------------------
void MoverNTInf(TableroInfinito t, Dir dir, int n){
  // Proposito: Dado un tablero, una direccion y un numero, desplaza el cabezal n posiciones en la 
  // direccion dada, actualizando la posicion a la que apunta el cabezal.
  // PRECOND: 
  //      * la dirección dada es válida.
  //      * n es un numero mayor a 0.
  if (!VALIDDIR(dir)) {
    BOOM("La dirección dada es invalida.");
  }
  else if (dir == NORTE) { // Si dir es NORTE, suma n a y
    t->y += n;
  }
  else if (dir == SUR) { // Si dir es SUR, resta n a y
    t->y -= n;
  }
  else if (dir == ESTE) { // Si dir es ESTE, suma n a x
    t->x += n;
  }            
  else {       // Si no es ninguno de los casos anteriores, entonces por precondicion es OESTE,
    t->x -= n; // porque es la unica direccion válida que queda. Por lo tanto, le resto n a x
  }
}

//--------------------------------------------------------------------------
int nroBolitasTInf(TableroInfinito t, Color color) {
  // Proposito: Dado un tablero y un color, retorna la cantidad de bolitas del color dado que hay en la celda actual.
  // PRECOND: el color es válido.
  if (!VALIDCOLOR(color)) {
    BOOM("El color dado es invalido.");
  }
  else if (findBBNode(t->tablero,t->x,t->y) == EMPTYBB) {
    return 0;
  }
  else { return findBBNode(t->tablero,t->x,t->y)->bolitas[color]; }
}

//--------------------------------------------------------------------------
void LiberarTInf(TableroInfinito t){
  // Proposito: Dado un tablero, libera la memoria ocupada por el tablero.
  LiberarBiBST(t->tablero);
  delete t;
}


// Impresión para verificaciones
void PrintRepTInf(TableroInfinito t) {
  cout << "Celda actual: (" << t->x << ", " << t->y << ")" << endl;
  PrintBB(t->tablero);
  cout << endl;
}




void cantDeBolitasEnElTablero(TableroInfinito t) {
  cout << "Retorna de cantDeBolitasBFS: " << cantDeBolitasBFS(t->tablero) << endl;
  cout << "Retorna de cantDeBolitasDFS: " << cantDeBolitasDFS(t->tablero) << endl;
}