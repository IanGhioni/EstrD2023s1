module QueueV3 (Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue) where
    
data Queue a = Q [a] [a]
{-  INV Representacion:
              (Q fs bs)
              * Se añaden elementos a traves de bs
              * Se quitan elementos a traves de fs
              * Si no hay elementos en fs, la cola se encuentra vacia

-}
emptyQ :: Queue a
-- Crea una cola vacía.
isEmptyQ :: Queue a -> Bool
-- Dada una cola indica si la cola está vacía.
enqueue :: a -> Queue a -> Queue a
-- Dados un elemento y una cola, agrega ese elemento a la cola.
firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento


emptyQ = Q [] [] -- O(1)

isEmptyQ (Q xs _) = null xs -- O(1)

enqueue a (Q fs bs) = if null fs -- O(1)
                      then Q (a:fs) bs
                      else Q fs (a:bs)

dequeue (Q fs bs) = let tuplaDeFsYBs = dequeueFsBs fs bs in -- O(n) por la funcion dequeueFsBs fs bs
                    Q (fst tuplaDeFsYBs) (snd tuplaDeFsYBs) 
                    
dequeueFsBs :: [a] -> [a] -> ([a],[a]) -- O(n) si la lista xs solo tiene un elemento. Si esta vacia o tiene mas de un elemento, es O(1) 
            -- xs      ys
dequeueFsBs [] []     = ([],[])
dequeueFsBs (x:xs) bs = if null xs
                        then (reverse bs,[])
                        else (xs,bs)

firstQ (Q fs bs) = if null fs -- O(1)
                   then error "Cola Vacia."
                   else head fs 