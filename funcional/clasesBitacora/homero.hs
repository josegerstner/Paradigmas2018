type Persona = (Nombre, Peso, Bool)
type Nombre = String
type Peso = Int

type Rosquilla = Int

homero = ("Homero", 97 :: Int, True)

comer :: Rosquilla -> Persona -> Persona
-- comer rosquilla (nombre, peso) = (nombre, peso + (rosquilla * 2)) 
comer rosquilla = sumarPeso (rosquilla * 2)

tomarBirra :: Persona -> Persona
-- tomarBirra (nombre, peso) = (nombre, peso + 2)
tomarBirra = sumarPeso 2

comerMucho persona rosquillas = foldr comer persona rosquillas


-- PRIMITIVAS
sumarPeso cant (nombre, peso, esPelado) = (nombre, peso + cant, esPelado)