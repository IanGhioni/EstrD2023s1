module MultiSet (MultiSet, emptyMS, addMS, ocurrencesMS, unionMS, intersectionMS, multiSetToList)
where
import Map

data MultiSet a = MS (Map a Int)
{-
INV REPRESENTACION en MS (M a n) cumple que:
    * M es un mapa donde a es la clave del elemento n
    * n es la cantidad de apariciones del elemento a.
    * a es la clave del elemento n
    * Sepueden repetir los elementos
-}

emptyMS :: MultiSet a
emptyMS = MS (emptyM)

addMS :: Ord a => a -> MultiSet a -> MultiSet a
addMS a (MS m) = let nuevoValor = (ceroSiNothingValorSiJust (lookupM a m)) + 1 in 
                 MS (assocM a nuevoValor m)



ocurrenceMS :: Ord a => a -> MultiSet a -> Int
ocurrenceMS a (MS m) = ceroSiNothingValorSiJust (lookupM a m)


multiSetToList :: MultiSet a -> [(a,Int)]
multiSetToList (MS m) = mapToList m


unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a
unionMS (MS mp1) (MS mp2) = unionMaps mp1 mp2

unionMaps :: Map k Int -> Map k Int -> Map k Int
unionMaps mp1 mp2 =  Ms (tuplasToMap (sumarTuplasSiFstCoincide (mapToList mp1) (mapToList mp2)))

sumarTuplasSiFstCoincide :: [(k,Int)] -> [(k,Int)] -> [(k,Int)]
sumarTuplasSiFstCoincide   []     ys   = ys 
sumarTuplasSiFstCoincide (x:xs)   ys   = 
    
    
    
    
    --MS (listToMap (unionTuplas (mapToList mp1 ++ mapToList mp2)))

--unionTuplas :: Eq a => 



{-
unionM (MAP [(a,3),(c,2),(q,4)])  (MAP [(r,3),(c,4),(e,4)])
    = MAP [(a,3),(c,6),(q,4),(r,3),(e,4)]
-} 


--intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a








-------------------------------------------------------------------------
--- FUNCIONES AUXILIARES ------------------------------------------------
-------------------------------------------------------------------------

ceroSiNothingValorSiJust :: Maybe Int -> Int
ceroSiNothingValorSiJust Nothing   = 0
ceroSiNothingValorSiJust (Just v)  = v

mapToList :: Eq k => Map k v -> [(k, v)]
--Propósito: convierte un map en una lista de pares clave valor.
mapToList m = mapToList' (keys m) m

mapToList' :: Eq k => [k] -> Map k v -> [(k, v)]
mapToList' [] m     = []
mapToList' (x:xs) m = (x, justElem(lookupM x m)) : mapToList' xs (deleteM x m)

justElem :: Maybe a -> a
justElem (Just a)  = a
justElem _         = error "Esta funcion solo sirve si el constructor del parametro es Just"

