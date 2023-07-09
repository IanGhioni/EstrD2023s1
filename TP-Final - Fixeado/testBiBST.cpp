#include <iostream>
#include <algorithm>
#include "BiBST.h"

int main() {
    // g++ -o app testBiBST.cpp  BiBST.h BiBST.cpp QueueBiBST.cpp QueueBiBST.h StackBiBST.cpp StackBiBST.h
    BiBST t = EMPTYBB;
    //? TESTEANDO insertBBNode;
    t = insertBBNodeBFS(t, 0, 0); cout << "Paso el insert de EMPTYBB" << endl;
    insertBBNode(t, 0, 1);
    insertBBNode(t, 0, 2);
    insertBBNode(t, 0, 3);
    insertBBNode(t, 0, 4);
    insertBBNode(t, 0, 5);
    insertBBNode(t, 1, 2);
    insertBBNode(t, 1, 3);
    insertBBNode(t, 1, 5);
    insertBBNode(t, 2, 3);
    insertBBNode(t, 2, 4);
    insertBBNode(t, 2, 1); 
    insertBBNode(t, 1, 1); 
    insertBBNode(t, 2, (-2));  
    insertBBNode(t, (-4), (-3));
    insertBBNode(t, (-40), (-10));
    insertBBNode(t, (-50), (-20));
    insertBBNode(t,-60,-30);
    insertBBNode(t,-65,-35);
    insertBBNode(t,-90,-100);
    /*
    BiBST testDFS = insertBBNodeDFS(t,-100,-80);
    if (testDFS == EMPTYBB) {
        cout << "Esta retornando emptyBB :(" << endl;
    }
    else { 
        cout << "Lo retorno bien :)" << endl; 
    }
    cout << "(" << testDFS->kx << "," << testDFS->ky << ")" << endl;
    testDFS = insertBBNodeDFS(t,0,0);
    cout << "(" << testDFS->kx << "," << testDFS->ky << ")" << endl;
    testDFS = insertBBNodeDFS(t,2,3);
    cout << "(" << testDFS->kx << "," << testDFS->ky << ")" << endl;
    testDFS = insertBBNodeDFS(t,-800,-900);
    cout << "(" << testDFS->kx << "," << testDFS->ky << ")" << endl;
    cout << endl;
    */
    BiBST testBFS = insertBBNodeBFS(t,-100,-80);
    if (testBFS == EMPTYBB) {
        cout << "Esta retornando emptyBB :(" << endl;
    }
    else { 
        cout << "Lo retorno bien :)" << endl; 
    }
    cout << "(" << testBFS->kx << "," << testBFS->ky << ")" << endl;
    testBFS = insertBBNodeBFS(t,0,0);
    cout << "(" << testBFS->kx << "," << testBFS->ky << ")" << endl;
    testBFS = insertBBNodeBFS(t,2,3);
    cout << "(" << testBFS->kx << "," << testBFS->ky << ")" << endl;
    testBFS = insertBBNodeBFS(t,-800,-900);
    cout << "(" << testBFS->kx << "," << testBFS->ky << ")" << endl;
    PrintBB(t);
    cout << endl;
    /*
    cout << "(" << findBBNode(t,-60,-30)->kx  << "," << findBBNode(t,-60,-30)->ky << ")" << endl;
    cout << "(" << findBBNode(t,-65,-35)->kx  << "," << findBBNode(t,-65,-35)->ky << ")" << endl;
    cout << "(" << findBBNode(t,-90,-100)->kx  << "," << findBBNode(t,-90,-100)->ky << ")" << endl;
    cout << "(" << findBBNode(t,-100,-80)->kx  << "," << findBBNode(t,-100,-80)->ky << ")";
    cout << endl;
    cout << "(" << findBBNode(t,0,0)->kx  << "," << findBBNode(t,0,0)->ky << ")" << endl;
    cout << "(" << findBBNode(t,0,1)->kx  << "," << findBBNode(t,0,1)->ky << ")" << endl;
    cout << "(" << findBBNode(t,0,2)->kx  << "," << findBBNode(t,0,2)->ky << ")" << endl;
    cout << "(" << findBBNode(t,0,4)->kx  << "," << findBBNode(t,0,4)->ky << ")" << endl;
    cout << "(" << findBBNode(t,0,5)->kx  << "," << findBBNode(t,0,5)->ky << ")" << endl;
    cout << "(" << findBBNode(t,1,1)->kx  << "," << findBBNode(t,1,1)->ky << ")" << endl;
    cout << "(" << findBBNode(t,1,2)->kx  << "," << findBBNode(t,1,2)->ky << ")" << endl;
    cout << "(" << findBBNode(t,1,3)->kx  << "," << findBBNode(t,1,3)->ky << ")" << endl;
    cout << "(" << findBBNode(t,1,5)->kx  << "," << findBBNode(t,1,5)->ky << ")" << endl;
    cout << "(" << findBBNode(t,2,1)->kx  << "," << findBBNode(t,2,1)->ky << ")" << endl;
    cout << "(" << findBBNode(t,2,3)->kx  << "," << findBBNode(t,2,3)->ky << ")" << endl;
    cout << "(" << findBBNode(t,2,4)->kx  << "," << findBBNode(t,2,4)->ky << ")" << endl;
    cout << "(" << findBBNode(t,2,(-2))->kx  << "," << findBBNode(t,2,(-2))->ky << ")" << endl;
    cout << "(" << findBBNode(t,(-4),(-3))->kx  << "," << findBBNode(t,(-4),(-3))->ky << ")" << endl;
    cout << "(" << findBBNode(t,(-40),(-10))->kx  << "," << findBBNode(t,(-40),(-10))->ky << ")" << endl;
    cout << "(" << findBBNode(t,(-50),(-20))->kx  << "," << findBBNode(t,(-50),(-20))->ky << ")" << endl;
    
    BiBST x;
    x = findBBNodeDFS(t,0,0);
    cout << "(" << x->kx << "," << x->ky << ")" << endl;
    x = findBBNodeDFS(t,2,3);
    cout << "(" << x->kx << "," << x->ky << ")" << endl;
    x = findBBNodeDFS(t,-100,-80);
    cout << "(" << x->kx << "," << x->ky << ")" << endl;
    x = findBBNodeDFS(t,2,-2);
    cout << "(" << x->kx << "," << x->ky << ")" << endl;
    x = findBBNodeDFS(t,-65,-35);
    cout << "(" << x->kx << "," << x->ky << ")" << endl;

    x = findBBNodeDFS(t,0,-800);
    if (x == EMPTYBB) {
        cout << "Paso el test :)" << endl;
    }
    else { cout << "No paso el test" << endl;}*/
}
