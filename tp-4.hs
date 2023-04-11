data Pizza = Prepizza | Capa Ingrediente Pizza
    deriving Show

data Ingrediente = Salsa | Queso | Jamon | Aceitunas Int
    deriving Show

pizzaTest = Capa Jamon (Capa (Aceitunas 3) (Prepizza))

--Definir las siguientes funciones:
cantidadDeCapas :: Pizza -> Int
--Dada una pizza devuelve la cantidad de ingredientes
cantidadDeCapas Prepizza   = 0
cantidadDeCapas (Capa _ p) = 1 + cantidadDeCapas p

armarPizza :: [Ingrediente] -> Pizza
--Dada una lista de ingredientes construye una pizza
armarPizza []           = Prepizza
armarPizza (ing:ings)   = Capa ing (armarPizza ings)

--sacarJamon :: Pizza -> Pizza
--Le saca los ingredientes que sean jamón a la pizza
sacarJamon Prepizza   = Prepizza
sacarJamon (Capa i p) = if esJamon i
                        then sacarJamon p
                        else Capa i (sacarJamon p)

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _     = False


tieneSoloSalsaYQueso :: Pizza -> Bool
--Dice si una pizza tiene solamente salsa y queso (o sea, no tiene de otros ingredientes. En
--particular, la prepizza, al no tener ningún ingrediente, debería dar verdadero.
tieneSoloSalsaYQueso Prepizza     = True
tieneSoloSalsaYQueso (Capa ing p) = (esSalsa ing || esQueso ing) && tieneSoloSalsaYQueso p 

esSalsa :: Ingrediente -> Bool
esSalsa Salsa = True
esSalsa _     = False

esQueso :: Ingrediente -> Bool
esQueso Queso = True
esQueso _     = False

duplicarAceitunas :: Pizza -> Pizza
--Recorre cada ingrediente y si es aceitunas duplica su cantidad
duplicarAceitunas Prepizza     = Prepizza
duplicarAceitunas (Capa ing p) = if esAceituna ing
                                 then (Capa (aceitunasDuplicadas ing) (duplicarAceitunas p))
                                 else duplicarAceitunas p

esAceituna :: Ingrediente -> Bool
esAceituna (Aceitunas _) = True
esAceituna _           = False

aceitunasDuplicadas :: Ingrediente -> Ingrediente
aceitunasDuplicadas (Aceitunas x) = (Aceitunas (x*2))
aceitunasDuplicadas _             = error "Solo puede duplicar la cantidad del ingrediente aceitunas."

cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
--Dada una lista de pizzas devuelve un par donde la primera comp onente es la cantidad de
--ingredientes de la pizza, y la resp ectiva pizza como segunda componente
cantCapasPorPizza []     = []
cantCapasPorPizza (p:ps) = (cantidadDeCapas p, p): cantCapasPorPizza ps






data Dir = Izq | Der
    deriving Show

data Objeto = Tesoro | Chatarra
    deriving Show

data Cofre = Cofre [Objeto]
    deriving Show

data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa
    deriving Show


cofreConTesoro = Cofre [Tesoro]
cofreSinTesoro = Cofre [Chatarra]
cofreVacio     = Cofre []

mapaConTesoro = (Bifurcacion cofreVacio 
                    (Bifurcacion cofreVacio 
                        (Fin cofreConTesoro) 
                        (Fin cofreSinTesoro)) 
                    (Bifurcacion cofreVacio 
                        (Fin cofreSinTesoro) 
                        (Fin cofreSinTesoro)))



mapaSinTesoro = (Bifurcacion cofreVacio (Fin cofreVacio) (Fin cofreSinTesoro))

hayTesoro :: Mapa -> Bool
--Indica si hay un tesoro en alguna parte del mapa.
hayTesoro (Fin c)               = hayTesoroEnElCofre c
hayTesoro (Bifurcacion c m1 m2) = hayTesoroEnElCofre c || hayTesoro m1 || hayTesoro m2

hayTesoroEnElCofre :: Cofre -> Bool
-- Dado un cofre, devuelve true si dentro tiene un cofre
hayTesoroEnElCofre (Cofre objs) = tieneUnTesoro objs

tieneUnTesoro :: [Objeto] -> Bool
-- Dada una lista de objetos, devuelve true si contiene un tesoro
tieneUnTesoro []         = False
tieneUnTesoro (obj:objs) = esUnTesoro obj || tieneUnTesoro objs

esUnTesoro :: Objeto -> Bool
-- Dado un objeto, devuelve true si es un tesoro
esUnTesoro Tesoro = True
esUnTesoro _      = False

hayTesoroEn :: [Dir] -> Mapa -> Bool
--Indica si al final del camino hay un tesoro. Nota: el final de un camino se representa con una
--lista vacía de direcciones.
hayTesoroEn [] (Fin c)                   = hayTesoroEnElCofre c
hayTesoroEn [] (Bifurcacion c m1 m2)     = hayTesoroEnElCofre c
hayTesoroEn _ (Fin c)                    = False  
hayTesoroEn (d:ds) (Bifurcacion _ m1 m2) = hayTesoroEn ds (caminoQueSigue d m1 m2)

caminoQueSigue :: Dir -> Mapa -> Mapa -> Mapa
-- Dada una direccion y 2 mapas, retorna el primer mapa si la direccion es izq, retorna el segundo
-- mapa si la direccion es derecha
caminoQueSigue Izq m _ = m
caminoQueSigue Der _ m = m

caminoAlTesoro :: Mapa -> [Dir]
--Indica el camino al tesoro. Precondición: existe un tesoro y es único.
caminoAlTesoro (Fin c)               = []
caminoAlTesoro (Bifurcacion c m1 m2) = if hayTesoroEnElCofre c
                                        then []
                                        else dirDondeHayaTesoro m1 m2 : caminoAlTesoro (mapaDondeHayaTesoro m1 m2)

dirDondeHayaTesoro :: Mapa -> Mapa -> Dir
-- Dados dos mapas, devuelve la direccion del mapa que contenga un tesoro.
-- Precondición: existe un tesoro y solo un tesoro, no pueden ambos mapas tener tesoro.
dirDondeHayaTesoro m1 _ = if hayTesoro m1
                          then Izq
                          else Der

mapaDondeHayaTesoro :: Mapa -> Mapa -> Mapa
-- Dados 2 mapas, retorna el mapa que tenga el tesoro.
-- Precondicion: Existe un unico tesoro entre ambos mapas.
mapaDondeHayaTesoro m1 m2 = if hayTesoro m1
                            then m1
                            else m2



tesorosPorNivel :: Mapa -> [[Objeto]]
--Devuelve los tesoros separados por nivel en el árbol.
tesorosPorNivel (Fin c)               = [tesorosDelCofre c]
tesorosPorNivel (Bifurcacion c m1 m2) = [tesorosDelCofre c] ++ funAux (tesorosPorNivel m1) (tesorosPorNivel m2)

funAux :: [[a]] -> [[a]] -> [[a]]
funAux [] ls         = ls
funAux xs []         = xs
funAux (x:xs) (l:ls) = (x ++ l) : funAux xs ls


tesorosDelCofre :: Cofre -> [Objeto]
tesorosDelCofre (Cofre objs) =  if tieneUnTesoro objs
                                then filtrarTesoros objs
                                else []

filtrarTesoros :: [Objeto] -> [Objeto]
filtrarTesoros []         = []
filtrarTesoros (obj:objs) = singularSi obj (esUnTesoro obj)  ++  filtrarTesoros objs

singularSi :: a -> Bool -> [a]
singularSi a True  = [a]
singularSi a False = []

mapaConMuchosTesoro = (Bifurcacion cofreConTesoro 
                        (Bifurcacion cofreConTesoro 
                            (Fin cofreConTesoro) 
                            (Fin cofreConTesoro)) 
                        (Bifurcacion cofreConTesoro 
                            (Fin cofreConTesoro) 
                            (Fin cofreConTesoro)))


--todosLosCaminos :: Mapa -> [[Dir]]
--Devuelve todos lo caminos en el mapa.


caminoDeLaRamaMasLarga :: Mapa -> [Dir]
--Indica el camino de la rama más larga.
caminoDeLaRamaMasLarga (Fin c)               = []
caminoDeLaRamaMasLarga (Bifurcacion _ m1 m2) = direccionDeLaRamaMasLarga m1 m2 : caminoDeLaRamaMasLarga (mapaMasLargoEntre m1 m2)

mapaMasLargoEntre :: Mapa -> Mapa -> Mapa
mapaMasLargoEntre m1 m2 = if largoDelMapa m1 > largoDelMapa m2
                          then m1
                          else m2

direccionDeLaRamaMasLarga :: Mapa -> Mapa -> Dir
direccionDeLaRamaMasLarga m1 m2 = if largoDelMapa m1 > largoDelMapa m2
                                  then Izq
                                  else Der


largoDelMapa :: Mapa -> Int
largoDelMapa (Fin _)               = 0 
largoDelMapa (Bifurcacion _ m1 m2) = 1 + retornarMayor (largoDelMapa m1) (largoDelMapa m2)

retornarMayor :: Int -> Int -> Int
retornarMayor n1 n2 = if n1>n2
                       then n1
                       else n2