esMultiploDe uno = igualACero . rem uno
igualACero :: Int -> Bool
igualACero = (== 0)

-- esBisiesto debe usar composición... ¿Cómo?... lpm
esBisiesto :: Int -> Bool
esBisiesto anio = (esMultiploDe400 anio) || ((esMultiploDe4 anio) && (not . esMultiploDe100 anio))

esMultiploDe400 :: Int -> Bool
esMultiploDe400 anio = esMultiploDe anio 400
esMultiploDe4 :: Int -> Bool
esMultiploDe4 anio = esMultiploDe anio 4
esMultiploDe100 :: Int -> Bool
esMultiploDe100 anio = esMultiploDe anio 100