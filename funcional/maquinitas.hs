-- Expertos en maquinitas

-- Queremos desarrollar un programa en Haskell para modelar los juegos de un casino 
-- y la posibilidad de los jugadores de ganar o salir con los bolsillos vacíos.

-- La información que disponemos de las personas es 
-- su nombre, la cantidad de dinero que tienen, su suerte 
type Nombre = String
type Dinero = Float
type Suerte = Int
-- y una lista de factores que pueden ayudarles a ganar distintos juegos, 
-- como ser su inteligencia, algún amuleto, etc.
-- De cada factor tenemos un valor numérico que nos indica qué tan valioso es.
type Paciencia = Int
type ValorAmuleto = Int

-- 1. Conocer la suerte total de una persona. Si no tiene un amuleto, es su suerte normal, 
-- si tiene uno, su suerte se multiplica por el valor de ese amuleto.
-- En general, sólo se considera que una persona tiene un factor si el valor del mismo es mayor a cero.
-- Tener un amuleto de valor 0 es lo mismo que no tenerlo en absoluto.
data Jugador = CJugador {
    nombre :: String,
    dinero :: Dinero,
    suerte :: Suerte,
    paciencia :: Paciencia,
    amuleto :: ValorAmuleto
}

instance Show Jugador where
    show = nombre

instance Eq Jugador where
    (==) unJugador otroJugador = nombre unJugador == nombre otroJugador

haceApuesta :: Apuesta -> Jugador -> Jugador
haceApuesta apuesta jugador
    |apuesta < dinero jugador = jugador { dinero = dinero jugador - apuesta }
    |otherwise = jugador

tienePaciencia :: Jugador -> Bool
tienePaciencia = mayorQue0.paciencia

tieneAmuleto :: Jugador -> Bool
tieneAmuleto = mayorQue0.amuleto

suerteJugador :: Jugador -> Int
suerteJugador jugador
    |tieneAmuleto jugador = amuleto jugador * suerte jugador
    |otherwise = suerte jugador

-- 2. Desarrollar los juegos ruleta y maquinita sabiendo que 
-- un juego se compone por un nombre, 
-- un premio que determina cuánto dinero se ganaría a partir de un monto apostado
-- y una serie de criterios determinantes para ganar. ???
-- Para modelar el dinero usar el tipo Float.

type Apuesta = Dinero
type Premio = Dinero
type Condicion = Bool

data Juego = CJuego {
    nombreJ :: Nombre,
    -- premio :: Premio,
    condiciones :: [Condicion]
}
instance Show Juego where
    show = nombreJ
instance Eq Juego where
    (==) unJuego otroJuego = nombreJ unJuego == nombreJ otroJuego

-- a- La ruleta que se gana 37 veces lo apostado.
-- Para ganar la persona debe tener una suerte total mayor a 80.
ruleta :: Juego
ruleta = CJuego {
    nombreJ = "Ruleta",
    -- premio = premioRuleta apuesta jugador,
    condiciones = condicionesRuleta
}

condicionesRuleta :: [Condicion]
condicionesRuleta = [(suerteJugadorMayorQue80)]

premioRuleta :: Apuesta -> Jugador -> Premio
premioRuleta apuesta jugador
    |pasaCondicionesRuleta = apuesta * 37
    |otherwise = 0.0

pasaCondicionesRuleta :: Condicion
pasaCondicionesRuleta = and condicionesRuleta

suerteJugadorMayorQue80 :: Condicion
suerteJugadorMayorQue80 = mayorQue80 suerte

-- b- La maquinita que se basa en un jackpot y lo que se gana es la apuesta más el jackpot.
-- Para ganar se deben cumplir dos condiciones: que la persona tenga una suerte total mayor a 95
-- y además que tenga paciencia.
type Jackpot = Float
maquinita :: Juego
maquinita = CJuego {
    nombreJ = "Maquinita", 
--    premio = ganaMaquinita jugador, 
    condiciones = condicionesMaquinita
}

condicionesMaquinita :: [Condicion]
condicionesMaquinita = [(suerteJugadorMayorQue95)]

premioMaquinita :: Jackpot -> Apuesta -> Jugador -> Premio
premioMaquinita jackpot apuesta jugador
    |pasaCondicionesRuleta = apuesta + jackpot
    |otherwise = 0.0

pasaCondicionesMaquinita :: Bool
pasaCondicionesMaquinita = and condicionesMaquinita


suerteJugadorMayorQue95 :: Int -> Condicion
suerteJugadorMayorQue95 jugador = mayorQue95 suerte

-- 3. Saber si un jugador puede ganar un juego, lo cual sucede si
-- cumple todas las condiciones para ganar ese juego.
-- ganaJuego :: Juego -> Jugador -> Bool
-- ganaJuego juego jugador = condiciones juego jugador
-- 4. Dada una apuesta inicial, obtener la cantidad total de dinero que puede conseguir
-- un jugador con ese monto si va a un casino.
-- Cuando alguien va a un casino apuesta en cada juego lo conseguido en el juego anterior,
-- evitando los juegos en los cuales no pueda ganar.
-- Si no puede ganar en ningún juego, el resultado sería la apuesta inicial,
-- ya que no apostaría en ninguno.

-- 5. Algunos jugadores van a los casinos en grupos. Queremos saber, dado un casino,
-- los nombres de los jugadores de un grupo que no pueden ganar a ningún juego.

-- 6. Hacer que un jugador apueste una cantidad en un juego, que implica que la persona
-- baje su saldo esa cantidad y luego juegue al juego. Si puede ganar en ese juego,
-- la persona incrementa su saldo en lo que gana en el juego, de lo contrario no gana nada.

-- Funciones genéricas
mayorQue80 :: Num a => a -> Bool
mayorQue80 = (> 80)

mayorQue95 :: Num a => a -> Bool
mayorQue95 = (> 95)

mayorQue0 :: Num a => a -> Bool
mayorQue0 = (> 0)

-- VALORES PARA PRUEBAS
pepe = CJugador "Pepe" 300.00  81 50  0
mara = CJugador "Mara" 1500.50 50 100 2