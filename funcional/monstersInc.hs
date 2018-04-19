-- enunciado:
-- https://docs.google.com/document/d/1saD3UYix-tqxWjoRjXNnyoVD9cEF2bY9LTGF5dTrXrI

-- 1)
type Energia = Int
data Grito = Grito {
    onomatopeya :: String,
    intensidadGrito :: Int,
    mojoLaCama :: Bool
}

energia :: Grito -> Energia
energia grito
    | mojoLaCama grito = nivelDeTerror * (cuadradoIntensidadGrito grito)
    | otherwise = triple nivelDeTerror + intensidadGrito grito
    where
        nivelDeTerror = largo grito

largo = length . onomatopeya
cuadradoIntensidadGrito = cuadrado intensidadGrito
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
    intensidadGrito = contarVocalesDe ninio,
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
    intensidadGrito = 1000,
    mojoLaCama = True
}

asustar :: Ninio -> Mounstro -> Grito
asustar ninio mounstro = mounstro ninio
-- asustar = flip ($)

type Equipo = [Mounstro]
-- 3)
asustarA :: Ninio -> Equipo -> [Grito]
asustarA equipo ninio =
    map (asustar ninio) equipo

-- 4)
type Campamento = [Ninio]
asustarATodos :: Equipo -> Campamento -> Energia
asustarATodos equipo = 
    calcularEnerigua . concat . map (\n -> asustarA n equipo)

calcularEnerigua :: [Grito] -> Energia
calcularEnerigua = sum . map energia

-- 5)
data Risa = Risa {
    duracion :: Int,
    intensidadRisa :: Int
} deriving(Show, Eq)

-- energiaRisa

type Comediante = Ninio -> Risa
capusotto :: Comediante
capusotto ninio = Risa {
    duracion = dobleDeLaEdad,
    intensidadRisa = dobleDeLaEdad
} where
    dobleDeLaEdad = dobleEdad ninio

dobleEdad ninio = 2 * edad ninio
type Circo = [Comediante]
hacerReirATodos :: Circo -> Energia
