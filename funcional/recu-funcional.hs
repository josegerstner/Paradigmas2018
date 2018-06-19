-- Parcialito Orden Superior: https://docs.google.com/document/d/1ivsGLt1eeeeD6UDJP03-wFS30_zHKWMDnr91k-pd2P0/edit#


-- Punto 1
-- Resolver la función find’ que encuentra el primer elemento que cumple una condición. No se puede resolver con recursividad.
-- Si ningún elemento cumple la condición dejar que falle.
find' :: (a -> Bool) -> [a] -> a
find' func = head . filter func
-- *Main> find' even [41..339]
-- 42

-- Punto 2
-- Aprovechar la función find’ para aplicarla a este dominio.
data Politico = Politico {
    proyectosPresentados :: [String],
    sueldo :: Float,
    edad :: Int
} deriving Show

politicos = [
    Politico ["ser libres", "libre estacionamiento coches politicos", 
       "ley no fumar", "ley 19182"] 20000 81,
    Politico ["tratar de reconquistar luchas sociales"] 10000 63,
    Politico ["tolerancia 100 para delitos"] 15500 49 ]

-- Queremos hacer una consulta para encontrar:
-- un político joven (menos de 50 años)
-- find' ((<50).edad) politicos

-- alguno que haya presentado más de 3 proyectos
-- find' ((>3).length.proyectosPresentados) politicos

-- alguno que haya presentado algún proyecto que tenga más de 3 palabras
-- find' (any (((>3).length.words)) . proyectosPresentados) politicos

-- No queremos que genere funciones, sino que aproveche find' y
-- desde la consola resuelva los tres requerimientos.


-- Tip: para el punto c puede utilizar la función words del Prelude
-- *Main> words "Todos aqui reunidos mancomunadamente"
-- ["Todos","aqui","reunidos","mancomunadamente"]