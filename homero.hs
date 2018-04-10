-- personaRosquilla.hs
type Persona = (Nombre, Peso)
type Nombre = String
type Peso = Int

type Rosquilla = Int

homero = ("Homero", 97 :: Int)

comer :: Rosquilla -> Persona -> Persona
-- comer rosquilla (nombre, peso) = (nombre, peso + (rosquilla * 2))
comer rosquilla = sumarPeso (rosquilla * 2)

tomarBirra :: Persona -> Persona
-- tomarBirra (nombre, peso) rosquilla = (nombre, peso + 2)
tomarBirra = sumarPeso 2


comerMucho persona rosquillas = foldr comer persona rosquillas


-- PRIMITIVAS
sumarPeso cant (nombre, peso) = (nombre, peso + cant)