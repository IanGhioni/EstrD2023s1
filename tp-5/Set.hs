module Set (Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList) 
where



data Set a = ConS [a] Int

addS :: Eq a => a -> Set a -> Set a
addS x (ConS ls n) = if (belongsAux x ls) 
                     then (ConS ls n)
                     else ConS (x:ls) (n+1)

belongsAux :: Eq a => a -> [a] -> Bool
belongsAux n []     = False
belongsAux n (x:xs) = n == x || belongsAux n xs

emptyS :: Set a
emptyS = ConS [] 0

belongs :: Eq a => a -> Set a -> Bool
belongs a (ConS ls _) = belongsAux a ls  

sizeS :: Eq a => Set a -> Int
sizeS (ConS _ n) = n

removeS :: Eq a => a -> Set a -> Set a
removeS a (ConS ls n) = 
    if belongsAux a ls
    then (ConS (removeAux a ls) (n-1))
    else error "El elemento no existe en el set"

unionS :: Eq a => Set a -> Set a -> Set a
unionS (ConS ls1 _) (ConS ls2 _) = let nuevaLista = unionAux (ls1 ++ ls2)
                                in ConS nuevaLista (length nuevaLista)

setToList :: Eq a => Set a -> [a]
setToList (ConS ls _) = ls



removeAux :: Eq a => a -> [a] -> [a]
removeAux a (x:xs) = if x == a
                     then xs
                     else x : removeAux a xs 

unionAux :: Eq a => [a] -> [a]
unionAux [] = []
unionAux (x:xs) = if  belongsAux x xs
                  then unionAux xs
                  else x : unionAux xs
