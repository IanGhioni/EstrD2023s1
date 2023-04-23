module Queue (Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue) where

data Queue a = ConsQ [a]

emptyQ :: Queue a
emptyQ = ConsQ []

isEmptyQ :: Queue a -> Bool
isEmptyQ (ConsQ ls) = null ls

enqueue :: a -> Queue a -> Queue a 
enqueue a (ConsQ ls) = ConsQ (ls ++ [a])

firstQ :: Queue a -> a
firstQ (ConsQ ls) = if null ls
                    then error "La cola esta vacia"
                    else head ls

dequeue :: Queue a -> Queue a
dequeue (ConsQ ls) = if null ls
                     then error "La cola esta vacia" 
                     else ConsQ (tail ls)    