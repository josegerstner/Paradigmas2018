-- 1)
type Energia = Int

data Grito = Grito {
    onomatopeya :: String,
    intensidadGrito :: Int,
    mojoLaCama :: Bool
}

energiaGrito :: Grito -> Energia
energiaGrito grito
    | mojoLaCama grito = nivelDeTerror * cuadradoIntensidadGrito grito
    | otherwise = triple nivelDeTerror + intensidadGrito grito
    where 
        nivelDeTerror = largo grito

largo = length . onomatopeya
cuadradoIntensidadGrito = cuadrado . intensidadGrito
cuadrado = (^2)
triple = (3*)


data Ninio = Ninio {
    nombre :: String,
    edad :: Int,
    altura :: Float
} deriving (Show, Eq)

dobleEdad :: Ninio -> Int
dobleEdad = (*2) . edad

pepe = Ninio "Pepe" 12 1.4
maria = Ninio "Maria" 11 1.6

type Monstruo = Ninio -> Grito

randal :: Monstruo
randal ninio = Grito {
    onomatopeya = "¡Mamadera!",
    intensidadGrito = contarVocalesDe ninio,
    mojoLaCama = mideEntre 0.8 1.2 ninio
}

chuck :: Monstruo
chuck ninio = Grito {
    onomatopeya = ['a'..'z'],
    intensidadGrito = 1000,
    mojoLaCama = True
}


contarVocalesDe :: Ninio -> Int
contarVocalesDe = length . filter esVocal . nombre

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiouAEIOU"

mideEntre min max = entre min max . altura
entre min max n = elem n [min..max]
-- 3)
type Equipo = [Monstruo]

equipoAsustador = [randal, chuck]



-- 5)
data Risa = Risa {
    duracion :: Int,
    intensidadRisa :: Int
} deriving (Show, Eq)

energiaRisa risa = duracion risa ^ intensidadRisa risa

type Comediante = Ninio -> Risa

capusotto :: Comediante
capusotto ninio = Risa {
    duracion = dobleDeLaEdad,
    intensidadRisa = dobleDeLaEdad
} where
    dobleDeLaEdad = dobleEdad ninio







reir :: Ninio -> Comediante -> Risa
reir ninio comediante = comediante ninio

asustar :: Ninio -> Monstruo -> Grito
asustar ninio monstruo = monstruo ninio
-- asustar = flip ($)


type Circo = [Comediante]

hacerReirA :: Ninio -> Circo -> [Risa]
-- hacerReirA ninio = map (reir ninio)
hacerReirA = aplicarANinio reir

asustarA :: Ninio -> Equipo -> [Grito]
-- asustarA ninio = map (asustar ninio)
asustarA = aplicarANinio asustar

aplicarANinio f ninio = map (f ninio)



calcularEnergiaGritos :: [Grito] -> Energia
-- calcularEnergiaGritos = sum . map energiaGrito
calcularEnergiaGritos = sumarEnergia energiaGrito


calcularEnergiaRisas :: [Risa] -> Energia
-- calcularEnergiaRisas = sum . map energiaRisa
calcularEnergiaRisas = sumarEnergia energiaRisa

sumarEnergia f = sum . map f




hacerReirATodos :: Circo -> Campamento -> Energia
hacerReirATodos circo =
    -- calcularEnergiaRisas . concat . map (\n -> hacerReirA n circo)
    calcularEnergiaRisas . molestarATodos hacerReirA circo

asustarATodos :: Equipo -> Campamento -> Energia
asustarATodos equipo = 
    -- calcularEnergiaGritos . concat . map (\n -> asustarA n equipo)
    calcularEnergiaGritos . molestarATodos asustarA equipo

molestarATodos f grupo = concat . map (\n -> f n grupo)


-- 4)
type Campamento = [Ninio]

campamentoAsustado = [maria, pepe]

