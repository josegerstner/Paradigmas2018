data Mascota = CMascota {
    nombre :: String,
    edad :: Int,
    saludo :: Saludo
} --deriving (Show, Eq)

instance Show Mascota where
    show = nombre

instance Eq Mascota where
    (==) unaMascota otraMascota = nombre unaMascota == nombre otraMascota

kalif = CMascota {
    nombre = "Kalif",
    edad = 14,
    saludo = ladrar
}

menta = CMascota "Menta" 1 ladrar

type Saludo = String -> String

ladrar :: Saludo
ladrar nombre = "Guau " ++ nombre ++ " guau"