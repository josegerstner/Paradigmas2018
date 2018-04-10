-- 20180403
---------------------------------
-- EXPRESIONES LAMBDA
---------------------------------
-- doble n = n * 2
doble = (\n -> n * 2)

cantRuedasBici = 2

-- flip f x y = f y x
-- const valor _ = valor
cinco = const 5

sumar :: Int -> (Int -> Int)
sumar n = (\ m -> n + m)
sumar3 :: Int -> Int -> Int -> Int
sumar3 n = (\ m -> (\ z -> n + m + z))

-- currificación (Curry Haskell)



---------------------------------
-- TYPECLASS POLIMORFISMO
---------------------------------
-- data Persona = Persona Int String deriving (Show, Eq)
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
-- cumplirAnio (Persona edad nombre) = Persona (edad+1) nombre
cumplirAnio persona = persona { edad = edad persona + 1 }



---------------------------------
-- RECURSIVIDAD
-- funcion recursiva (tengo que tener un caso base e ir acercandome al caso base en cada paso) -induccion-
---------------------------------
factorial 0 = 1
factorial n = n * factorial (n - 1)

--listas recursivas?
fLoca [x,y,z] = x+y+z
fLoca2 (cabeza : cola) = cola

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