
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









type Presa = String -- nombre de presa

type Territorio = String -- nombre de territorio

type Nombre = String -- nombre de lobo

data Lobo = Cazador Nombre [Presa] Lobo Lobo Lobo | Explorador Nombre [Territorio] Lobo Lobo | Cria Nombre
    deriving Show
    
data Manada = M Lobo
    deriving Show




-- Construir un valor de tipo Manada que posea 1 cazador, 2 exploradores y que el resto sean
--crías. Resolver las siguientes funciones utilizando recursión estructural sobre la estructura
--que corresponda en cada caso:

cria1 = Cria "Cria 1"
cria2 = Cria "Cria 2"
cria3 = Cria "Cria 3"
cria4 = Cria "Cria 4"
cria5 = Cria "Cria 5"


explorador1 = Explorador "Explorador 1" ["Playa"] cria1 cria2
explorador2 = Explorador "Explorador 2" ["Lago"] cria3 cria4 

cazador1 = Cazador "Cazador 1" [] explorador1 explorador2 cria5 

manada = M cazador1

buenaCaza :: Manada -> Bool
--Propósito: dada una manada, indica si la cantidad de alimento cazado es mayor a la cantidad de crías.
buenaCaza (M l) = let nroDePresasYCrias = totalDePresasYCrias l
                  in fst  nroDePresasYCrias > snd nroDePresasYCrias

totalDePresasYCrias :: Lobo -> (Int,Int)
totalDePresasYCrias (Cria n)                = (0,1)
totalDePresasYCrias (Explorador n ts l1 l2) = let tuplaDePresasYCriasTotal = sumarTuplas (totalDePresasYCrias l1) (totalDePresasYCrias l2)
                                            in sumarTuplas (0,0) tuplaDePresasYCriasTotal       
totalDePresasYCrias (Cazador n ps l1 l2 l3) = let tuplaDePresasYCriasTotal = sumarTuplas (totalDePresasYCrias l1) (sumarTuplas (totalDePresasYCrias l2) (totalDePresasYCrias l3))
                                            in sumarTuplas (long ps,0) tuplaDePresasYCriasTotal

sumarTuplas :: (Int,Int) -> (Int,Int) -> (Int,Int)
sumarTuplas (x1,x2) (y1,y2) = (x1 + y1,x2 + y2)




elAlfa :: Manada -> (Nombre, Int)
--Propósito: dada una manada, devuelve el nombre del lobo con más presas cazadas, junto
--con su cantidad de presas. Nota: se considera que los exploradores y crías tienen cero presas
--cazadas, y que podrían formar parte del resultado si es que no existen cazadores con más de
--cero presas.
elAlfa (M l) = let loboAlfa = (elAlfaDeLobo l)
                in (nombreDe loboAlfa, cantPresas loboAlfa)

elAlfaDeLobo :: Lobo -> Lobo
elAlfaDeLobo (Cria n)                = Cria n
elAlfaDeLobo (Explorador n ts l1 l2) = elQueMasCazo [(Explorador n ts l1 l2), elAlfaDeLobo l1 , elAlfaDeLobo l2]  
elAlfaDeLobo (Cazador n ps l1 l2 l3) = elQueMasCazo [(Cazador n ps l1 l2 l3), elAlfaDeLobo l1 , elAlfaDeLobo l2, elAlfaDeLobo l3]

elQueMasCazo :: [Lobo] -> Lobo
elQueMasCazo []     = error "Tiene que haber lobos"
elQueMasCazo [l]    = l 
elQueMasCazo (l:ls) =   let loboQueMasCazo = elQueMasCazo ls
                        in if cazoMas l loboQueMasCazo
                        then l
                        else loboQueMasCazo

cazoMas :: Lobo -> Lobo -> Bool
cazoMas (Cazador _ ps1 _ _ _) (Cazador _ ps2 _ _ _) = long ps1 > long ps2
cazoMas l1 _                                        = esCazador l1 

nombreDe :: Lobo -> Nombre
nombreDe (Cria n)             = n
nombreDe (Explorador n _ _ _) = n
nombreDe (Cazador n _ _ _ _)  = n

cantPresas :: Lobo -> Int
cantPresas (Cazador _ ps _ _ _) = long ps
cantPresas _                    = 0

esCazador :: Lobo -> Bool
esCazador (Cazador _ _ _ _ _) = True
esCazador _                   = False


long :: [a] -> Int
long []     = 0
long (x:xs) = 1 + long xs




losQueExploraron :: Territorio -> Manada -> [Nombre]
--Propósito: dado un territorio y una manada, devuelve los nombres de los exploradores que
--pasaron por dicho territorio.
losQueExploraron t (M l) = nombresDeQuienesExploraron t l



nombresDeQuienesExploraron :: Territorio -> Lobo -> [Nombre]
nombresDeQuienesExploraron t (Cria n)                = [] 
nombresDeQuienesExploraron t (Explorador n ts l1 l2) = let nombresDeExploradores = nombresDeQuienesExploraron t l1 ++ nombresDeQuienesExploraron t l2 in
                                                       if pertenece t ts 
                                                       then (n:nombresDeExploradores)
                                                       else  nombresDeExploradores
nombresDeQuienesExploraron t (Cazador _ _ l1 l2 l3) = nombresDeQuienesExploraron t l1 ++ nombresDeQuienesExploraron t l2 ++ nombresDeQuienesExploraron t l3





























exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
--Propósito: dada una manada, denota la lista de los pares cuyo primer elemento es un terri-
--torio y cuyo segundo elemento es la lista de los nombres de los exploradores que exploraron
--dicho territorio. Los territorios no deben repetirse.
exploradoresPorTerritorio (M l) = territorioYNombresDeExploradores l



territorioYNombresDeExploradores :: Lobo -> [(Territorio, [Nombre])]
-- Proposito: Dado un lobo, denota la lista de los pares cuyo primer elemento es un terri-
--torio y cuyo segundo elemento es la lista de los nombres de los exploradores que exploraron
--dicho territorio. Los territorios no deben repetirse.
territorioYNombresDeExploradores (Cria n)                = []
territorioYNombresDeExploradores (Explorador n ts l1 l2) = juntarTerritoriosRepetidos (hacerTuplasDeTerritorioYNombre n ts) ((territorioYNombresDeExploradores l1) ++ (territorioYNombresDeExploradores l2))
territorioYNombresDeExploradores (Cazador n ps l1 l2 l3) = juntarTerritoriosRepetidos (territorioYNombresDeExploradores l1) ((territorioYNombresDeExploradores l2) ++ (territorioYNombresDeExploradores l3))


juntarTerritoriosRepetidos :: [(Territorio, [Nombre])] -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
-- Proposito: dada 2 listas de pares cuyo primer elemento es un territorio y su segundo elemento la lista de 
-- nombres que lo recorrieron, denota una lista donde los pares de territorios repetidas se juntan en un mismo 
-- par, juntando la lista de nombres
-- PRECONDICION: No pueden haber pares con territorios repetidos en la primera lista dada  
juntarTerritoriosRepetidos [] tps                = tps
juntarTerritoriosRepetidos (tp1:tps1) tps2       = (juntarTuplaConRepetidos tp1 tps2) : tuplasSinTerritorio (fst tp1) (juntarTerritoriosRepetidos tps1 tps2)



tuplasSinTerritorio :: Territorio ->  [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
-- Dado un territorio y una lista de pares cuyo primer elemento es un territorio y su segundo elemento la lista de 
-- nombres que lo recorrieron, denota una lista sin los pares que tengan al territorio dado como primer elemento
tuplasSinTerritorio _ []       = []
tuplasSinTerritorio t (tp:tps) = if t == fst tp
                                 then tuplasSinTerritorio t tps
                                 else tp : tuplasSinTerritorio t tps

juntarTuplaConRepetidos :: (Territorio, [Nombre]) -> [(Territorio, [Nombre])] -> (Territorio, [Nombre])
-- Proposito: Dado un par y una lista de pares cuyo primer elemento es un territorio y su segundo elemento la lista de 
-- nombres que lo recorrieron, devuelve un par con el mismo territorio de la tupla dado y la lista de nombres del par dado 
-- junto con los demas nombres de la lista de tuplas dada que tengan el mismo territorio.
juntarTuplaConRepetidos tp []           = tp 
juntarTuplaConRepetidos (t,ns) (tp:tps) = if t == fst tp
                                          then juntarTuplaConRepetidos (t,ns ++ snd tp) tps
                                          else juntarTuplaConRepetidos (t,ns) tps


hacerTuplasDeTerritorioYNombre :: Nombre -> [Territorio] -> [(Territorio, [Nombre])]
-- Proposito: Dado un nombre y una lista de territorios, devuelve una lista de pares donde el primer elemento
-- es un territorio y el segundo es una lista con el nombre dado
hacerTuplasDeTerritorioYNombre n []     = []
hacerTuplasDeTerritorioYNombre n (t:ts) = (t,[n]) : hacerTuplasDeTerritorioYNombre n ts



























superioresDelCazador :: Nombre -> Manada -> [Nombre]
--Propósito: dado un nombre de cazador y una manada, indica el nombre de todos los
--cazadores que tienen como subordinado al cazador dado (directa o indirectamente).
--Precondición: hay un cazador con dicho nombre y es único.
superioresDelCazador n (M l) = nombreDeLosCazadores (todosLosSuperiores n l)

nombreDeLosCazadores :: [Lobo] -> [Nombre]
nombreDeLosCazadores []     = []
nombreDeLosCazadores (l:ls) = if esCazador l
                              then nombreDe l : nombreDeLosCazadores ls
                              else nombreDeLosCazadores ls  

todosLosSuperiores :: Nombre -> Lobo -> [Lobo]
todosLosSuperiores n1 (Cria n2)                = []
todosLosSuperiores n1 (Explorador n2 ts l1 l2) = let descDeHijes = todosLosSuperiores n1 l1 ++ todosLosSuperiores n1 l2
                                                 in if nombreDe l1 == n1 || nombreDe l2 == n1
                                                    then [Explorador n2 ts l1 l2]
                                                    else if noEstaVacia descDeHijes
                                                         then (Explorador n2 ts l1 l2):descDeHijes
                                                         else []
todosLosSuperiores n1 (Cazador n2 ps l1 l2 l3) = let descDeHijes = todosLosSuperiores n1 l1 ++ todosLosSuperiores n1 l2  ++ todosLosSuperiores n1 l3
                                                 in if nombreDe l1 == n1 || nombreDe l2 == n1 ||nombreDe l3 == n1
                                                    then [Cazador n2 ps l1 l2 l3]
                                                    else if noEstaVacia descDeHijes
                                                         then (Cazador n2 ps l1 l2 l3):descDeHijes
                                                         else []


noEstaVacia :: [a] -> Bool
noEstaVacia (x:xs) = True
noEstaVacia _      = False 



--let nombre = expression in
--    codigo










cria6 = Cria "Cria 6"
cria7 = Cria "Cria 7"
cria8 = Cria "Cria 8"
cria9 = Cria "Cria 9"
cria10 = Cria "Cria 10"

cazador1' = Cazador "Cazador 1'" ["P2"] cazador3 explorador1 cazador2
cazador2 = Cazador "Cazador 2" ["P1"] explorador2 cazador4 cria9 
cazador3 = Cazador "Cazador 3" muchasPresas cazador5 explorador3 cria8 
cazador4 = Cazador "Cazador 4" muchasPresas explorador5 cria1 cria6 
cazador5 = Cazador "Cazador 5" ["P3"] cria10 cazadorS cria7 
cazadorS = Cazador "Subordinado" muchasPresas cria10 cria9 cria6


explorador3 = Explorador "Ex3" ["Miami","Bosque","Playa"] cria10 explorador4
explorador4 = Explorador "Ex4" ["Miami"] cria5 cria3
explorador5 = Explorador "Ex5" ["Miami","Bosque"] cria4 cria5

-- 18 crias
muchasPresas = ["Px","Px","Px","Px","Px","Px","Px"]