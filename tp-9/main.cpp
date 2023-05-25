#include "par.h"
#include <list>
#include <iostream>
#include "fraccion.h"
using namespace std;


// Precondición: c1 < c2
void printFromTo(char c1, char c2) {
    for(int i = 0; c1 + i <= c2; i++) {
        cout << c1 + i << ", ";
    }
    cout << endl;
}

//? Ejercicio 4
//! Versiones iterativas (Descomentar para probar)
/*
void printN(int n, string s) { //Propósito: imprime n veces un string s.
    for(int i = n; !n == 0; n--) {
        cout<< s << " ";
    }
    cout<<endl;
}

void cuentaRegresiva(int n) { //Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
    for(int i = n; i != 0; i--) {
        cout << i << endl;
    }
    cout<< 0 <<endl;
}

void desdeCeroHastaN(int n) { //Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
    for(int i = 0; i != n; i ++) {
        cout << i << endl;
    }
    cout << n << endl;
}

int mult(int n, int m) { //Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
    int x = 0;
    while(m!=0) {
        x+=n;
        m=m-1;
    }
    return(x);
}

void primerosN(int n, string s) {
//Propósito: imprime los primeros n char del string s, separados por un salto de línea.
//Precondición: el string tiene al menos n char.
    for(int i = 0; i != n; i++) {
        cout<< s[i] << endl;
    }
}

bool pertenece(char c, string s) {
//Propósito: indica si un char c aparece en el string s.
    for(int i = 0; i != s.size(); i++) {
        if (s[i] == c) {
            return(true);
        }
    }
    return(false);
}

int apariciones(char c, string s) {
//Propósito: devuelve la cantidad de apariciones de un char c en el string s.
    int x = 0;
    for(int i = 0; i != s.size(); i++) {
        if (s[i] == c) {
            x++;
        }
    }
    return(x);
}
*/






//! Versiones Recursivas (Descomentar para probar)
/*
void printN(int n, string s) {  //Propósito: imprime n veces un string s.
    if (n == 1) {
        cout << s << endl; 
    }
    else { 
        cout << s << endl;
        printN(n-1,s);
    };
}

void cuentaRegresiva(int n) { //Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
    if (n==0) {
        cout << 0 << endl;
    }
    else {
        cout << n << endl;
        cuentaRegresiva(n-1);
    }
}

void desdeMHastaN(int m, int n) { //Propósito: imprime los números de m hasta n, separados por saltos de línea.
    if (n==m) {
        cout << n << endl;
    }
    else {
        cout << m << endl;
        desdeMHastaN(m+1,n);
    }
}

void desdeCeroHastaN(int n) { //Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
    desdeMHastaN(0, n);
}


int mult(int n, int m) { //Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
    int x = 0;
    if (m==0) {
        return(x);
    }
    else {
        return (n + mult(n,m-1));
    }   
}

void primerosN(int n, string s) {
//Propósito: imprime los primeros n char del string s, separados por un salto de línea.
//Precondición: el string tiene al menos n char.
    if (n==0) {
        cout << endl;
    }
    else {
        cout << s[0] << endl;
        primerosN(n-1,s.erase(0,1));        
    }
}

bool pertenece(char c, string s) {
//Propósito: indica si un char c aparece en el string s.
    if (s.length() == 0) { 
        return(false);  
    }
    else {
        return( 
            s[0] == c || pertenece( c , s.erase(0,1)) 
        );
    }
}

int unoSi(bool b) {
    if (b) { return(1); }
    else { return(0); }
}

int apariciones(char c, string s) {
    //Propósito: devuelve la cantidad de apariciones de un char c en el string s.
    if (s.length() == 0) { 
        return(0);  
    }
    else {
        return( unoSi(s[0] == c) + apariciones( c , s.erase(0,1)) );
    }
}
*/







int main() {
    Fraccion f1 = consFraccion(2,3);
    Fraccion f2 = consFraccion(10,5);

    cout << "numerador " << numerador(f1) << endl;
    cout << "denominador " << denominador(f1) << endl;
    cout << "division " << division(f2) << endl;
    cout << "multiplicacion " << numerador(multF(f1,f2)) << "/" << denominador(multF(f1,f2)) << endl;
    cout << "suma " << numerador(sumF(f1,f2)) << "/" << denominador(sumF(f1,f2)) << endl;
}

