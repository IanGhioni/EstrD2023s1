import PriorityQueue

heapSort :: Ord a => [a] -> [a]
heapSort xs = returnListOfPQ (addListToPQ xs emptyPQ)


addListToPQ :: Ord a => [a] -> PriorityQueue a -> PriorityQueue a
addListToPQ [] pq     = pq
addListToPQ (x:xs) pq = addListToPQ xs (insertPQ x pq)

returnListOfPQ :: Ord a => PriorityQueue a -> [a]
returnListOfPQ pq =  if isEmptyPQ pq
                     then []
                     else findMinPQ pq: returnListOfPQ (deleteMinPQ pq) 