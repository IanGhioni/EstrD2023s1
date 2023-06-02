#include <iostream>
using namespace std; // Sin estas 2 lineas no puedo renombrar al string como TipoDelPokemon
#include "Poke.h"
/*
{}
*/
Pokemon consPokemon(TipoDelPokemon tipo) {
    PokeSt* p = new PokeSt;
    (*p).tipo = tipo;
    (*p).energia = 100;
    return p; 
    // SOLO RETORNO EL PUNTERO
}
TipoDelPokemon tipoDePokemon(Pokemon p) {
    return (*p).tipo;
}
int energia(Pokemon p) {
    return (*p).energia;
}
void perderEnergia(int e, Pokemon p) {
    (*p).energia = (*p).energia - e;
}

bool superaA(Pokemon p1, Pokemon p2) {
    TipoDelPokemon t1 = (*p1).tipo; 
    TipoDelPokemon t2 = (*p2).tipo;
    return
    (t1 == "Agua" && t2 == "Fuego")
    ||
    (t1 == "Fuego" && t2 == "Planta")
    ||
    (t1 == "Planta" && t2 == "Agua");
}