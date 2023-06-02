#include "Poke.h"
#include <iostream>
using namespace std;

struct EntrenadorSt {
    string nombre;
    Pokemon* pokemon;
    int cantPokemon;
};
typedef EntrenadorSt* Entrenador;
typedef string TipoDelPokemon;

Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon);
string nombreDeEntrenador(Entrenador e);
int cantidadDePokemon(Entrenador e);
int cantidadDePokemonDe(TipoDelPokemon tipo, Entrenador e);
Pokemon pokemonNro(int i, Entrenador e);
//Precondición: existen al menos i − 1 pokémon.
//bool leGanaATodos(Entrenador e1, Entrenador e2);
