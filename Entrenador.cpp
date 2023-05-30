#include <iostream>
using namespace std; 
#include "Entrenador.h"

Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon) {
    EntrenadorSt* e = new EntrenadorSt;
    (*e).nombre = nombre;
    (*e).cantPokemon = cantidad;
    (*e).pokemon = pokemon;
    return e;
}

string nombreDeEntrenador(Entrenador e) {
    return (*e).nombre;
}

int cantidadDePokemon(Entrenador e) {
    return (*e).cantPokemon;
}

int cantidadDePokemonDe(TipoDelPokemon tipo, Entrenador e) {
    int cantDelEntrenador = cantidadDePokemon(e);
    Pokemon* array = (*e).pokemon;  
    int n = 0;
    for (int i = 0; i != cantDelEntrenador; i++) {
        if (tipo == tipoDePokemon(array[i])) {
            n++;
        }
    }
    return(n);
}

Pokemon pokemonNro(int i, Entrenador e) {
    return (*e).pokemon[i-1];
}