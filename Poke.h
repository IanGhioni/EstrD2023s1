#include <iostream>
using namespace std; // Sin estas 2 lineas no puedo renombrar al string como TipoDelPokemon
// ACA en el .h va la interfaz de operaciones y los otros tipos de datos que se definen
typedef string TipoDelPokemon;

struct PokeSt {
    TipoDelPokemon tipo;
    int energia;
};

typedef PokeSt* Pokemon;

Pokemon consPokemon(TipoDelPokemon tipo);
TipoDelPokemon tipoDePokemon(Pokemon p);
int energia(Pokemon p);
void perderEnergia(int e, Pokemon p);
bool superaA(Pokemon p1, Pokemon p2);

/*
{}
*/