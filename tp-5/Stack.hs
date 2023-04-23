module Stack (Stack, emptySt, isEmptySt, push, top, pop, lenS)
where

data Stack a = ConST [(a,Int)] Int

emptySt :: Stack a
emptySt = ConST [] 0

isEmptySt :: Stack a -> Bool
isEmptySt (ConST _ n) = n == 0

push :: a -> Stack a -> Stack a
push a (ConST ls n) = ConST ((a,n):ls) (n+1)

top :: Stack a -> a
top (ConST ls _) = fst (head ls)

pop :: Stack a -> Stack a
pop (ConST ls n) = ConST (tail ls) (n-1)

lenS :: Stack a -> Int
lenS (ConST _ n) = n