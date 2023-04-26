--import Set
import SetV2
import Queue
-- import QueueV2
import Stack

-- Especificar el costo operacional de las siguientes funciones:

head' :: [a] -> a
head' (x:xs) = x
-- Constante

sumar :: Int -> Int
sumar x = x + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1
-- Constante

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)
-- Lineal

longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs
-- Lineal

factoriales :: [Int] -> [Int]
factoriales [] = []
factoriales (x:xs) = factorial x : factoriales xs
-- Cuadratica

pertenece :: Eq a => a -> [a] -> Bool
pertenece n [] = False
pertenece n (x:xs) = n == x || pertenece n xs
-- Lineal

--sinRepetidos :: Eq a => [a] -> [a]
--sinRepetidos [] = []
--sinRepetidos (x:xs) = if pertenece x xs
--                      then sinRepetidos xs
--                      else x : sinRepetidos xs
-- Lineal


-- equivalente a (++)
append :: [a] -> [a] -> [a]
append [] ys = ys
append (x:xs) ys = x : append xs ys
-- Lineal

concatenar :: [String] -> String
concatenar [] = []
concatenar (x:xs) = x ++ concatenar xs
-- Lineal

takeN :: Int -> [a] -> [a]
takeN 0 xs = []
takeN n [] = []
takeN n (x:xs) = x : takeN (n-1) xs
-- Lineal

dropN :: Int -> [a] -> [a]
dropN 0 xs = xs
dropN n [] = []
dropN n (x:xs) = dropN (n-1) xs
-- Lineal

partir :: Int -> [a] -> ([a], [a])
partir n xs = (takeN n xs, dropN n xs)
-- Cuadratica

minimo :: Ord a => [a] -> a
minimo [x] = x
minimo (x:xs) = min x (minimo xs)
-- Lineal 

sacar :: Eq a => a -> [a] -> [a]
sacar n [] = []
sacar n (x:xs) = if n == x
                 then xs
                 else x : sacar n xs
-- lineal


ordenar :: Ord a => [a] -> [a]
ordenar [] = []
orderar xs = let m = minimo xs
              in m : ordenar (sacar m xs)
-- Cuadratica


data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show


losQuePertenecen :: Eq a => [a] -> Set a -> [a]
--Dados una lista y un conjunto, devuelve una lista con to doslos elementos que pertenecen al conjunto.
losQuePertenecen [] _     = []
losQuePertenecen (x:xs) s = if belongs x s
                            then (x : losQuePertenecen xs s)
                            else losQuePertenecen xs s

sinRepetidos :: Eq a => [a] -> [a]
--Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
sinRepetidos ls = setToList (addList ls emptyS)


addList :: Eq a => [a] -> Set a -> Set a
addList [] s     = s
addList (x:xs) s = addList xs (addS x s)

unirTodos :: Eq a => Tree (Set a) -> Set a
--Dado un arbol de conjuntos devuelve un conjunto con la union de todos los conjuntos del arbol.
unirTodos EmptyT        = emptyS
unirTodos (NodeT s ri rd) = unionS s (unionS (unirTodos ri) (unirTodos rd))



treeTest = NodeT (addList [1,2,3,4,5] emptyS)
                (NodeT (addList [1,5,7,9] emptyS) 
                    EmptyT 
                    (NodeT(addList [59,50] emptyS) 
                        EmptyT 
                        EmptyT))
                (NodeT (addList [1,9,10,50] emptyS) 
                    EmptyT 
                    EmptyT)





lengthQ :: Queue a -> Int
-- Cuenta la cantidad de elementos de la cola.
lengthQ q = if isEmptyQ q
            then 0
            else 1 + lengthQ (dequeue q) 

queueToList :: Queue a -> [a]
-- Dada una cola devuelve la lista con los mismos elementos, donde el orden de la lista es el de la cola.
-- Nota : chequear que los elementos queden en el orden correcto.
queueToList q = if isEmptyQ q
                then []
                else firstQ q : queueToList (dequeue q)

unionQ :: Queue a -> Queue a -> Queue a
-- Inserta todos los elementos de la segunda cola en la primera.
unionQ q1 q2 = addListToQ (queueToList q2) q1

addListToQ :: [a] -> Queue a -> Queue a
addListToQ [] q     = q
addListToQ (x:xs) q = addListToQ xs (enqueue x q)



apilar :: [a] -> Stack a
apilar ls = apilarEnStack ls emptySt

apilarEnStack :: [a] -> Stack a -> Stack a
apilarEnStack [] st     = st
apilarEnStack (x:xs) st = apilarEnStack xs (push x st)


desapilar :: Stack a -> [a]
desapilar st = let topeDePila = top st in
            if isEmptySt st
            then []
            else (desapilar (pop st)) ++ [topeDePila]

insertarEnPos :: Int -> a -> Stack a -> Stack a
insertarEnPos n a st = let tuplaAux = (separarListaAPartirDePos n (desapilar st))
                    in apilar ((fst tuplaAux) ++ [a] ++ (snd tuplaAux))

separarListaAPartirDePos :: Int -> [a] -> ([a],[a])
separarListaAPartirDePos 0 ls     = ([], ls) 
separarListaAPartirDePos _ []     = error "No existe la posicion dada en la lista dada"
separarListaAPartirDePos n (x:xs) = juntarTuplasDeListas ([x],[]) (separarListaAPartirDePos (n-1) xs)  

juntarTuplasDeListas :: ([a],[b]) -> ([a],[b]) -> ([a],[b])
juntarTuplasDeListas tp1 tp2 = ((fst tp1) ++ (fst tp2), (snd tp1) ++ (snd tp2))
