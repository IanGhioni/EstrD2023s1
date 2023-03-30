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

conTesoro = [Cacharro,Tesoro]
sinTesoro = [Cacharro]

caminoConTesoro = (Nada (Cofre conTesoro (Nada Fin)))
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

--pasosHastaTesoro :: Camino -> Int
--Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
--Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
--Precondición: tiene que haber al menos un tesoro.

--hayTesoroEn :: Int -> Camino -> Bool
--Indica si hay un tesoro en una cierta cantidad exacta de pasos. Por ejemplo, si el número de
--pasos es 5, indica si hay un tesoro en 5 pasos.

--alMenosNTesoros :: Int -> Camino -> Bool
--Indica si hay al menos “n” tesoros en el camino.


--(desafío) 
--cantTesorosEntre :: Int -> Int -> Camino -> Int
--Dado un rango de pasos, indica la cantidad de tesoros que hay en ese rango. Por ejemplo, si
--el rango es 3 y 5, indica la cantidad de tesoros que hay entre hacer 3 pasos y hacer 5. Están
--incluidos tanto 3 como 5 en el resultado.