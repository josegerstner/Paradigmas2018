module Funcional
where 
import Text.Show.Functions
import Data.List
import Data.Ord 
----------------------------------
type Nombre = String
type Padre = String
type Fuerza = Int
type Precision = Int
type Velocidad = Int
type Altura = Int
type Efecto = Bool
type Puntos = Int
type Habilidades = (Fuerza, Precision)
type CarritoDePalos = [Palo]

-------PARTICIPANTE-------
data Participante = Participante {
    nombre :: Nombre,
    padre :: Padre,
    fuerza :: Fuerza,
    precisionP :: Precision,
    palos :: CarritoDePalos,
    puntosParticipante :: Puntos
    }   deriving (Show)
    
instance Eq Participante where
        (==) unParticipante otroParticipante = nombre unParticipante == nombre otroParticipante
        
esHabilidoso :: Participante -> Bool
esHabilidoso = bueno . sumaDeHabilidades

sumaDeHabilidades :: Participante -> Int
sumaDeHabilidades participante = fuerza participante + precisionP participante

------ TIROS ------
data Tiro = Tiro {
    velocidad :: Velocidad,
    precision :: Precision,
    altura :: Altura,
    efecto :: Efecto,
    puntosTiro :: Puntos
}   deriving (Show, Eq)

------ PALOS ------
type Palo = Participante -> Tiro

putter :: Palo
putter participante = Tiro {
   velocidad = 10,
   precision = doble (precisionP participante),
   altura = 0,
   efecto = False,
   puntosTiro = 0
}

madera :: Palo
madera participante = Tiro {
    velocidad = 100,
    altura = 5,
    precision = precisionP participante,
    efecto = False,
    puntosTiro = 0
}

type Hierro = Int -> Palo
hierro :: Int -> Palo
hierro nroPalo participante = Tiro {
    velocidad = (fuerza participante) * nroPalo,
    altura = cuadrado nroPalo,
    precision = (precisionP participante) `div` nroPalo,
    efecto = False,
    puntosTiro = 0
}

matarTiro :: Tiro -> Tiro
matarTiro tiro = Tiro {
    velocidad = 0,
    precision = 0,
    altura = 0,
    efecto = perderEfecto,
    puntosTiro = puntosTiro tiro
}

efectuarTiro :: Palo -> Participante -> Tiro 
efectuarTiro palo participante = cambiarEfecto (esHabilidoso participante) (palo participante) 

cambiarEfecto :: Efecto -> Tiro -> Tiro
cambiarEfecto efecto tiro = tiro { efecto = efecto }
-----------------------------------------------------------

-- OBSTACULOS
type Obstaculo = Tiro -> Tiro
atravesarObstaculo :: Tiro -> Obstaculo ->Tiro
atravesarObstaculo tiro obstaculo = obstaculo tiro  

obstaculo :: (Tiro -> Bool) -> (Tiro -> Tiro) -> Obstaculo
obstaculo supera exito tiro
    |supera tiro = sumarUnPunto (exito tiro)
    |otherwise = matarTiro tiro
    
sumarUnPunto tiro = tiro { puntosTiro = sumar1 (puntosTiro tiro) }

tunelConRampa :: Obstaculo
tunelConRampa tiro = obstaculo superaTunel exitoTunel tiro

superaTunel :: Tiro -> Bool
superaTunel tiro =  buenaPrecision tiro && altura0 tiro

exitoTunel :: Obstaculo
exitoTunel tiro = tiro {
    velocidad = dobleVelocidad tiro,
    precision = 100
}

laguna :: Int -> Obstaculo
laguna metros tiro = obstaculo superaLaguna (exitoLaguna metros) tiro

superaLaguna :: Tiro -> Bool
superaLaguna tiro = buenaVelocidad tiro && alturaEntre10y50 tiro

exitoLaguna :: Int -> Obstaculo
exitoLaguna metros tiro = tiro {
    altura = (altura tiro) `div` metros
}

hoyo :: Obstaculo
hoyo tiro = obstaculo superaHoyo exitoHoyo tiro

superaHoyo :: Tiro -> Bool
superaHoyo tiro = velocidadOEfecto tiro  && excelentePrecisionYAltura0 tiro

exitoHoyo :: Obstaculo
exitoHoyo tiro = tiro {
    velocidad = 0,
    precision = 0,
    altura = 0,
    efecto = perderEfecto
}

molino :: Obstaculo
molino tiro = obstaculo superaMolino exitoMolino tiro

superaMolino :: Tiro -> Bool
superaMolino tiro = buenaPrecisionYEfecto tiro || buenaVelocidadYExcelentePrecision tiro

exitoMolino :: Obstaculo
exitoMolino tiro = tiro {  
    velocidad = restar10 (velocidad tiro),
    efecto = perderEfecto
}

------  TORNEOS ------
data Torneo = Torneo {
    recorridos :: [Recorrido],
    participantes :: [Participante]
} deriving (Show)

pierdenTorneo :: Torneo -> [Participante]
pierdenTorneo torneo = elegirPerdedores (participantes torneo) (recorridos torneo)

elegirPerdedores :: [Participante] -> [Recorrido] -> [Participante] 
elegirPerdedores participantes = filtrarGanador . ordenarPorPuntos . calcularPuntajes participantes

padresPerdedores :: Torneo -> [Padre]
padresPerdedores = map padre . pierdenTorneo

filtrarGanador :: [Participante] -> [Participante]
filtrarGanador participantes 
    |hayGanador participantes = tail participantes
    |otherwise = participantes

hayGanador :: [Participante] -> Bool
hayGanador = distintosSegun puntosParticipante . tomar2

distintosSegun f [participante1, participante2] = distinto (f participante1) (f participante2)

puntosDelParticipante :: ([a] -> Participante) -> [a] -> Puntos
puntosDelParticipante func participantes = puntosParticipante (tomar2Participantes (func) participantes)

tomar2Participantes :: ([a] -> t) -> [a] -> t
tomar2Participantes func participantes = func (tomar2 participantes)

tomar2 :: [a] -> [a]
tomar2 = take 2

ordenarPorPuntos :: [Participante] -> [Participante]
ordenarPorPuntos = ordenarDeMayorAMenorSegun puntosParticipante

ordenarDeMayorAMenorSegun f = reverse . sortBy (comparing f)

calcularPuntajes :: [Participante] -> [Recorrido] -> [Participante]
calcularPuntajes participantes recorridos = map (nuevoPuntaje recorridos)  participantes

nuevoPuntaje :: [Recorrido] -> Participante -> Participante
nuevoPuntaje recorridos participante = participante {
    puntosParticipante = recorrerTorneo recorridos participante
}

recorrerTorneo :: [Recorrido] -> Participante -> Puntos
recorrerTorneo  recorridos participante = sum . map (intentarRecorrido participante) $ recorridos

intentarRecorrido :: Participante -> Recorrido -> Puntos
intentarRecorrido participante recorrido = puntosParticipante participante + puntosTiro (elegirPalo participante recorrido)

elegirPalo :: Participante -> Recorrido -> Tiro
elegirPalo participante recorrido
    |esHabilidoso participante = meditaPalo participante recorrido
    |otherwise = simularTiro participante recorrido (primerPalo participante)

primerPalo = head . palos

meditaPalo :: Participante -> Recorrido -> Tiro
meditaPalo participante =  head . ordenarPorPuntosTiro . mapearPalo participante

mapearPalo participante recorrido = map (simularTiro participante recorrido) (palos participante)

ordenarPorPuntosTiro:: [Tiro] ->[Tiro]
ordenarPorPuntosTiro = ordenarDeMayorAMenorSegun puntosTiro

simularTiro :: Participante -> Recorrido -> Palo -> Tiro
simularTiro participante recorrido palo = finalizandoTiro (efectuarTiro palo participante) recorrido

-- FIN TORENOS -- 

-------------------------------------------------------------------------------------------
-- RECORRIDOS -- 

data Recorrido = Recorrido {
    obstaculos :: [Obstaculo]
} deriving (Show )

atravesarRecorrido :: Tiro -> Recorrido -> Puntos
atravesarRecorrido tiro recorrido = puntosTiro (finalizandoTiro tiro recorrido)

superaRecorridoCompleto :: Tiro -> Recorrido -> Bool
superaRecorridoCompleto tiro recorrido = (puntosTiro tiro) == (tamanioRecorrido recorrido)

finalizandoTiro :: Tiro -> Recorrido -> Tiro
finalizandoTiro tiro recorrido = finalizarRecorrido (recorrer tiro recorrido) recorrido

finalizarRecorrido :: Tiro -> Recorrido -> Tiro
finalizarRecorrido tiro recorrido
    |superaRecorridoCompleto tiro recorrido = tiroRecorridoCompleto tiro
    |otherwise = tiro

recorrer :: Tiro -> Recorrido -> Tiro  
recorrer tiro = foldl atravesarObstaculo tiro . obstaculos

tiroRecorridoCompleto :: Tiro -> Tiro
tiroRecorridoCompleto = sumarUnPunto

tamanioRecorrido :: Recorrido -> Int
tamanioRecorrido = length.obstaculos
-------------------------------------------------------------
------- FIN RECORRIDOS--------

    -- GENERICAS
doble :: Int -> Int
doble = (*2)

cuadrado :: Int -> Int
cuadrado = (^2)

sumar1 :: Int -> Int
sumar1  = (+) 1

igualA0 :: Int -> Bool
igualA0 = (== 0)

altura0 :: Tiro -> Bool
altura0 = igualA0.altura

entre::Int -> Int -> Int ->Bool
entre valor par1 par2= valor>=par1 && valor<= par2

entre5y20 :: Int-> Bool
entre5y20 a = entre a 5 20

entre10y50 :: Int-> Bool
entre10y50 a = entre a 10 50 

bueno :: Int -> Bool
bueno = (> 80)

excelente :: Int -> Bool
excelente = (> 95)

excelentePrecision :: Tiro -> Bool
excelentePrecision = excelente.precision

buenaVelocidad :: Tiro -> Bool
buenaVelocidad = bueno.velocidad

buenaPrecision :: Tiro -> Bool
buenaPrecision = bueno.precision

dobleVelocidad :: Tiro -> Int
dobleVelocidad = doble.velocidad

excelentePrecisionYAltura0 :: Tiro -> Bool
excelentePrecisionYAltura0 tiro = excelentePrecision tiro && altura0 tiro

velocidadOEfecto :: Tiro -> Bool
velocidadOEfecto tiro = velocidadEntre5y20 tiro || conEfecto tiro

conEfecto :: Tiro -> Bool
conEfecto = efecto

buenaPrecisionYEfecto :: Tiro -> Bool
buenaPrecisionYEfecto tiro = buenaPrecision tiro && conEfecto tiro

buenaVelocidadYExcelentePrecision :: Tiro -> Bool
buenaVelocidadYExcelentePrecision tiro = buenaVelocidad tiro && excelentePrecision tiro

bajaDeCero :: Int -> Int
bajaDeCero num 
    |menorACero num = 0
    |otherwise = num

menorACero :: Int -> Bool
menorACero = (< 0)

restar10 :: Int -> Int
restar10 = bajaDeCero . menos10

menos10 :: Int -> Int
menos10 = (+ (-10))

perderEfecto:: Bool
perderEfecto = False

alturaEntre10y50 :: Tiro -> Bool
alturaEntre10y50 = entre10y50.altura

velocidadEntre5y20 :: Tiro -> Bool
velocidadEntre5y20 = entre5y20.velocidad

distinto a b = a /= b