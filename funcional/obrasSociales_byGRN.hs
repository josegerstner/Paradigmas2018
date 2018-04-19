-- enunciado: https://docs.google.com/document/d/1LAL13bAlK-dRO0Qu5iF1d3Yjmcx_bQgaIgFB7_hWJco/edit

-------------------------------------------------------------------------
-- OSPF (Obra Social de Programadores Funcionales) - PDP - UNSAM 2018
-------------------------------------------------------------------------
data Socio = Socio {
    sexo :: Char, 
    peso :: Float, 
    edad :: Int,
    preexistencias :: [Preexistencia]
} deriving (Show, Eq)
data Tratamiento = Tratamiento {
    costoBase :: Int, --(es decir, lo que te saldría si tuvieras que atenderte sin obra social),
    sesiones :: Int,
    enfermedad :: String
}
-------------------------------------------------------------------------
-- PARTE A
-- 1)
jose = Socio {sexo='H', edad=22, peso= 78.9, preexistencias=["zamorreaDistopica"]}
analia = Socio {sexo='M', edad=34, peso=70.0, preexistencias=[]} -- : es mujer, 34 años, 70Kg, y está sana
x1 = Tratamiento {
    enfermedad = "zamorreaDistopica", -- : es tratamiento para la "zamorreaDistopica" 
    costoBase = 5000, -- sale $5000 
    sesiones = 30 -- y requiere 30 sesiones
}
xfg23 = Tratamiento{
    enfermedad = "zamorreaDistopica",
    costoBase = 10000,
    sesiones = 2
} -- : otro tratamiento para la "zamorreaDistopica", pero sale $10000 y consta de 2 sesiones

-- 2) Poder diagnosticar una preexistencia a un socio.
type Preexistencia = String
preexistencia [] = 0

-- tienePreexistencia :: Preexistencia -> Socio -> Bool
-- tienePreexistencia preexistencia = any preexistencia preexistencias

-- 3) Saber si un socio está en riesgo, que es verdadero en los siguientes casos: 
--  Obesidad (más de 150 Kg)
--  Edad Avanzada (más de 75 años)
-- --  O tiene más de 8 preexistencias
-- estaEnRiesgo :: Socio -> Bool
-- estaEnRiesgo socio = esGordo peso socio

esGordo :: Socio -> Bool
esGordo socio = (> 150.0) peso