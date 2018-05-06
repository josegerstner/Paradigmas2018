import Text.Show.Functions

-- 1)
type Enfermedad = String

data Sexo = M | H | O deriving (Show, Eq)

data Socio = Socio {
    sexo :: Sexo,
    peso :: Float ,
    edad :: Int,
    preexistencias :: [Enfermedad]
} deriving (Show, Eq)

cantPreexistentes :: Socio -> Int
cantPreexistentes = length . preexistencias

data Tratamiento = Tratamiento {
    costoBase :: Pesos,
    nroSesiones :: Int,
    enfermedad :: Enfermedad
} deriving (Show, Eq)

jose = Socio H 78.9 22 ["zamorreaDistopica"]
analia = Socio M 70 34 []

x1 = Tratamiento 5000 30 "zamorreaDistopica"
xfg23 = Tratamiento 10000 2 "zamorreaDistopica"

-- 2)
diagnosticar :: Enfermedad -> Socio -> Socio
diagnosticar enfermedad socio = 
    socio { preexistencias = enfermedad : preexistencias socio }

-- 3)
estaEnRiesgo :: Socio -> Bool
estaEnRiesgo socio = esObeso socio || esViejo socio || muyEnfermo socio

esObeso = (>150) . peso
esViejo = (>75) . edad
muyEnfermo = (>8) . cantPreexistentes

-- 4)
type Solicitud = (Socio, Tratamiento)

socio = fst
tratamiento = snd

solicitud897 = (jose, x1)


-- 5)
type Pesos = Int
type Cobertura = Pesos

type Prestacion = Solicitud -> Cobertura

prestacionTotal :: Enfermedad -> Prestacion
-- prestacionTotal enfermedad solicitud
--     |esPara enfermedad solicitud = costoTratamiento solicitud
--     |otherwise = 0
prestacionTotal enfermedad = prestacionPorCondicion (esPara enfermedad) id

prestacionSinPreexistencias :: Prestacion
-- prestacionSinPreexistencias solicitud
--     |not . enfermedadPreexistente $ solicitud = mitad . costoTratamiento $ solicitud
--     |otherwise = 0
prestacionSinPreexistencias = 
    prestacionPorCondicion (not . enfermedadPreexistente) mitad


prestacionPorCondicion cond calculoCobertura solicitud
    |cond solicitud = (calculoCobertura . costoTratamiento) solicitud
    |otherwise = 0


prestacionHastaMaximo :: Pesos -> Prestacion
prestacionHastaMaximo pesos = min pesos . costoTratamiento

nada :: Prestacion
nada = const 0
-- nada _ = 0

esPara :: Enfermedad -> Solicitud -> Bool
esPara enferm = (enferm ==) . enfermedadTramiento

enfermedadPreexistente solicitud = 
    esPreexistente (enfermedadTramiento solicitud) (socio solicitud)

esPreexistente :: Enfermedad -> Socio -> Bool
esPreexistente enfermedad = elem enfermedad . preexistencias

costoTratamiento = costoBase . tratamiento
enfermedadTramiento = enfermedad . tratamiento

mitad = flip div 2

-- 6)
sumar :: Prestacion -> Prestacion -> Prestacion
sumar unaPrestacion otraPrestacion solicitud =
    max (unaPrestacion solicitud) (otraPrestacion solicitud)



plan :: [Prestacion] -> Prestacion
plan = foldl sumar nada


