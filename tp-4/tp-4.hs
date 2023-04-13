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


todosLosCaminos :: Mapa -> [[Dir]]
--Devuelve todos lo caminos en el mapa.
todosLosCaminos (Fin _)               = [[]]
todosLosCaminos (Bifurcacion _ m1 m2) = [[Izq]] ++ [[Der]] ++ agregarACadaLista Izq (todosLosCaminos m1) ++ agregarACadaLista Der (todosLosCaminos m2)  


mapaTestTodosLosCaminos = Bifurcacion cofreVacio 
                            (Bifurcacion cofreVacio
                                (Bifurcacion cofreVacio 
                                    (Fin cofreVacio) 
                                    (Fin cofreVacio))
                                (Bifurcacion cofreVacio 
                                    (Fin cofreVacio) 
                                    (Fin cofreVacio)))
                             (Fin cofreVacio)


agregarACadaLista :: a -> [[a]] -> [[a]]
agregarACadaLista a []     = []
agregarACadaLista a (l:ls) = [[a] ++ l] ++ agregarACadaLista a ls

caminoDeLaRamaMasLarga :: Mapa -> [Dir]
--Indica el camino de la rama más larga.
caminoDeLaRamaMasLarga (Fin _)               = []
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








data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
    deriving Show

data Barril = Comida | Oxigeno | Torpedo | Combustible
    deriving Show

data Sector = S SectorId [Componente] [Tripulante]
    deriving Show

type SectorId = String

type Tripulante = String

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show

data Nave = N (Tree Sector)
    deriving Show


almacen = Almacen [Torpedo, Combustible, Oxigeno, Comida] 







-- Implementar las siguientes funciones utilizando recursión estructural:
sectores :: Nave -> [SectorId]
-- Propósito: Devuelve to dos los sectores de la nave.
sectores (N t) = idSectoresDe t

idSectoresDe :: Tree Sector -> [SectorId]
idSectoresDe EmptyT          = []
idSectoresDe (NodeT s ti td) = idSectorDe s : idSectoresDe ti ++ idSectoresDe td

idSectorDe :: Sector -> SectorId
idSectorDe (S id _ _) = id











poderDePropulsion :: Nave -> Int
-- Propósito: Devuelve la suma de poder de propulsión de to dos los motores de la nave. 
-- Nota: el poder de propulsión es el número que acompaña al constructor de motores.
poderDePropulsion (N t) = poderDePropulsionDeArbol t

poderDePropulsionDeArbol :: Tree Sector -> Int
poderDePropulsionDeArbol EmptyT          = 0  
poderDePropulsionDeArbol (NodeT s ti td) = poderDePropulsionDelSector s 
                                         + poderDePropulsionDeArbol ti
                                         + poderDePropulsionDeArbol td

poderDePropulsionDelSector :: Sector -> Int
poderDePropulsionDelSector (S _ cs _) = poderDePropulsionDeMotores cs

poderDePropulsionDeMotores :: [Componente] -> Int
poderDePropulsionDeMotores []     = 0  
poderDePropulsionDeMotores (c:cs) = propulsionDelMotor c + poderDePropulsionDeMotores cs

propulsionDelMotor :: Componente -> Int
propulsionDelMotor (Motor n) = n
propulsionDelMotor _         = 0









barriles :: Nave -> [Barril]
-- Propósito: Devuelve todos los barriles de la nave.
barriles (N t) = barrilesDelArbol t

barrilesDelArbol :: Tree Sector -> [Barril]
barrilesDelArbol EmptyT          = []
barrilesDelArbol (NodeT s ti td) = barrilesDelSector s ++ barrilesDelArbol ti ++ barrilesDelArbol td

barrilesDelSector :: Sector -> [Barril]
barrilesDelSector (S _ cs _) = filtrarBarrilesDe cs

filtrarBarrilesDe :: [Componente] -> [Barril]
filtrarBarrilesDe []     = []
filtrarBarrilesDe (c:cs) = barrilDe c ++ filtrarBarrilesDe cs

barrilDe :: Componente -> [Barril]
barrilDe (Almacen b) = b
barrilDe _           = []







agregarASector :: [Componente] -> SectorId -> Nave -> Nave
-- Propósito: Añade una lista de componentes a un sector de la nave.
-- Nota: ese sector puede no existir, en cuyo caso no añade componentes.
agregarASector cs id (N t) = N (agregarASectorDeArbol cs id t)

agregarASectorDeArbol :: [Componente] -> SectorId -> Tree Sector -> Tree Sector
agregarASectorDeArbol _ _ EmptyT = EmptyT
agregarASectorDeArbol cs id (NodeT s ti td) = if id == idSectorDe s
                                              then NodeT (agregarComponentes cs s) ti td
                                              else NodeT s (agregarASectorDeArbol cs id ti) (agregarASectorDeArbol cs id td)

agregarComponentes :: [Componente] -> Sector -> Sector
agregarComponentes cs1 (S i cs2 ts) = S i (cs2 ++ cs1) ts





asignarTripulanteA :: Tripulante -> [SectorId] -> Nave -> Nave
-- Propósito: Incorp ora un tripulante a una lista de sectores de la nave.
-- Precondición: Todos los id de la lista existen en la nave.
asignarTripulanteA t ids (N tr) = N (asignarTripulanteArbol t ids tr)

asignarTripulanteArbol :: Tripulante -> [SectorId] -> Tree Sector -> Tree Sector
asignarTripulanteArbol _ _ EmptyT            = EmptyT
asignarTripulanteArbol t ids (NodeT s ti td) = if  pertenece (idSectorDe s) ids
                                                    then NodeT (aniadirTripulanteA t s) 
                                                                    (asignarTripulanteArbol t ids ti )
                                                                    (asignarTripulanteArbol t ids td)
                                                    else NodeT s (asignarTripulanteArbol t ids ti) (asignarTripulanteArbol t ids td)

pertenece :: Eq a => a -> [a] -> Bool
pertenece e []      = False
pertenece e (x:xs)  = (e == x) || (pertenece e xs)

aniadirTripulanteA :: Tripulante -> Sector -> Sector
aniadirTripulanteA t (S id cs ts) = S id cs (t : ts) 

sectoresAsignados :: Tripulante -> Nave -> [SectorId]
-- Propósito: Devuelve los sectores en donde aparece un tripulante dado.
sectoresAsignados t (N tr) = sectoresAsignadosDeArbol t tr

sectoresAsignadosDeArbol :: Tripulante -> Tree Sector -> [SectorId]
sectoresAsignadosDeArbol t EmptyT          = []
sectoresAsignadosDeArbol t (NodeT s ti td) = if pertenece t (tripulantesDeSector s)
                                             then idSectorDe s : (sectoresAsignadosDeArbol t ti ++ sectoresAsignadosDeArbol t td)       
                                             else sectoresAsignadosDeArbol t ti ++ sectoresAsignadosDeArbol t td




tripulantes :: Nave -> [Tripulante]
-- Propósito: Devuelve la lista de tripulantes, sin elementos repetidos.
tripulantes (N t) = tripulantesDeArbol t

tripulantesDeArbol :: Tree Sector -> [Tripulante]
tripulantesDeArbol EmptyT          = []
tripulantesDeArbol (NodeT s ti td) = agregarSinRepetir (tripulantesDeSector s) (agregarSinRepetir (tripulantesDeArbol ti)  (tripulantesDeArbol td))

tripulantesDeSector :: Sector -> [Tripulante]
tripulantesDeSector (S _ _ ts) = ts

agregarSinRepetir :: Eq a => [a] -> [a] -> [a]
agregarSinRepetir []     ys = ys 
agregarSinRepetir (x:xs) ys = if pertenece x ys
                              then agregarSinRepetir xs ys
                              else x : agregarSinRepetir xs ys 




arbolSectores = (NodeT sector1 
                    (NodeT sector2 
                        (NodeT sector3 EmptyT EmptyT) 
                        (NodeT sector4 EmptyT EmptyT))
                    (NodeT sector5 
                        (NodeT sector6 EmptyT EmptyT) 
                        (NodeT sector7 EmptyT EmptyT)))

sector1 = (S "1" [Motor 10,almacen] ["Nacho"])
sector2 = (S "2" [] ["Nacho", "Nando"])
sector3 = (S "3" [Motor 100,almacen] ["Juli", "Mati"])
sector4 = (S "4" [Motor 50,LanzaTorpedos] ["Ian", "Nando"])
sector5 = (S "5" [Motor 10] ["Pepe", "Ian"])
sector6 = (S "6" [Motor 20] ["Pepe", "Nacho"])
sector7 = (S "7" [] ["Ian", "Lalo"])
