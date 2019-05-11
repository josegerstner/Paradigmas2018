-- data Persona = Persona Int String deriving(Show, Eq)

-- edad :: Persona -> Int
-- edad (Persona edad _) = edad

data Persona = Persona {
    edad :: Int,
    nombre :: String
} deriving (Show, Eq)

homero = Persona 30 "Homero"

marge = Persona {
    nombre = "Marge",
    edad = 30
}

cumplirAnio :: Persona -> Persona
-- cumplirAnio (Persona edad nombre) = Persona (edad + 1) nombre
cumplirAnio persona = persona { edad = edad persona + 1 }

----------------------------------

-- doble n = n * 2
doble = (\n -> n * 2)

cinco = const 5

cantRuedasBici = 2

sumar3 :: Int -> Int -> Int -> Int
-- sumar3 n m z = n + m + z
sumar3 n = (\ m -> (\ z -> n + m + z))


----------------------------------

factorial 0 = 1
factorial n = n * factorial (n-1)

fLoca [x,y,z] = x+y+z
fLoca2 (cabeza : cola) = cola


----------------------------------
sumarMuchos :: [Int] -> Int
sumarMuchos [] = 0
sumarMuchos (cabeza : cola) = cabeza + sumarMuchos cola

sumarMuchos' :: [Int] -> Int
sumarMuchos' = foldl (+) 0

cantidadDeElementos :: [a] -> Int
cantidadDeElementos [] = 0
cantidadDeElementos (_ : cola) = 1 + cantidadDeElementos cola


esAscendente :: Ord a => [a] -> Bool
esAscendente [] = False
esAscendente [_] = True
esAscendente (primero : segundo : cola) = 
    primero < segundo && esAscendente (segundo : cola)
