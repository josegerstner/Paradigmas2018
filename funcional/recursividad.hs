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