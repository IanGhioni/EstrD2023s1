module QueueV2 (Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue) where

data Queue a = ConsQ [a]

emptyQ :: Queue a
emptyQ = ConsQ []

isEmptyQ :: Queue a -> Bool
isEmptyQ (ConsQ ls) = null ls

enqueue :: a -> Queue a -> Queue a 
enqueue a (ConsQ ls) = ConsQ (a:ls)

firstQ :: Queue a -> a
firstQ (ConsQ ls) = lastElementOf ls

dequeue :: Queue a -> Queue a
dequeue (ConsQ ls) = ConsQ (removeLastElementOf ls)

lastElementOf :: [a] -> a
lastElementOf []     = error "La cola esta vacia"
lastElementOf (x:xs) = if null xs
                       then x
                       else lastElementOf xs

removeLastElementOf :: [a] -> [a]
removeLastElementOf []     = error "La cola esta vacia"
removeLastElementOf (x:xs) = if null xs
                             then []
                             else x : removeLastElementOf xs   