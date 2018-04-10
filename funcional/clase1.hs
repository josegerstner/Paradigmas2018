doble n = n * cantRuedasBici

triple n = n * 3


cantRuedasBici :: Int
cantRuedasBici = 2

esMayor :: Int -> Bool
esMayor edad = edad > 18

-- se pueden poner funciones partidas (guardas)
modulo :: Int -> Int
modulo n 
    |esPositivo n = n
    |otherwise = -n

esPositivo :: Int -> Bool
esPositivo n = n > 0

nroMes num
    |num == 1 = "enero"
    |num == 1 = "febrero"
    |otherwise = "mal"

esDivisible numero1 numero2 = mod numero1 numero2