-- 1)
type Energia = Int
data Grito = Grito {
    onomatopeya :: String,
    intensidad :: Int,
    mojoLaCama :: Bool
}

energia :: Grito -> Energia
energia grito
    | mojoLaCama grito = nivelDeTerror * cuadradoIntensidad grito
    | otherwise = triple nivelDeTerror + intensidad grito
    where 
        nivelDeTerror = largo grito

largo = length . onomatopeya
cuadradoIntensidad = cuadrado . intensidad
cuadrado = (^2)
triple = (3*)


data Ninio = Ninio {
    nombre :: String,
    edad :: Int,
    altura :: Float
}

type Monstruo = Ninio -> Grito

randal :: Monstruo
randal ninio = Grito {
    onomatopeya = "¡Mamadera!",
    intensidad = contarVocalesDe ninio,
    mojoLaCama = mideEntre 0.8 1.2 ninio
}

chuck :: Monstruo
chuck ninio = Grito {
    onomatopeya = ['a'..'z'],
    intensidad = 1000,
    mojoLaCama = True
}


contarVocalesDe :: Ninio -> Int
contarVocalesDe = length . filter esVocal . nombre

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiouAEIOU"

mideEntre min max = entre min max . altura
entre min max n = elem n [min..max]


asustar :: Ninio -> Monstruo -> Grito
asustar ninio monstruo = monstruo ninio
-- asustar = flip ($)

type Equipo = [Monstruo]

asustarA :: Ninio -> Equipo -> [Grito]
asustarA ninio = map (asustar ninio)




