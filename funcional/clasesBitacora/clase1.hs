doble n = n * cantRuedasBici


triple n = n * 3

cantRuedasBici :: Int
cantRuedasBici = 2

esMayor :: Int -> Bool
esMayor edad = edad > 18

modulo :: Int -> Int
modulo n
    |esPositivo n = n
    |otherwise = -n

esPositivo :: Int -> Bool
esPositivo n = n > 0

nroAMes :: Int -> String
nroAMes num
    |num == 1 = "enero"
    |num == 2 = "febrero"


inicial nombre = head nombre














