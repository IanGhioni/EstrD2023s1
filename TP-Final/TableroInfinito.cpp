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
  BiBST celdaActual; // Celda actual donde se encuentra el cabezal
  int x; // Coordenada x de la celda actual.
  int y; // Coordenada y de la celda actual.
  BiBST tablero; // Tablero

}; 
/* INV.REP.:
  TODO: REVISAR MAÑANA
    * celdaActual es la celda actual en la que se encuentra el cabezal.
    * celdaActual debe ser una celda del tablero.
    * x es la coordenada x de celdaActual.
    * y es la coordenada y de celdaActual.
    * tablero es el tablero completo.
    * tablero no tiene celdas repetidas.
*/

//--------------------------------------------------------------------------
TableroInfinito TInfInicial(){
  // Proposito: Retorna un tablero infinito vacio de bolitas, dejando el cabezal en la posicion (0, 0).
  TableroInfinitoHeader* t = new TableroInfinitoHeader;
  t->x = 0; t->y = 0;
  t->tablero = insertBBNode(EMPTYBB, 0, 0);
  t->celdaActual = findBBNode(t->tablero, 0, 0);
  return t;
}

//--------------------------------------------------------------------------
void PonerNTInf(TableroInfinito t, Color color, int n){
  // Proposito: Dado un tablero, un color y un numero, pone n bolitas del color dado en la celda actual
  // PRECOND: 
  // * el color es válido
  // * n es un numero mayor a 0.
  t->celdaActual->bolitas[color]+=n;
}

//--------------------------------------------------------------------------
void SacarNTInf(TableroInfinito t, Color color, int n){
  // PRECOND:
  //  * el color es válido
  //  * hay al menos n bolitas en la celda actual en t
  //! ESTA PRECONDICION VINO DADA, ENTONCES NO VEO RAZON DE USAR BOOM.
  //! PREGUNTAR EN CLASE
  // TODO: COMPLETAR
}

//--------------------------------------------------------------------------
void MoverNTInf(TableroInfinito t, Dir dir, int n){
  // Proposito: Dado un tablero, una direccion y un numero, desplaza el cabezal n posiciones en la 
  // direccion dada, actualizando la posicion a la que apunta el cabezal.
  // PRECOND: la dirección dada es válida
  if (dir == NORTE) { // suma a y
    t->y += n;
    t->celdaActual = insertBBNode(t->tablero,t->x,t->y);
  }
  else if (dir == SUR) { // resta a y
    t->y -= n;
    t->celdaActual = insertBBNode(t->tablero,t->x,t->y);
  }
  else if (dir == ESTE) { // suma a x
    t->x += n;
    t->celdaActual = insertBBNode(t->tablero,t->x,t->y);
  }
  else { // resta a x
    t->x -= n;
    t->celdaActual = insertBBNode(t->tablero,t->x,t->y);
  }
}

//--------------------------------------------------------------------------
int nroBolitasTInf(TableroInfinito t, Color color) {
  // Proposito: Dado un tablero y un color, retorna la cantidad de boñitas del color dado que hay en la celda actual.
  // PRECOND: el color es válido
  return t->celdaActual->bolitas[color]; 
}

//--------------------------------------------------------------------------
void LiberarTInf(TableroInfinito t){
  // Proposito: Dado un tablero, libera la memoria ocupada por el tablero.
  LiberarBiBST(t->tablero);
}

//==========================================================================
// Impresión para verificaciones
//==========================================================================
void PrintRepTInf(TableroInfinito t) {
  cout << "Celda actual: (" << t->x << ", " << t->y << ")" << endl;
  PrintBB(t->tablero);
}
