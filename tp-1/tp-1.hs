
-- Empty module to serve as the default current module.
-- module Hugs where

-- Ejercicio 2.1.a
sucesor :: Int -> Int
sucesor x = x + 1

-- Ejercicio 2.1.b
sumar :: Int -> Int -> Int
sumar n m = n + m

-- Ejercicio 2.1.c
divisionYResto :: Int -> Int -> (Int, Int)
divisionYResto x y = (div x y , mod x y)

-- Ejercicio 2.1.d
maxDelPar :: (Int,Int) -> Int
maxDelPar (x,y) = if (x > y)
		  then x
		  else y

-- Ejercicio 3.1
data Dir = Norte | Este | Sur | Oeste
	deriving Show

-- Ejercicio 3.1.
opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Este = Oeste
opuesto Oeste = Este

-- Ejercicio 3.1.b
iguales :: Dir -> Dir -> Bool
iguales Norte Norte = True
iguales Sur Sur = True
iguales Este Este = True
iguales Oeste Oeste = True
iguales _ _ = False

-- Ejercicio 3.1.c
siguiente :: Dir -> Dir
siguiente Norte = Este
siguiente Este = Sur
siguiente Sur = Oeste

-- Ejercicio 3.2
data DiaDeLaSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo
	deriving Show

-- Ejercicio 3.2.a
minDelPar :: (Int,Int) -> Int
minDelPar (x,y) = if (x < y)
		  then x
		  else y

numeroDeDiaDeLaSemana :: DiaDeLaSemana -> Int
numeroDeDiaDeLaSemana Lunes = 1
numeroDeDiaDeLaSemana Martes = 2
numeroDeDiaDeLaSemana Miercoles = 3
numeroDeDiaDeLaSemana Jueves = 4
numeroDeDiaDeLaSemana Viernes = 5
numeroDeDiaDeLaSemana Sabado = 6
numeroDeDiaDeLaSemana Domingo = 7

diaDeLaSemanaPorNumero :: Int -> DiaDeLaSemana
diaDeLaSemanaPorNumero 1 = Lunes
diaDeLaSemanaPorNumero 2 = Martes
diaDeLaSemanaPorNumero 3 = Miercoles
diaDeLaSemanaPorNumero 4 = Jueves
diaDeLaSemanaPorNumero 5 = Viernes
diaDeLaSemanaPorNumero 6 = Sabado
diaDeLaSemanaPorNumero 7 = Domingo

primeroYUltimoDia :: (DiaDeLaSemana, DiaDeLaSemana) 
primeroYUltimoDia = (Lunes,Domingo)




-- Ejercicio 3.2.b

empiezaConM :: DiaDeLaSemana -> Bool
empiezaConM Martes = True
empiezaConM Miercoles = True
empiezaConM _ = False

-- Ejercicio 3.2.c

vieneDespues :: DiaDeLaSemana -> DiaDeLaSemana -> Bool
vieneDespues Lunes Domingo = True
vieneDespues d1 d2 = numeroDeDiaDeLaSemana d1 > numeroDeDiaDeLaSemana d2 



-- Ejercicio 3.2.d
estaEnElMedio :: DiaDeLaSemana -> Bool
estaEnElMedio Lunes = False
estaEnElMedio Domingo = False
estaEnElMedio _ = True

-- tipos enumerativos
-- 3.3.a
negar :: Bool -> Bool
negar True = False
negar False = True

-- 3.3.b
implica :: Bool -> Bool -> Bool
implica True False  = False
implica _ _         = True

-- 3.3.c
yTambien :: Bool -> Bool -> Bool
yTambien True a   = a
yTambien False _  = False

-- 3.3.d
oBien :: Bool -> Bool -> Bool
oBien False a = a
oBien True _  = True

-- 4.1
data Persona = P String Int
	deriving Show


-- 4.1.a 
nombre :: Persona -> String
nombre (P nombre edad) = nombre

-- 4.1.b
edad :: Persona -> Int
edad (P nombre edad) = edad

-- 4.1.c
crecer :: Persona -> Persona
crecer (P nombre edad) = (P nombre (edad+1))

-- 4.1.d 
cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre nuevoNombre (P nombre edad) = (P nuevoNombre edad)

-- 4.1.e
esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra persona1 persona2 = edad persona1 > edad persona2
                                     
-- 4.1.f
laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor p1 p2 = if esMayorQueLaOtra p1 p2
                    then p1
                    else p2

-- 4.2.a
data TipoDePokemon = Agua | Fuego | Planta
    deriving Show

data Pokemon = Poke TipoDePokemon Int
    deriving Show

data Entrenador = E String Pokemon Pokemon
    deriving Show

superaA :: Pokemon -> Pokemon -> Bool
superaA p1 p2 = tipoSuperaA (tipo p1) (tipo p2)

tipo :: Pokemon -> TipoDePokemon
tipo (Poke tipoDelPoke _ ) = tipoDelPoke

tipoSuperaA :: TipoDePokemon -> TipoDePokemon -> Bool
tipoSuperaA Agua Fuego 		= True
tipoSuperaA Fuego Planta 	= True
tipoSuperaA Planta Agua 	= True
tipoSuperaA _ _ 			= False
 
--4.2.b
cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe t (E _ p1 p2) =  (unoSiTipoCoincideCeroSiNo t (tipo p1)) + (unoSiTipoCoincideCeroSiNo t (tipo p2))
unoSiTipoCoincideCeroSiNo :: TipoDePokemon -> TipoDePokemon -> Int
unoSiTipoCoincideCeroSiNo t1 t2 = if (sonDelMismoTipo t1 t2)
								  then 1
								  else 0

sonDelMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
sonDelMismoTipo  Fuego Fuego 	= True
sonDelMismoTipo Agua Agua	 	= True 
sonDelMismoTipo Planta Planta 	= True 
sonDelMismoTipo _ _ 			= False

-- 4.2.c
juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
juntarPokemon (e1, e2) = listaDePokemonsDe e1 ++ listaDePokemonsDe e2

listaDePokemonsDe :: Entrenador -> [Pokemon]
listaDePokemonsDe (E _ p1 p2) = [p1,p2]

--5.
-- a.
loMismo :: a -> a
loMismo x = x

-- b.
siempreSiete :: a -> Int
siempreSiete x = 7

-- c.
swap :: (a,b) -> (b,a)
swap (n,m) = (m,n)

--6
estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia _ = False

elPrimero :: [a] -> a
elPrimero (x:_) = x
elPrimero [] = error "Lista vacia"

sinElPrimero :: [a] -> [a]
sinElPrimero (_:xs) = xs
sinElPrimero [] = error "Lista vacia"

splitHead :: [a] -> (a, [a])
splitHead list = (elPrimero list , sinElPrimero list) 