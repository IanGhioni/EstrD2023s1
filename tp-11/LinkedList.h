struct LinkedListSt;
struct IteradorSt;

typedef LinkedListSt* LinkedList;
typedef IteradorSt* ListIterator;

LinkedList nil();
bool isEmpty(LinkedList xs);
int length(LinkedList xs);
int head(LinkedList xs);
void tail(LinkedList xs);
void snoc(int x, LinkedList xs);
void cons(int x, LinkedList xs);

ListIterator getIterator(LinkedList xs);
int current(ListIterator it);
void setCurrent(int x, ListIterator it);
void next(ListIterator it);
bool atEnd(ListIterator it);
void disposeIterator(ListIterator it);
void destroyL(LinkedList xs);
    