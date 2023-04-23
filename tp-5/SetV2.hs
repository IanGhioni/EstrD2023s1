module SetV2 (Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList) 
where



data Set a = ConS [a] 

addS :: Eq a => a -> Set a -> Set a
addS x (ConS ls) = ConS (x:ls) 

belongsAux :: Eq a => a -> [a] -> Bool
belongsAux n []     = False
belongsAux n (x:xs) = n == x || belongsAux n xs

emptyS :: Set a
emptyS = ConS []

belongs :: Eq a => a -> Set a -> Bool
belongs a (ConS ls) = belongsAux a ls  

sizeS :: Eq a => Set a -> Int
sizeS (ConS ls) = length (sinRepetidos ls)

removeS :: Eq a => a -> Set a -> Set a
removeS a (ConS ls) = 
    if belongsAux a ls
    then removeS a (ConS (removeAux a ls))
    else (ConS ls)

unionS :: Eq a => Set a -> Set a -> Set a
unionS (ConS ls1) (ConS ls2) = let nuevaLista = ls1 ++ ls2
                                in ConS nuevaLista 

setToList :: Eq a => Set a -> [a]
setToList (ConS ls) = sinRepetidos ls



removeAux :: Eq a => a -> [a] -> [a]
removeAux a (x:xs) = if x == a
                     then xs
                     else x : removeAux a xs 

unionAux :: Eq a => [a] -> [a]
unionAux [] = []
unionAux (x:xs) = if  belongsAux x xs
                  then unionAux xs
                  else x : unionAux xs


sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = if pertenece x xs
                      then sinRepetidos xs
                      else x : sinRepetidos xs

pertenece :: Eq a => a -> [a] -> Bool
pertenece n [] = False
pertenece n (x:xs) = n == x || pertenece n xs