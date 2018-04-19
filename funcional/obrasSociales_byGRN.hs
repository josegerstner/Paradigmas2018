-- enunciado: https://docs.google.com/document/d/1LAL13bAlK-dRO0Qu5iF1d3Yjmcx_bQgaIgFB7_hWJco/edit

-------------------------------------------------------------------------
-- OSPF (Obra Social de Programadores Funcionales) - PDP - UNSAM 2018
-------------------------------------------------------------------------
type Sexo = Char
type Kilos = Float
type Anios = Int
type Preexistencia = String
data Socio = Socio {
    sexoP :: Sexo, 
    pesoP :: Kilos, 
    edadP :: Anios,
    preexistenciasP :: [Preexistencia]
} deriving (Show, Eq)
sexo :: Socio -> String
sexo socio
    |(sexoP socio=='H')= "Hombre"
    |(sexoP socio=='M')= "Mujer"
    |otherwise = ""
peso :: Socio -> Kilos
peso socio = pesoP socio
edad :: Socio -> Anios
edad socio = edadP socio
preexistencias :: Socio -> [Preexistencia]
preexistencias socio = preexistenciasP socio
cantidadPreexistencias :: Socio -> Int
cantidadPreexistencias socio = length (preexistencias socio)
type Pesos = Float
type CostoBase = Pesos
type Sesiones = Int
type Enfermedad = String
data Tratamiento = Tratamiento {
    costoBase :: CostoBase, --(es decir, lo que te saldría si tuvieras que atenderte sin obra social),
    sesiones :: Sesiones,
    enfermedad :: Enfermedad
} deriving (Show, Eq)
-------------------------------------------------------------------------
-- PARTE A
-- 1) Modelá a los socios y tratamientos y da ejemplos para las siguientes situaciones: 
-- jose: es hombre, 22 años, 78.9Kg y tiene "zamorreaDistopica"
-- analia: es mujer, 34 años, 70Kg, y está sana
-- x1: es tratamiento para la "zamorreaDistopica" sale $5000 y requiere 30 sesiones
-- xfg23: otro tratamiento para la "zamorreaDistopica", pero sale $10000 y consta de 2 sesiones
jose = Socio {sexoP='H',edadP=22,pesoP=78.9,preexistenciasP=["zamorreaDistopica"]}
analia = Socio {sexoP='M',edadP=34,pesoP=70,preexistenciasP=[]}
x1 = Tratamiento {enfermedad="zamorreaDistopica",costoBase=5000,sesiones=30}
xfg23 = Tratamiento{enfermedad="zamorreaDistopica",costoBase=10000,sesiones=2}

-- 2) Poder diagnosticar una preexistencia a un socio.
tienePreexistencia :: Preexistencia -> Socio -> Bool
tienePreexistencia preexistencia socio = any (==preexistencia) (preexistencias socio)

-- 3) Saber si un socio está en riesgo, que es verdadero en los siguientes casos: 
--  Obesidad (más de 150 Kg)
--  Edad Avanzada (más de 75 años)
-- --  O tiene más de 8 preexistencias
estaEnRiesgo :: Socio -> Bool
estaEnRiesgo socio = (esGordo (peso socio)) || (esViejo (edad socio)) || (estaEnfermo (preexistencias socio))
esGordo :: Kilos -> Bool
esGordo peso = peso > 150.0
esViejo :: Anios -> Bool
esViejo edad = edad > 75
estaEnfermo :: [Preexistencia] -> Bool
estaEnfermo preexistencias = 8 < (length preexistencias)

-------------------------------------------------------------------------
-- PARTE B
-- 4) Modelá las solicitudes y da el siguiente ejemplo: 
-- solicitud897: jose solicitó el tratamiento x1
-- a-
type Solicitud = (Socio, Tratamiento)
solicitud897 = (jose, x1)
socio :: Solicitud -> Socio
socio solicitud = fst solicitud
tratamiento :: Solicitud -> Tratamiento
tratamiento solicitud = snd solicitud

-- 5)-- a-
type Prestacion = Solicitud -> Pesos
prestacionTotal :: Prestacion
prestacionTotal solicitud
    |(tienePreexistencia 
    (enfermedad (tratamiento solicitud))
    (socio solicitud)) = 
        costoBase (tratamiento solicitud)
    |otherwise = 0
-- b-
prestacionSinPreexistencias :: Prestacion
prestacionSinPreexistencias solicitud
    |not (tienePreexistencia 
    (enfermedad (tratamiento solicitud)) 
    (socio solicitud)) 
        = (costoBase (tratamiento solicitud)) / 2
    |otherwise = 0
-- c-
prestacionHastaMaximo :: Pesos -> Prestacion
prestacionHastaMaximo pesos solicitud
    |(<=pesos) (costoBase (tratamiento solicitud)) = costoBase (tratamiento solicitud)
    |otherwise = pesos
nada :: Prestacion
nada _ = 0

-- 6)-- a-
-- Poder crear una prestación a partir de la suma de otras dos prestaciones.
-- nuevaPrestacion :: Prestacion -> Prestacion -> Prestacion
-- nuevaPrestacion prest1 prest2 solicitud
--     |solicitud
-- Poder crear un plan a partir de una lista de prestaciones.
-- type Plan = [Prestacion]