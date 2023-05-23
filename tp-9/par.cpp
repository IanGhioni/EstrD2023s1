#include "par.h"
/*
{}
*/
//! LA IMPLEMENTACION DE UNA ESTRUCTURA EN UN ARCHIVO .cpp
//! ACA NO ES NECESARIA LA DEFINICION DE LA ESTRUCTURA

Par consPar(int x, int y) {
    Par p;
    p.x = x;
    p.y = y; 
    return(p);
}

// Propósito: devuelve la primera componente
int fst(Par p) {
    return p.x;
}

// Propósito: devuelve la segunda componente
int snd(Par p) {
    return p.y;
}

int maxDelPar(Par p) {
    if (p.x > p.y) {
        return(p.x);
    }
    else { return(p.y); };
}

Par swap(Par p) {
    return(consPar(p.y,p.x));
}

Par divisionYResto(int n, int m) {
    return(consPar( n/m , n%m ));
}