-- vemos listas

-- let se usa para definir una lista
lostNumbers = [4,8,15,16,23,42]

--
numeros = [1..10]
pares numeros = head (separarPor even numeros)
impares numeros = last (separarPor even numeros)
doble :: Int -> Int
doble numero = 2 * numero
dobles = map doble

cantLetras nombres = map length nombres

paresEImpares numeros = separarPor even numeros

----

nombres = ["Lucas", "Nahuel", "Marina", "León"]

empiezanConL nombres = filter empiezaConL nombres
empiezaConL nombre = head nombre == 'L' || head nombre == 'L'
empiezanConLYNo nombres = separarPor empiezaConL nombres

separarPor :: (a -> Bool) -> [a] -> [[a]]
separarPor condicion lista = [filter condicion lista, filter (not.condicion) lista]

tomarDos = take 2

cantLetrasDeLs :: [String] -> [Int]
cantLetrasDeLs = map length . filter empiezaConL

-- para más información ver : homero.hs