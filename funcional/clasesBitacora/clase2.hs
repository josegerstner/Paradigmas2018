doble n = 2 * n
cuadrado n = n ^ 2

cantRuedas :: Num
cantRuedas = 2

n :: Float
n = 1.3

esPar :: Int -> Bool
esPar = even

esImpar :: Int -> Bool
esImpar = not . esPar

dobleDelCuadrado' :: Int -> Int
dobleDelCuadrado' n = doble (cuadrado n)

dobleDelCuadrado :: Int -> Int
dobleDelCuadrado = doble . cuadrado