pares :: [Int] -> [Int]
pares  = head . separarPor even
impares numeros = last (separarPor even numeros)

empiezanConL nombres = head . separarPor empiezaConL
noEmpiezanConL nombres = last . separarPor empiezaConL


paresEImpares = separarPor even
empiezanConLYNo = separarPor empiezaConL


empiezaConL nombre = head nombre == 'L' || head nombre == 'l'

separarPor :: (a -> Bool) -> [a] -> [[a]]
separarPor condicion lista = 
    [filter condicion lista, filter (not.condicion) lista]


dobles = map doble 

cantLetras :: [String] -> [Int]
cantLetras = map length

doble :: Int -> Int
doble = (*2)


tomarDos = take 2

filtrarLosPrimeros10 = flip filter [1..10]

cantLetrasDeLs :: [String] -> [Int]
cantLetrasDeLs = map length . filter empiezaConL
