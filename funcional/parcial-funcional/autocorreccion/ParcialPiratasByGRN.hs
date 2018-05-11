-- Parcial Funcional : Piratas del Caribe
-- Alumno: José Ernesto Gerstner Javid

module ParcialPiratasByGRN
where 

import Text.Show.Functions

type Nombre = String
type Dinero = Int
type Valor = Dinero
type Botin = [Tesoro]
type Condicion = Tesoro -> Bool
type Tripulacion = [Pirata]

data Tesoro = CTesoro {
    nombreTesoro :: Nombre,
    valor :: Valor
} deriving (Show, Eq)

data Pirata = CPirata {
    nombre :: Nombre,
    botin :: Botin,
    condicionesSaqueo :: [Condicion]
} deriving (Show)

buscaTesoroMayorA10 :: Condicion
buscaTesoroMayorA10 = mayorA10.valor

type PalabraClave = String
tienePalabraClave :: PalabraClave -> Condicion
tienePalabraClave objeto tesoro = elem objeto (words (nombreTesoro tesoro))

noSaquea :: Condicion
noSaquea _ = False

seCumpleCondicionSaqueo :: Pirata -> Condicion
seCumpleCondicionSaqueo pirata tesoro = saqueaConCondicion (condicionesSaqueo pirata) tesoro

saquea :: Tesoro -> Pirata -> Pirata
saquea tesoro pirata
    |saqueaConCondicion (condicionesSaqueo pirata) tesoro = sumarTesoro tesoro pirata
    |otherwise = pirata

sumarTesoro :: Tesoro -> Pirata -> Pirata
sumarTesoro tesoro pirata = pirata { botin = (tesoro:(botin pirata)) }

saqueaConCondicion :: [Condicion] -> Tesoro -> Bool
saqueaConCondicion [] _ = True
saqueaConCondicion condiciones tesoro = ((head condiciones) tesoro) && (saqueaConCondicion (tail condiciones) tesoro)

sumarTesoroCondicional :: Ciudadano -> Pirata -> Pirata
sumarTesoroCondicional ciudadano pirata = pirata { botin = saqueaEntreVariosTesoros (tesoro ciudadano) pirata }

saqueaEntreVariosTesoros :: Botin -> Pirata -> Botin
saqueaEntreVariosTesoros [] pirata = botin pirata
saqueaEntreVariosTesoros tesoros pirata
    |seCumpleCondicionSaqueo pirata (head tesoros) = (head tesoros) : (botin pirata)
    |otherwise = saqueaEntreVariosTesoros (tail tesoros) pirata


type Isla = Botin
type Saqueo = Tripulacion -> Tripulacion

anclarEnIsla :: Isla -> Saqueo
anclarEnIsla isla [] = []
anclarEnIsla isla tripulacion = zipWith sumarTesoro isla tripulacion

type Ciudad = [Ciudadano]
data Ciudadano = CCiudadano {
    nombreC :: Nombre,
    tesoro :: Botin
} deriving (Show)

saquearCiudad :: Ciudad -> Saqueo
saquearCiudad ciudad tripulacion = zipWith sumarTesoroCondicional ciudad tripulacion

convertirEnPirata :: Ciudadano -> [Condicion] -> Pirata
convertirEnPirata ciudadano nuevasCondicionesSaqueo = CPirata {
    nombre = nombreC ciudadano,
    botin = tesoro ciudadano,
    condicionesSaqueo = nuevasCondicionesSaqueo
}

sumarPirata :: Pirata -> Tripulacion -> Tripulacion
sumarPirata pirata tripulacion = pirata : tripulacion

protegerBotin :: Pirata -> Pirata -> Pirata
protegerBotin atacado atacante
    |comparoBarbas atacado atacante = atacado { botin = (botin atacante)++(botin atacado) }
    |otherwise = atacado {botin = []}

comparoBarbas :: Pirata -> Pirata -> Bool
comparoBarbas atacado atacante = (largoBarba atacado) >= (largoBarba atacante)

largoBarba :: Pirata -> Int
largoBarba pirata = sum (map valor (botin pirata))


-- Se quiere saber el estado de una tripulación luego de ser atacada por otra. 
-- Cuando una tripulación es atacada:
-- Primero, los que piratas que no tienen botín se tiran por la borda y abandonan la tripulación.
-- abandonan :: Tripulacion -> Tripulacion
-- abandonan tripulacion = filter (quienSaquea) tripulacion 

-- quienNoSaquea :: Pirata -> Bool
-- quienNoSaquea = noSaquea == (condicionesSaqueo pirata)

-- Luego, de los tripulantes que quedan, son atacados uno a uno por los piratas atacantes. 
-- Si hay más piratas en algunos de los bandos entonces se quedarán sin pelear.
-- sonAtacados 
-- comparoCantidadDePiratas :: Tripulacion -> Tripulacion -> Bool
comparoCantidadDePiratas :: Tripulacion -> Tripulacion -> Bool
comparoCantidadDePiratas atacados atacantes = (cantidadPiratas atacados) == (cantidadPiratas atacantes)

-- defenderTripulacion :: Tripulacion -> Tripulacion -> Tripulacion
-- defenderTripulacion tripulacionAtacada tripulacionAtacante



-- Genéricas
mayorA10 :: Int -> Bool
mayorA10 = (>10)

tesorosDeIsla :: Isla -> Int
tesorosDeIsla = length

cantidadPiratas :: Tripulacion -> Int
cantidadPiratas tripulacion = length tripulacion