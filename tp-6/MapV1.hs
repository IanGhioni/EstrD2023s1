module MapV1 (Map, emptyM, assocM, lookupM, deleteM, keys)
where 

data Map a b = M [(a,b)]
{- INV. REPRESENTACION
    * b representa un valor asociado a una clave
    * a representa la clave de un unico valor (No hay claves repetidas)
-}

emptyM :: Map k v 
emptyM = M []

assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v (M ls) = if estaRepetidaLaClave k ls
                    then M ((k,v):(removerElemento k ls))
                    else M ((k,v):ls)

removerElemento :: Eq k => k -> [(k,v)] -> [(k,v)]
removerElemento k []     = []
removerElemento k (x:xs) = if fst x == k
                            then xs
                            else x: removerElemento k xs

estaRepetidaLaClave :: Eq a => a -> [(a,b)] -> Bool
estaRepetidaLaClave _ []     = False
estaRepetidaLaClave k (x:xs) = (k == fst x) || estaRepetidaLaClave k xs
                                


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
                       then xs
                       else x: deleteAssoc k xs 

keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map.
keys (M ls) = fstList ls

fstList :: [(a,b)] -> [a]
fstList []     = []
fstList (x:xs) = fst x: fstList xs