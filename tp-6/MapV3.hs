module MapV3 (Map, emptyM, assocM, lookupM, deleteM, keys)
where 

data Map a b = M [a] [b]
{-
INV Representacion 
    * [a] es la lista de claves y [b] es la lista de valores, donde la posicion de un elemento en [a] denota la posicion del valor que le corresponde en [b] 
-}

emptyM :: Map k v 
emptyM = M [] []

assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v (M ks vs) =  let (xs,ys) = funAuc x y xs ys in
                        (M xs ys) 

funAux :: Eq k => k -> v -> [k] -> [v] -> ([k],[v])
funAux  x y  []       _    =
funAux x y (x':xs) (y':ys) = let (xs',ys') = funAux x y xs ys in
                              if x == x'
                              then (xs,y:ys)
                              else (x':xs',y':ys')
                              


lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM k (M ks vs) = if pertenece k ks
                       then elementoDePosicion (posicionDe k ks) vs
                       else Nothing

elementoDePosicion :: Int -> [k] -> Maybe k
-- Parcial: El elemento debe existir
elementoDePosicion 0 (x:xs) = Just x    
elementoDePosicion n (x:xs) = elementoDePosicion (n-1) xs
                              

posicionDe :: Eq k => k -> [k] -> Int
-- Parcial: El elemento debe existir
posicionDe k (x:xs) = if k == x
                      then 0
                      else 1 + posicionDe k xs  

pertenece :: Eq a => a -> [a] -> Bool
pertenece n [] = False
pertenece n (x:xs) = n == x || pertenece n xs

keys :: Map k v -> [k]
keys (M ks _) = ks

deleteM :: Eq k => k -> Map k v -> Map k v
deleteM k (M ks vs) = let indice = posicionDe k ks in
                      M (removerElementoDe (indice) ks) (removerElementoDe (indice) vs)


removerElementoDe :: Int -> [a] -> [a]
removerElementoDe n []     = []
removerElementoDe 0 (x:xs) = xs
removerElementoDe n (x:xs) = x : removerElementoDe (n-1) xs 
