-- enunciado:
-- https://docs.google.com/document/d/1saD3UYix-tqxWjoRjXNnyoVD9cEF2bY9LTGF5dTrXrI

-- 1)
type Energia = Int
data Grito = Grito {
    onomatopeya :: String,
    intensidad :: Int,
    mojoLaCama :: Bool
}
energia :: Grito -> Energia
energia grito
    | mojoLaCama grito = nivelDeTerror * (cuadradoIntensidad grito)
    | otherwise = triple nivelDeTerror + intensidad grito
    where
        nivelDeTerror = largo grito

largo = length . onomatopeya
cuadradoIntensidad = cuadrado intensidad
cuadrado = (^2)
triple = (3*)


data Ninio = Ninio {
    nombre :: String,
    edad :: Int,
    altura :: Float
}

type Mounstro = Ninio -> Grito


randal :: Mounstro
randal ninio = Grito {
    onomatopeya = "¡Mamadera!",
    intensidad = contarVocalesDe ninio,
    mojoLaCama = mideEntre 0.8 1.2 ninio
}

contarVocalesDe :: Ninio -> Int
contarVocalesDe = length . filter esVocal . nombre

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiouAEIOU"

mideEntre min max = entre min max . altura
entre min max n = elem [min..max]

chuckNorris :: Mounstro
chuckNorris = Grito {
    onomatopeya = ['a'..'z'],
    intensidad = 1000,
    mojoLaCama = True
}

asustar :: Ninio -> Mounstro -> Grito
asustar ninio mounstro = mounstro ninio
-- asustar = flip ($)

type Equipo = [Mounstro]

asustarA :: Ninio -> Equipo -> [Grito]
asustarA equipo ninio =
    map (asustar ninio) equipo