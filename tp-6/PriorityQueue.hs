module PriorityQueue (PriorityQueue, emptyPQ, isEmptyPQ, insertPQ, findMinPQ, deleteMinPQ) where


data PriorityQueue a = PQ [a]

emptyPQ :: PriorityQueue a -- O(1)
emptyPQ = PQ []

isEmptyPQ :: PriorityQueue a -> Bool -- O(1)
isEmptyPQ (PQ xs) = null xs

insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a -- O(n)
insertPQ a (PQ xs) = PQ (addToOrdList a xs)

addToOrdList :: Ord a => a -> [a] -> [a] -- O(n)
addToOrdList a []     = [a]
addToOrdList a (x:xs) = if a < x
                        then a:x:xs
                        else x: addToOrdList a xs

findMinPQ :: Ord a => PriorityQueue a -> a -- O(1)
findMinPQ (PQ xs) = if null xs
                    then error "La PriorityQueue esta vacia"
                    else head xs 

deleteMinPQ :: Ord a => PriorityQueue a -> PriorityQueue a -- O(1)
deleteMinPQ (PQ xs) = if null xs
                      then error "La PriorityQueue esta vacia"
                      else PQ (tail xs)  
