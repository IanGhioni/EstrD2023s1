#include <iostream>
#include <algorithm>
#include "BiBST.h"

int main() {
    // g++ -o app testBiBST.cpp  BiBST.h BiBST.cpp
    BiBST t = EMPTYBB;
    //? TESTEANDO insertBBNode;
    t = insertBBNode(t, 0, 0);
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
    insertBBNode(t,-100,-80);

    cout << endl;
    PrintBB(t);
    cout << endl << endl;
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
}
