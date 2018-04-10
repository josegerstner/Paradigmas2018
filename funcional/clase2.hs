doble n = 2 * n
cuadrado n = n ^ 2

cantRuedas = 2

esPar :: Int -> Bool
esPar n = even n

-- esImpar = not.esPar --notación PointFree
-- esImpar n = (not . esPar) n
esImpar n = not . esPar $ n -- el $ es para aplicar lo que hay a la derecha en lo que está a la izquierda es como poner paréntesis en todo lo que está a la derecha y en todo lo que está a la izquierda

dobleDelCuadrado' :: Int -> Int
dobleDelCuadrado' n = doble (cuadrado n)

dobleDelCuadrado :: Int -> Int
dobleDelCuadrado = doble.cuadrado

-- para más información ver: "tragos.hs"