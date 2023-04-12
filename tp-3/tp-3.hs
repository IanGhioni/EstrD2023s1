--1
data Color = Azul | Rojo
    deriving Show
data Celda = Bolita Color Celda | CeldaVacia
    deriving Show

--1.1
nroBolitas :: Color -> Celda -> Int
nroBolitas c1 CeldaVacia        = 0
nroBolitas c1 (Bolita c2 celda) = (unoSiCeroSiNo (sonElMismoColor c1 c2)) + (nroBolitas c1 celda)

unoSiCeroSiNo :: Bool -> Int
unoSiCeroSiNo bool = if (bool)
		      then 1
		      else 0 

sonElMismoColor :: Color -> Color -> Bool
sonElMismoColor Azul Azul = True
sonElMismoColor Rojo Rojo = True
sonElMismoColor _ _       = False

celdaCon2bolitasRojas = Bolita Rojo (Bolita Rojo CeldaVacia)

celdaCon2bolitasRojasY5Azules = Bolita Rojo (
                                    Bolita Rojo (
                                        Bolita Azul(
                                            Bolita Azul (
                                                Bolita Azul(
                                                    Bolita Azul(
                                                        Bolita Azul CeldaVacia
                                                        )
                                                    )
                                                )
                                        )
                                    )
                                )

poner :: Color -> Celda -> Celda
poner c1 celda = Bolita c1 celda

sacar :: Color -> Celda -> Celda
sacar c1 CeldaVacia        = CeldaVacia 
sacar c1 (Bolita c2 celda) = if (sonElMismoColor c1 c2)
                              then celda
                              else (Bolita c2 (sacar c1 celda))

ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 _  celda = celda
ponerN n c1 celda = ponerN (n-1) c1 (Bolita c1 celda)


-- 1.2
data Objeto = Cacharro | Tesoro
    deriving Show
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino
    deriving Show

conTesoro = [Cacharro,Tesoro,Tesoro]
sinTesoro = [Cacharro]

caminoConTesoro = (Nada (Cofre [Cacharro,Tesoro,Tesoro] (Nada Fin)))
caminoSinTesoro = (Nada (Cofre sinTesoro (Nada Fin)))

hayTesoro :: Camino -> Bool
--Indica si hay un cofre con un tesoro en el camino.
hayTesoro   Fin          = False  
hayTesoro (Nada c)       = hayTesoro c
hayTesoro (Cofre objs c) = (tieneUnTesoro objs) || hayTesoro c 

tieneUnTesoro :: [Objeto] -> Bool
tieneUnTesoro []         = False
tieneUnTesoro (obj:objs) = esUnTesoro obj || tieneUnTesoro objs

esUnTesoro :: Objeto -> Bool
esUnTesoro Tesoro = True
esUnTesoro _      = False

pasosHastaTesoro :: Camino -> Int
--Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
--Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
--Precondición: tiene que haber al menos un tesoro.
pasosHastaTesoro Fin            = error "Mensaje de error"
pasosHastaTesoro (Nada c)       = 1 + (pasosHastaTesoro c)
pasosHastaTesoro (Cofre objs c) = if (tieneUnTesoro objs)
                                   then 0
                                   else 1 + (pasosHastaTesoro c) 

hayTesoroEn :: Int -> Camino -> Bool
--Indica si hay un tesoro en una cierta cantidad exacta de pasos. Por ejemplo, si el número de
--pasos es 5, indica si hay un tesoro en 5 pasos.
hayTesoroEn 0 (Cofre objs c) = tieneUnTesoro objs
hayTesoroEn 0 _              = False
hayTesoroEn n Fin            = False 
hayTesoroEn n (Nada c)       = hayTesoroEn (n-1) c
hayTesoroEn n (Cofre _ c)    = hayTesoroEn (n-1) c


pasosHastaFin :: Camino -> Int
pasosHastaFin Fin         = 0
pasosHastaFin (Nada c)    = 1 + (pasosHastaFin c)
pasosHastaFin (Cofre _ c) = 1 + (pasosHastaFin c)

alMenosNTesoros :: Int -> Camino -> Bool
--Indica si hay al menos “n” tesoros en el camino.
alMenosNTesoros _ Fin            = False
alMenosNTesoros n (Nada c)       = alMenosNTesoros n c
alMenosNTesoros n (Cofre objs c) = ((n - (cantidadDeTesoros objs)) <= 0) || alMenosNTesoros (n - (cantidadDeTesoros objs)) c


cantidadDeTesoros :: [Objeto] -> Int
cantidadDeTesoros []         = 0
cantidadDeTesoros (obj:objs) = (unoSiCeroSiNo (esUnTesoro obj)) + cantidadDeTesoros objs

--(desafío) 
cantTesorosEntre :: Int -> Int -> Camino -> Int
--Dado un rango de pasos, indica la cantidad de tesoros que hay en ese rango. Por ejemplo, si
--el rango es 3 y 5, indica la cantidad de tesoros que hay entre hacer 3 pasos y hacer 5. Están
--incluidos tanto 3 como 5 en el resultado.
cantTesorosEntre _ _ Fin              = 0
cantTesorosEntre n1 n2 (Nada c)       = if n1==0 
                                        then cantidadDeTesorosHasta (n2-1) c 
                                        else cantTesorosEntre (n1-1) (n2-1) c
cantTesorosEntre n1 n2 (Cofre objs c) = if n1==0 
                                        then cantidadDeTesorosHasta (n2) (Cofre objs c)
                                        else cantTesorosEntre (n1-1) (n2-1) c

cantidadDeTesorosHasta :: Int -> Camino -> Int
cantidadDeTesorosHasta _ Fin            = 0  
cantidadDeTesorosHasta n (Nada c)       = if (n == 0) 
                                          then 0
                                          else cantidadDeTesorosHasta (n-1) c
cantidadDeTesorosHasta n (Cofre objs c) = if (n == 0)
                                          then (cantidadDeTesoros objs)
                                          else (cantidadDeTesoros objs) + (cantidadDeTesorosHasta (n-1) c)






data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show

arbol :: Tree Int
arbol = NodeT 5 (NodeT 6 (NodeT 7 EmptyT EmptyT) EmptyT) (NodeT 10 EmptyT EmptyT)

sumarT :: Tree Int -> Int
sumarT EmptyT          = 0  
sumarT (NodeT n t1 t2) = n + (sumarT t1) + (sumarT t2)


sizeT :: Tree a -> Int
sizeT EmptyT          = 0
sizeT (NodeT a t1 t2) = 1 + (sizeT t1) + (sizeT t2)

mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT          = EmptyT
mapDobleT (NodeT n t1 t2) = (NodeT (n*2) (mapDobleT t1) (mapDobleT t2)) 

perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT a EmptyT          = False
perteneceT a (NodeT x t1 t2) = (a==x) || (perteneceT a t1) || (perteneceT a t2) 

aparicionesT:: Eq a => a -> Tree a -> Int
--Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son
--iguales a e. 
aparicionesT a EmptyT          = 0 
aparicionesT a (NodeT x t1 t2) = (unoSiCeroSiNo (a==x)) + (aparicionesT a t1) + (aparicionesT a t2) 


leaves :: Tree a -> [a]
--Dado un árbol devuelve los elementos que se encuentran en sus hojas.
leaves EmptyT                   = []
leaves (NodeT a EmptyT EmptyT)  = [a]
leaves (NodeT a t1 t2)          = (leaves t1) ++ (leaves t2)

heightT :: Tree a -> Int
--Dado un árbol devuelve su altura.
--Nota: la altura de un árbol (height en inglés), también llamada profundidad, es la cantidad
--de niveles del árbol1. La altura para EmptyT es 0, y para una hoja es 1.
heightT EmptyT                  = 0  
heightT (NodeT _ t1 t2)         = 1 + retornarMayor (heightT t1) (heightT t2)

retornarMayor :: Int -> Int -> Int
retornarMayor n1 n2 = if n1>n2
                       then n1
                       else n2

mirrorT :: Tree a -> Tree a
mirrorT EmptyT          =  EmptyT
mirrorT (NodeT a t1 t2) = (NodeT a (mirrorT t2) (mirrorT t1))

toList :: Tree a -> [a]
toList EmptyT           = []
toList (NodeT a t1 t2)  = (toList t1) ++ [a] ++ (toList t2)  

levelN :: Int -> Tree a -> [a]
levelN _          EmptyT = []
levelN 0 (NodeT a t1 t2) = [a]
levelN n (NodeT a t1 t2) = (levelN (n-1) t1) ++ (levelN (n-1) t2)


listPerLevel :: Tree a -> [[a]]
--Dado un árbol devuelve una lista de listas en la que cada elemento representa un nivel de dicho árbol.
listPerLevel EmptyT          = []
listPerLevel (NodeT a t1 t2) = [a] : funAux (listPerLevel t1) (listPerLevel t2)

funAux :: [[a]] -> [[a]] -> [[a]]
funAux [] ls         = ls
funAux xs []         = xs
funAux (x:xs) (l:ls) = (x ++ l) : funAux xs ls


aplanar :: [[a]] -> [a]
aplanar []      = []
aplanar (x:xs)  = x ++ aplanar xs


ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT a t1 t2) = (a : ramaMasLarga (ramaMasLargaEntre t1 t2))

ramaMasLargaEntre :: Tree a -> Tree a -> Tree a
ramaMasLargaEntre t1 t2 = if ((heightT t1) > (heightT t2))
                          then t1
                          else t2


todosLosCaminos :: Tree a -> [[a]]
--Dado un árbol devuelve todos los caminos, es decir, los caminos desde la raiz hasta las hojas.

todosLosCaminos EmptyT          = []
todosLosCaminos (NodeT a EmptyT EmptyT) = [[a]]
todosLosCaminos (NodeT a t1 t2) = (agregarACadaLista a (todosLosCaminos t1)) ++ (agregarACadaLista a (todosLosCaminos t2))

agregarACadaLista :: a -> [[a]] -> [[a]]
agregarACadaLista a []     = []
agregarACadaLista a (l:ls) = [[a] ++ l] ++ agregarACadaLista a ls 


{-                         
                          7---E 
                         / \ 
  ______________________2   E
 /                       \ 
1          E              6--E  
|         /                \  
|       20                  8--E   
|      /  \                  \  
|     5    E                  35---E 
|    / \    E                  \  
|   /   \  /                    E   
 \ /     10
  3   E    \ 
   \ /      E
    4
     \
      E
-}

arbolTestCaminos = NodeT 1 (
                        NodeT 2 (
                            NodeT 7 EmptyT EmptyT) (
                            NodeT 6 (
                                NodeT 8 (
                                    NodeT 35 EmptyT EmptyT) EmptyT) 
                            EmptyT)) (
                        NodeT 3 (
                            NodeT 4 EmptyT EmptyT) (
                            NodeT 5 (
                                NodeT 20 EmptyT EmptyT) (
                                NodeT 10 EmptyT EmptyT)))
-- Resultado esperado tras usar todosLosCaminos = [[1,2,7],[1,2,6,8],[1,3,5,10],[1,3,5,20],[1,3,4]] en cualquier orden


data ExpA = Valor Int | Sum ExpA ExpA | Prod ExpA ExpA | Neg ExpA
    deriving Show

--Implementar las siguientes funciones utilizando el esquema de recursión estructural sobre Exp:
--1. 
eval :: ExpA -> Int
--Dada una expresión aritmética devuelve el resultado evaluarla.
eval (Valor n)    = n
eval (Sum n1 n2)  = (eval n1) + (eval n2)
eval (Prod n1 n2) = (eval n1) * (eval n2)
eval (Neg n)      = (eval n) * (-1)

expTestSimple = Sum (Prod (Neg (Valor 3)) (Neg (Valor 3))) (Valor 3)


--2. 
--Dada una expresión aritmética, la simplifica según los siguientes criterios (descritos utilizando
--notación matemática convencional):
--a) 0 + x = x + 0 = x
--b) 0 * x = x * 0 = 0
--c) 1 * x = x * 1 = x
--d) - (- x) = x
simplificar :: ExpA -> ExpA
simplificar (Neg (Neg n)) = (Valor (eval n))
simplificar (Sum n1 n2)   = simplificarSum (Sum n1 n2)
simplificar (Prod n1 n2)  = simplificarProd (Prod n1 n2)

simplificarSum :: ExpA -> ExpA
simplificarSum (Sum (Valor 0) n) = (Valor (eval n))
simplificarSum (Sum n (Valor 0)) = (Valor (eval n))
simplificarSum n                 = (Valor (eval n))

simplificarProd :: ExpA -> ExpA
simplificarProd (Prod _ (Valor 0)) = (Valor 0)
simplificarProd (Prod (Valor 0) _) = (Valor 0)
simplificarProd (Prod (Valor 1) n) = (Valor (eval n))
simplificarProd (Prod n (Valor 1)) = (Valor (eval n))
simplificarProd n                  = (Valor (eval n)) 

expTestASimplificar = Sum (Prod (Neg (Neg (Valor 3))) (Valor 1)) (Valor 0)