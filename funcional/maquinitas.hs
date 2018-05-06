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
type Inteligencia = Int
type ValorAmuleto = Int

-- 1. Conocer la suerte total de una persona. Si no tiene un amuleto, es su suerte normal, 
-- si tiene uno, su suerte se multiplica por el valor de ese amuleto.
-- En general, sólo se considera que una persona tiene un factor si el valor del mismo es mayor a cero.
-- Tener un amuleto de valor 0 es lo mismo que no tenerlo en absoluto.
data Jugador = Jugador {
    nombre :: String,
    dinero :: Dinero,
    suerte :: Suerte,
    inteligencia :: Inteligencia,
    amuleto :: ValorAmuleto
} deriving(Show, Eq)

haceApuesta :: Apuesta -> Jugador -> Jugador
haceApuesta apuesta jugador = jugador {dinero=dinero jugador - apuesta}

tieneAmuleto :: Jugador -> Bool
tieneAmuleto jugador = amuleto jugador > 0

suerteJugador :: Jugador -> Int
suerteJugador jugador
    |tieneAmuleto jugador = amuleto jugador * suerte jugador
    |otherwise = suerte jugador


-- 2. Desarrollar los juegos ruleta y maquinita sabiendo que 
-- un juego se compone por un nombre, 
-- un premio que determina cuánto dinero se ganaría a partir de un monto apostado
-- y una serie de criterios determinantes para ganar.
-- Para modelar el dinero usar el tipo Float.
data Juego = Juego {
    nombreJ :: Nombre,
    premio :: Dinero
}
type Apuesta = Dinero
-- type Juego = Jugador -> Apuesta
-- a- La ruleta que se gana 37 veces lo apostado.
-- Para ganar la persona debe tener una suerte total mayor a 80.
ruleta = Juego {nombreJ="Ruleta",premio=0.0}

ganaRuleta jugador = suerte jugador > 80
premioRuleta apuesta = apuesta * 37

-- b- La maquinita que se basa en un jackpot y lo que se gana es la apuesta más el jackpot.
-- Para ganar se deben cumplir dos condiciones: que la persona tenga una suerte total mayor a 95
-- y además que tenga paciencia.

-- 3. Saber si un jugador puede ganar un juego, lo cual sucede si
-- cumple todas las condiciones para ganar ese juego.

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


-- VALORES PARA PRUEBAS
pepe = Jugador {nombre="Pepe",dinero=300.00,suerte=81,inteligencia=100,amuleto=0}
mara = Jugador {nombre="Mara",dinero=500.50,suerte=31,inteligencia=100,amuleto=2}