-- serie de ejercicios de la clase 2

-- cual trago es rico?
-- daikiri es rico o nombre con mas de 10 letras es rico
type Nombre = String -- > Type Alias
type Alcohol = Int
data Trago = Ctrago Nombre Alcohol deriving (Show, Eq)-- > tipos

nombre :: Trago -> Nombre --nombre (nombre, _) = nombre
nombre (Ctrago nombre _) = nombre -- pattern matching
-- nombre = fst-- para tuplas
alcohol :: Trago -> Alcohol
alcohol (Ctrago _ alcohol) = alcohol

daikiri :: Trago
daikiri = Ctrago "Daikiri" 7

esRico :: Trago -> Bool
esRico trago = tieneMasDe10Letras (nombre trago) || esDaikiri (nombre trago)

tieneMasDe10Letras :: Trago -> Bool
-- tieneMasDe10Letras trago = length trago > 10
tieneMasDe10Letras trago = mayorA10.length nombre

-- esDaikiri trago = trago == "Daikiri" || trago == "daikiri" || trago == "Daiquiri" || trago == "daiquiri"
esDaikiri :: String -> Bool
esDaikiri "Daikiri" = True -- Pattern Matching
esDaikiri _ = False -- el guión bajo es una variable anónima, un parámetro cualquiera recibido que no se usa

esFuerte :: Trago -> Bool
esFuerte = mayorA10.alcohol

mayorA10 :: Int -> Bool
mayorA10 n = n > 10
-- el patrón más común es el nombre de una variable
--------------------------- tuplas-------------------


type Barman = (Nombre, Edad)
type Edad = Int
edad :: Barman -> Edad
edad (_, edad) = edad
nombreBarman :: Barman -> Nombre
nombreBarman (nombre, _) = nombre

type Herramienta = Barman -> Trago


emi :: Barman
emi = ("Emiliano", 25)

licuadora :: Herramienta
licuadora barman = Ctrago "Daikiri" (edadDiv10 barman)

edadDiv10 barman = div (edad barman) 10

coctelera :: Herramienta
coctelera barman = Ctrago "Gancia" (cantidadDeLetras barman)
cantidadDeLetras = length . nombreBarman

coca :: Int -> Herramienta
coca hielos barman = Ctrago "Fernet con coca" (edad barman - hielos)