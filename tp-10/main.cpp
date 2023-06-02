#include "Poke.h"
#include <iostream>
using namespace std; 

int main() {
    Pokemon bulbasaur = consPokemon("Planta");
    Pokemon charmander = consPokemon("Fuego");
    
    cout << superaA(charmander, bulbasaur) << endl;
}
