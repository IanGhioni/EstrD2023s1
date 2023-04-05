--1.1
sumatoria :: [Int] -> Int
sumatoria []        = 0
sumatoria (x:xs)    = x + sumatoria xs

-- 2
longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

--3
sucesores :: [Int] -> [Int]
sucesores []     = []
sucesores (x:xs) = x+1:sucesores xs

--4
conjuncion :: [Bool] -> Bool
conjuncion []     = True  
conjuncion (x:xs) = x && conjuncion xs

--5
disyuncion :: [Bool] -> Bool
disyuncion []     = False
disyuncion (x:xs) = x || disyuncion xs

--6
aplanar :: [[a]] -> [a]
aplanar []      = []
aplanar (x:xs)  = x ++ aplanar xs

--7
pertenece :: Eq a => a -> [a] -> Bool
pertenece e []      = False
pertenece e (x:xs)  = (e == x) || (pertenece e xs)

--8
apariciones :: Eq a => a -> [a] -> Int
apariciones e []     = 0
apariciones e (x:xs) = unoSiCeroSiNo (e == x) + apariciones e xs

--9
losMenoresA :: Int -> [Int] -> [Int]
losMenoresA n []     = []
losMenoresA n (x:xs) = if (x<n)
                        then x:(losMenoresA n xs)
                        else losMenoresA n xs

--10
losDeLongitudMayorA :: Int -> [[a]] -> [[a]]
losDeLongitudMayorA n []     = []
losDeLongitudMayorA n (x:xs) = if (longitud x > n)
                                then (x:losDeLongitudMayorA n xs)
                                else (losDeLongitudMayorA n xs) 

--11
agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal [] n     = [n]
agregarAlFinal (x:xs) n = x:(agregarAlFinal xs n)

--12
agregar :: [a] -> [a] -> [a]
agregar [] l     = l
agregar (x:xs) l = [x] ++ agregar xs l

--13
reversa :: [a] -> [a]
reversa []      = []
reversa (x:xs)  = reversa xs ++ [x]

-- 14
zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] l     = l
zipMaximos l []     = l
zipMaximos (x:xs) (n:ns) = if (x > n) 
                            then (x:zipMaximos xs ns)
                            else (n:zipMaximos xs ns)

--15
elMinimo :: Ord a => [a] -> a
-- Dada una lista devuelve el mínimo
-- Precondicion: La lista dada no debe ser una lista vacia
elMinimo []     = error "La lista no puede estar vacia"
elMinimo (x:[]) = x
elMinimo (x:xs) = menorEntre x (elMinimo xs)

menorEntre :: Ord a => a -> a -> a
menorEntre a b = if a<b
                 then a
                 else b

{-
        ------- [2,4,1,3] ------
        2                       [4,1,3]
        |                          |
        2                          1 ---------> elMinimo [4,1,3] 
                if 2<1
                   then 2
                   else 1
-}
--2.1
factorial :: Int -> Int
factorial 0 = 1
factorial x = if x < 0 
               then error "El numero dado no puede ser negativo"
               else x * factorial (x - 1)

--2
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva x = if x < 1 
                    then []
                    else (x:cuentaRegresiva (x-1)) 

--3
repetir :: Int -> a -> [a]
repetir 0 _ = []
repetir n x = (x: repetir (n-1) x)

--4
losPrimeros :: Int -> [a] -> [a]
losPrimeros 0 _      = []
losPrimeros _ []     = []
losPrimeros n (x:xs) = (x:losPrimeros (n-1) xs)

--5
sinLosPrimeros :: Int -> [a] -> [a]
sinLosPrimeros 0 a      = a
sinLosPrimeros _ []     = []
sinLosPrimeros n (x:xs) = sinLosPrimeros (n-1) xs


--3.1
data Persona = ConsPersona String Int
        deriving Show

mayoresA :: Int -> [Persona] -> [Persona]
mayoresA n []     = []
mayoresA n (p:ps) = if (esMayorA n p)
                     then (p:mayoresA n ps)
                     else (mayoresA n ps)    

esMayorA :: Int -> Persona -> Bool
esMayorA n (ConsPersona _ edad) = n<edad

promedioEdad :: [Persona] -> Int
promedioEdad [] = error "La lista de personas no puede estar vacia."
promedioEdad ps = div (sumatoria (mapeoDeEdades ps)) (longitud ps)

mapeoDeEdades :: [Persona] -> [Int]
mapeoDeEdades []  = []
mapeoDeEdades ps  = (edadDe (head ps) : mapeoDeEdades (tail ps))

edadDe :: Persona -> Int 
edadDe (ConsPersona  _ e) = e


elMasViejo :: [Persona] -> Persona
elMasViejo []       = error "La lista de personas no puede estar vacia."
elMasViejo (p:[])   = p
elMasViejo (p : ps) = if esMasViejo p (elMasViejo ps)
                       then p
                       else elMasViejo ps

esMasViejo :: Persona -> Persona -> Bool 
esMasViejo  (ConsPersona _ e1) (ConsPersona _ e2) = e1 > e2 























data TipoDePokemon = Agua | Fuego | Planta
        deriving Show

data Pokemon = ConsPokemon TipoDePokemon Int
        deriving Show

data Entrenador = ConsEntrenador String [Pokemon]
        deriving Show

cantPokemon :: Entrenador -> Int
--Devuelve la cantidad de Pokémon que posee el entrenador. 
cantPokemon (ConsEntrenador _ pokemones) = longitud pokemones


cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
--Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantPokemonDe t e = cantPokemonDeTipo t (listaDePokemonsDe e)

listaDePokemonsDe :: Entrenador -> [Pokemon]
listaDePokemonsDe (ConsEntrenador _ ps) = ps

cantPokemonDeTipo :: TipoDePokemon -> [Pokemon] -> Int
cantPokemonDeTipo _ []     = 0
cantPokemonDeTipo t (p:ps) = unoSiCeroSiNo (sonDelMismoTipo t (tipoDelPokemon p)) + cantPokemonDeTipo t ps

unoSiCeroSiNo :: Bool -> Int
unoSiCeroSiNo bool = if (bool)
		      then 1
		      else 0

tipoDelPokemon :: Pokemon -> TipoDePokemon
tipoDelPokemon (ConsPokemon tipo _) = tipo

sonDelMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
sonDelMismoTipo  Fuego Fuego 	= True
sonDelMismoTipo Agua Agua	= True 
sonDelMismoTipo Planta Planta 	= True 
sonDelMismoTipo _ _ 	        = False

cuantosDeTipo_De_LeGananATodosLosDe_ :: TipoDePokemon -> Entrenador -> Entrenador -> Int
--Dados dos entrenadores, indica la cantidad de Pokemon de cierto tipo, que le ganarían a los Pokemon del segundo entrenador.
cuantosDeTipo_De_LeGananATodosLosDe_ tipo (ConsEntrenador _ listaDePokemons1) (ConsEntrenador _ listaDePokemons2) = cantidadDePokemonesQueLeGanan (pokemonsDeTipo tipo listaDePokemons1) listaDePokemons2

cantidadDePokemonesQueLeGanan :: [Pokemon] -> [Pokemon] -> Int
cantidadDePokemonesQueLeGanan [] _  = 0
cantidadDePokemonesQueLeGanan _ []  = 0
cantidadDePokemonesQueLeGanan (p1:ps1) lista = unoSiCeroSiNo (puedeDerrotarATodosLosPokemon p1 lista) + (cantidadDePokemonesQueLeGanan ps1 lista) 

puedeDerrotarATodosLosPokemon :: Pokemon -> [Pokemon] -> Bool
puedeDerrotarATodosLosPokemon p1 []      = True  
puedeDerrotarATodosLosPokemon p1 (p2:ps) = puedeDerrotarAlPokemon p1 p2 && (puedeDerrotarATodosLosPokemon p1 ps)

puedeDerrotarAlPokemon :: Pokemon -> Pokemon -> Bool
puedeDerrotarAlPokemon p1 p2 = tipoSuperaA (tipoDelPokemon p1) (tipoDelPokemon p2)

tipoSuperaA :: TipoDePokemon -> TipoDePokemon -> Bool
tipoSuperaA Agua Fuego 		= True
tipoSuperaA Fuego Planta 	= True
tipoSuperaA Planta Agua 	= True
tipoSuperaA _ _ 		= False

pokemonsDeTipo :: TipoDePokemon -> [Pokemon] -> [Pokemon]
pokemonsDeTipo tipo []     = []
pokemonsDeTipo tipo (p:ps) = if (sonDelMismoTipo tipo (tipoDelPokemon p))
                             then (p:pokemonsDeTipo tipo ps)
                             else pokemonsDeTipo tipo ps



--Agua supera a fuego, fuego a planta y planta a agua.

esMaestroPokemon :: Entrenador -> Bool
--Dado un entrenador, devuelve True si posee al menos un Pokémon de cada tipo posible.
esMaestroPokemon (ConsEntrenador _ listaDePokemons) = hayUnPokemonDe Fuego listaDePokemons && hayUnPokemonDe Planta listaDePokemons && hayUnPokemonDe Agua listaDePokemons

hayUnPokemonDe :: TipoDePokemon -> [Pokemon] -> Bool
hayUnPokemonDe t []     = False
hayUnPokemonDe t (p:ps) = (sonDelMismoTipo t (tipoDelPokemon p)) || (hayUnPokemonDe t ps)



























data Seniority = Junior | SemiSenior | Senior
        deriving (Show)

data Proyecto = ConsProyecto String
        deriving (Show)

data Rol = Developer Seniority Proyecto | Management Seniority Proyecto
        deriving (Show)

data Empresa = ConsEmpresa [Rol]
        deriving (Show)

proyectos :: Empresa -> [Proyecto]
--Dada una empresa denota la lista de proyectos en los que trabaja, sin elementos repetidos.
proyectos (ConsEmpresa rs) = eliminarProyectosRepetidos (mapeoDeProyectos rs)

eliminarProyectosRepetidos :: [Proyecto] -> [Proyecto]
eliminarProyectosRepetidos []     = []
eliminarProyectosRepetidos (p:ps) = if (estaRepetidoElProyecto p ps) 
                                     then eliminarProyectosRepetidos ps
                                     else p : eliminarProyectosRepetidos ps

{-
otra forma que se me ocurrio para no usar el if
(singularSi p ( negar (estaRepetidoElProyecto p ps)))  ++  eliminarProyectosRepetidos ps
-}

mapeoDeProyectos :: [Rol] -> [Proyecto]
mapeoDeProyectos []     = []
mapeoDeProyectos (r:rs) = (proyectoDe r : mapeoDeProyectos rs)

proyectoDe :: Rol -> Proyecto
proyectoDe (Developer _ p)  = p
proyectoDe (Management _ p) = p

estaRepetidoElProyecto :: Proyecto -> [Proyecto] -> Bool
estaRepetidoElProyecto _ [] = False
estaRepetidoElProyecto p1 l = sonElMismoProyecto p1 (head(l)) || estaRepetidoElProyecto p1 (tail(l))

sonElMismoProyecto :: Proyecto -> Proyecto -> Bool
sonElMismoProyecto p1 p2 = nombreDelProyecto p1 == nombreDelProyecto p2

nombreDelProyecto :: Proyecto -> String
nombreDelProyecto (ConsProyecto s) = s



--Escenario de testing
proyecto1 = ConsProyecto "Repetido"
proyecto2 = ConsProyecto "Unico"
proyecto3 = ConsProyecto "Diferente"
proyecto4 = ConsProyecto "Distinto"

rol1 = (Developer Senior proyecto1)

rol1' = (Management Junior proyecto1)

rol2 = (Developer Senior proyecto2)

rol3 = (Management Junior proyecto3)

rol4 = (Developer Senior proyecto4)

empresaTest = (ConsEmpresa [rol2,rol3,rol4,rol1,rol1',rol1',rol1'])


-- Resultado esperado: [ConsProyecto "Repetido",ConsProyecto "Unico",ConsProyecto "Diferente",ConsProyecto "Distinto"]
-- el repetido lo trae una sola vez.


losDevSenior :: Empresa -> [Proyecto] -> Int
--Dada una empresa indica la cantidad de desarrolladores senior que posee, que pertecen
--además a los proyectos dados por parámetro.
losDevSenior (ConsEmpresa rs) ps = cantDeDevSeniorasignadosA rs ps


cantDeDevSeniorasignadosA :: [Rol] -> [Proyecto] -> Int
cantDeDevSeniorasignadosA [] _      = 0
cantDeDevSeniorasignadosA (r:rs) ps = unoSiCeroSiNo (esDev r && esSenior (seniorityDe r) && trabajaEnAlgunoDeEstosProyectos r ps) + cantDeDevSeniorasignadosA rs ps 

rolesQueTrabajanEn :: [Rol] -> [Proyecto] -> [Rol]
rolesQueTrabajanEn []      _   = []
rolesQueTrabajanEn (r:rs)  ps  = (singularSi r (trabajaEnAlgunoDeEstosProyectos r ps)) ++ (rolesQueTrabajanEn rs ps)

singularSi :: a -> Bool -> [a]
singularSi a True  = [a]
singularSi a False = []

trabajaEnAlgunoDeEstosProyectos :: Rol -> [Proyecto] -> Bool
trabajaEnAlgunoDeEstosProyectos r []     = False
trabajaEnAlgunoDeEstosProyectos r (p:ps) = (trabajaEnElProyecto r p) || (trabajaEnAlgunoDeEstosProyectos r ps)  


trabajaEnElProyecto :: Rol -> Proyecto -> Bool
trabajaEnElProyecto r p = (nombreDelProyecto (proyectoDe r)) == (nombreDelProyecto p)

developersSeniors :: [Rol] -> [Rol]
developersSeniors rs = rolesSenior (rolesDevelopers rs)

rolesSenior :: [Rol] -> [Rol]
rolesSenior []     = []
rolesSenior (r:rs) = singularSi r (esSenior (seniorityDe r)) ++ rolesSenior rs

rolesDevelopers :: [Rol] -> [Rol]
rolesDevelopers []     = []
rolesDevelopers (r:rs) = (singularSi r (esDev r)) ++ (rolesDevelopers rs)

esDev :: Rol -> Bool
esDev (Developer _ _) = True
esDev _               = False

seniorityDe :: Rol -> Seniority
seniorityDe (Developer s _)  = s
seniorityDe (Management s _) = s

esSenior :: Seniority -> Bool
esSenior Senior = True
esSenior _      = False

proyectosTest = [proyecto1,proyecto2,proyecto4]
rolesTest = [rol2,rol3,rol4,rol1]


cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
--Indica la cantidad de empleados que trabajan en alguno de los proyectos dados.
cantQueTrabajanEn ps (ConsEmpresa rs) = longitud (rolesQueTrabajanEn rs ps)



asignadosPorProyecto :: Empresa -> [(Proyecto, Int)]
--Devuelve una lista de pares que representa a los proyectos (sin repetir) junto con su
--cantidad de personas involucradas.
asignadosPorProyecto e = contarPorProyecto (proyectosConRepetidos e)

proyectosConRepetidos :: Empresa -> [Proyecto]
proyectosConRepetidos (ConsEmpresa rs) = mapeoDeProyectos rs

contarPorProyecto :: [Proyecto] -> [(Proyecto,Int)]
contarPorProyecto []     = []
contarPorProyecto (p:ps) = sumarOAgregarProyecto p (contarPorProyecto ps)

sumarOAgregarProyecto :: Proyecto -> [(Proyecto,Int)] -> [(Proyecto,Int)]
sumarOAgregarProyecto p []           =  [(p,1)]
sumarOAgregarProyecto p1 ((p2,n):ts) =  if sonElMismoProyecto p1 p2
                                        then (p2,n+1):ts
                                        else (p2,n):sumarOAgregarProyecto p1 ts