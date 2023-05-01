import PriorityQueue
import MapV2

heapSort :: Ord a => [a] -> [a]
heapSort xs = returnListOfPQ (addListToPQ xs emptyPQ)


addListToPQ :: Ord a => [a] -> PriorityQueue a -> PriorityQueue a
addListToPQ [] pq     = pq
addListToPQ (x:xs) pq = addListToPQ xs (insertPQ x pq)

returnListOfPQ :: Ord a => PriorityQueue a -> [a]
returnListOfPQ pq =  if isEmptyPQ pq
                     then []
                     else findMinPQ pq: returnListOfPQ (deleteMinPQ pq) 


valuesM :: Eq k => Map k v -> [Maybe v]
-- Propósito: obtiene los valores asociados a cada clave del map.
valuesM map = valuesMap (keys map) map


valuesMap :: Eq k => [k] -> Map k v -> [Maybe v]
valuesMap [] m     = []
valuesMap (k:ks) m = (lookupM k m): valuesMap ks m 

todasAsociadas :: Eq k => [k] -> Map k v -> Bool
--Propósito: indica si en el map se encuentran to das las claves dadas.
todasAsociadas ks map = perteneceCadaElemento ks (keys map)

perteneceCadaElemento :: Eq a => [a] -> [a] -> Bool
perteneceCadaElemento [] _      = True    
perteneceCadaElemento (x:xs) ys = elem x ys && perteneceCadaElemento xs ys

listToMap :: Eq k => [(k, v)] -> Map k v
--Propósito: convierte una lista de pares clave valor en un map.
listToMap []           = emptyM
listToMap ((k,v):ksvs) = assocM k v (listToMap ksvs) 


mapToList :: Eq k => Map k v -> [(k, Maybe v)]
--Propósito: convierte un map en una lista de pares clave valor.
mapToList m = mapToList' (keys m) m

mapToList' :: Eq k => [k] -> Map k v -> [(k, Maybe v)]
mapToList' [] m     = []
mapToList' (x:xs) m = (x, (lookupM x m)) : (mapToList' xs (deleteM x m))


agruparEq :: Eq k => [(k, v)] -> Map k [v]
--Propósito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
--la misma clave.
agruparEq ls = asociarCadaTupla (clavesYValoresAgrupados ls) emptyM



clavesYValoresAgrupados :: Eq k => [(k, v)] -> [(k, [v])]
clavesYValoresAgrupados []     = []
clavesYValoresAgrupados (t:ts) = (fst t,(valoresDe t ts)) : clavesYValoresAgrupados (eliminarTuplasConClave (fst t) ts)

valoresDe :: Eq k => (k, v) -> [(k, v)] -> [v]
valoresDe t []     = [snd t]
valoresDe t (x:xs) = if fst t == fst x
                     then snd x:valoresDe t xs 
                     else valoresDe t xs       



eliminarTuplasConClave :: Eq k => k -> [(k, v)] -> [(k, v)]
eliminarTuplasConClave k []     = []
eliminarTuplasConClave k (x:xs) = if k == fst x
                                  then eliminarTuplasConClave k xs
                                  else x: eliminarTuplasConClave k xs  



incrementar :: Eq k => [k] -> Map k Int -> Map k Int
--Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
--cada número asociado con dichas claves.
incrementar  [] m    = m
incrementar (k:ks) m = let valorDeK = lookupM k m in 
                      if isNothing (valorDeK) 
                       then incrementar ks m
                       else assocM k (justElem (valorDeK) + 1) (incrementar ks (deleteM k m))

isNothing :: Maybe c -> Bool
isNothing Nothing = True
isNothing _       = False

justElem :: Maybe a -> a
justElem (Just a)  = a
justElem _          = error "Esta funcion solo sirve si el constructor del parametro es Just"

mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
--Propósito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
--una clave del primero existe en el segundo, es reemplazada por la del primero.
mergeMaps m1 m2 = asociarCadaTupla (tuplasDelMap m1) m2

asociarCadaTupla :: Eq k => [(k,v)] -> Map k v -> Map k v
asociarCadaTupla [] m     = m
asociarCadaTupla (x:xs) m = --asociarCadaTupla xs (assocM (fst x) (snd x) (deleteM (fst x) m)) --asociarCadaTupla xs (assocM (fst x) (snd x) m)
                            if isNothing (lookupM (fst x) m)
                            then asociarCadaTupla xs (assocM (fst x) (snd x) m)
                            else asociarCadaTupla xs (assocM (fst x) (snd x) (deleteM (fst x) m))

tuplasDelMap :: Eq k => Map k v -> [(k,v)]
tuplasDelMap m = tuplasDeClaveYValor (keys m) m

tuplasDeClaveYValor :: Eq k => [k] -> Map k v -> [(k,v)]
tuplasDeClaveYValor [] m     = []
tuplasDeClaveYValor (x:xs) m = let valorDeK = lookupM x m in 
                                if isNothing (valorDeK)
                                then tuplasDeClaveYValor xs m--(deleteM x m)
                                else (x,justElem valorDeK) : tuplasDeClaveYValor xs m--(deleteM x m)



mapTest :: Map [Char]  Int
mapTest = assocM "p" 5 (assocM "j" 4 (assocM "3" 1 (emptyM))) 

mapTest2 :: Map [Char]  Int
mapTest2 = assocM "Z" 70 (assocM "E" 84 (assocM "3" 19 (emptyM)))

