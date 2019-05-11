---------------------------------
-- TYPECLASS POLIMORFISMO
---------------------------------
-- data Persona = Persona Int String deriving (Show, Eq)
-- edad :: Persona -> Int
-- edad (Persona edad _) = edad
data Persona = Persona {
    edad :: Int,
    nombre :: String
} deriving (Show, Eq)

homero = Persona 30 "Homero"
marge = Persona {
    nombre = "Marge",
    edad = 30
}

cumplirAnio :: Persona -> Persona
-- cumplirAnio (Persona edad nombre) = Persona (edad+1) nombre
cumplirAnio persona = persona { edad = edad persona + 1 }

