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
  // TODO: COMPLETAR
}; 
/* INV.REP.:
  TODO: 
    * COMPLETAR
*/

//--------------------------------------------------------------------------
TableroInfinito TInfInicial(){
  return NULL; // TODO: REEMPLAZAR
}

//--------------------------------------------------------------------------
void PonerNTInf(TableroInfinito t, Color color, int n){
  // PRECOND: el color es válido
  // TODO: COMPLETAR
}

//--------------------------------------------------------------------------
void SacarNTInf(TableroInfinito t, Color color, int n){
  // PRECOND:
  //  * el color es válido
  //  * hay al menos n bolitas en la celda actual en t
  
  // TODO: COMPLETAR
}

//--------------------------------------------------------------------------
void MoverNTInf(TableroInfinito t, Dir dir, int n){
  // PRECOND: la dirección dada es válida
  // TODO: COMPLETAR
}

//--------------------------------------------------------------------------
int nroBolitasTInf(TableroInfinito t, Color color) {
  // PRECOND: el color es válido
  return 0; // TODO: REEMPLAZAR
}

//--------------------------------------------------------------------------
void LiberarTInf(TableroInfinito t){
  // TODO: COMPLETAR
}

//==========================================================================
// Impresión para verificaciones
//==========================================================================
void PrintRepTInf(TableroInfinito t) {
  // TODO: COMPLETAR 
  // PISTA: utilizar PrintBB de BiBST
}
