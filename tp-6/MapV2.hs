module MapV2 (Map, emptyM, assocM, lookupM, deleteM, keys)
where 

data Map a b = M [(a,b)]
{- INV. REPRESENTACION
    * b representa un valor asociado a una clave
    * a representa una clave no unica (Pueden haber multiples valores por clave)
-}

emptyM :: Map k v 
emptyM = M []

assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v (M ls) = M ((k,v):ls)

lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM k (M ls) = lookupK k ls

lookupK :: Eq a => a -> [(a,b)] -> Maybe b
lookupK k []     = Nothing
lookupK k (x:xs) = if fst x == k
                   then Just (snd x)
                   else lookupK k xs

deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
deleteM k (M ls) = M (deleteAssoc k ls)

deleteAssoc :: Eq k => k -> [(k,v)] -> [(k,v)]
deleteAssoc k []     = []
deleteAssoc k (x:xs) = if fst x == k
                       then deleteAssoc k xs
                       else x: deleteAssoc k xs

keys :: Eq k => Map k v -> [k]
-- Propósito: devuelve las claves del map.
keys (M ls) = sinRepetidos (fstList ls)

fstList :: [(a,b)] -> [a]
fstList []     = []
fstList (x:xs) = fst x: fstList xs

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = if pertenece x xs
                      then sinRepetidos xs
                      else x : sinRepetidos xs

pertenece :: Eq a => a -> [a] -> Bool
pertenece n [] = False
pertenece n (x:xs) = n == x || pertenece n xs

