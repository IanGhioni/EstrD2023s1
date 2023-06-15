#include <iostream>
using namespace std;
#include <iomanip>
#include "TiposBasicos.h"
#include "TableroInfinito.h"




int main() {
    //// g++ -o app testTableroInfinito.cpp TableroInfinito.cpp TableroInfinito.h BiBST.h BiBST.cpp
    TableroInfinito t = TInfInicial();
    MoverNTInf(t,NORTE, 3);
    PonerNTInf(t, AZUL, 5);
    MoverNTInf(t,SUR, 3);
    PonerNTInf(t, AZUL, 5);
    MoverNTInf(t,ESTE, 3);
    PonerNTInf(t, AZUL, 5);
    MoverNTInf(t,OESTE, 6);
    PonerNTInf(t, AZUL, 5);
    MoverNTInf(t, ESTE, 3);
    PrintRepTInf(t);
}