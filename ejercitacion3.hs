esMultiploDe numero1 numero2 = mod numero1 numero2 == 0

esBisiesto anio = esMultiploDe400 anio || (esMultiploDe4 anio && noEsMultiploDe100 anio)

esMultiploDe4 anio = esMultiploDe anio 4
esMultiploDe400 anio = esMultiploDe anio 400
noEsMultiploDe100 anio =  not (esMultiploDe anio 100)

-- dispersion :: Int Int Int -> Int
dispersion num1 num2 num3 = (maxTres num1 num2 num3) - (minTres num1 num2 num3)

maxTres num1 num2 num3 = max num1 (max num2 num3)
minTres num1 num2 num3 = min num1 (min num2 num3)

pesoPino altura = altura*300 - (altura-3)*100
esPesoUtil peso = esPesoMin peso && esPesoMax peso
esPesoMin peso = peso >=400 
esPesoMax peso = peso <=1000