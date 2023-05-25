#include "fraccion.h"

// Propósito: construye una fraccion
// Precondición: el denominador no es cero
Fraccion consFraccion(int numerador, int denominador) {
    Fraccion f;
    f.denominador = denominador;
    f.numerador = numerador;
    return(f);
}

// Propósito: devuelve el numerador
int numerador(Fraccion f) {
    return(f.numerador);
}


// Propósito: devuelve el denominador
int denominador(Fraccion f) {
    return(f.denominador);
}


// Propósito: devuelve el resultado de hacer la división
float division(Fraccion f) {
    return(f.numerador / f.denominador);
}


// Propósito: devuelve una fracción que resulta de multiplicar las fracciones
// (sin simplificar)
Fraccion multF(Fraccion f1, Fraccion f2) {
    return(
        consFraccion(f1.numerador*f2.numerador, f1.denominador*f2.denominador)
    );
}


//! Propósito: devuelve una fracción que resulta
//! de simplificar la dada por parámetro
//!Fraccion simplificada(Fraccion p) {

//!}

int minComunMultiplo(int z, int w) {
    if (z == w) {
        return(z);
    }
    int a = z; 
    int b = w;
    if (w > z) {
        b = z;
        a = w;
    }
    int x = z;
    int y = w;
    int r;

    while(!b == 0) {
        r = a % b;
        a = b;
        b = r;
    }
    return (x/a * y);
}


// Propósito: devuelve la primera componente
Fraccion sumF(Fraccion f1, Fraccion f2) {
    int mcm = minComunMultiplo(f1.denominador,f2.denominador);
    return(
        consFraccion((mcm/f1.denominador * f1.numerador) + (mcm/f2.denominador * f2.numerador), mcm)
    );
}