-- Parcial Funcional : Piratas del Caribe
-- Alumno: José Ernesto Gerstner Javid

module TestParcial
where 
import Test.Hspec
import ParcialPiratasByGRN


-- TESOROS
brujula :: Tesoro
brujula = CTesoro "Brujula" 10000
frascoDeArena :: Tesoro
frascoDeArena = CTesoro "Frasco de Arena" 0
cajitaMusical :: Tesoro
cajitaMusical = CTesoro "Cajita Musical" 1
botellaDeRon :: Tesoro
botellaDeRon = CTesoro "Botella de Ron" 25
monedaDelCofreMuerto :: Tesoro
monedaDelCofreMuerto = CTesoro "Moneda del Cofre Muerto" 100
cuchillo :: Tesoro
cuchillo = CTesoro "Cuchillo del padre" 5

-- PIRATAS
jackSparrow :: Pirata
jackSparrow = CPirata "Capitan Jack Sparrow" [brujula, frascoDeArena] [tienePalabraClave "sombrero"]
davidJones :: Pirata
davidJones = CPirata "David Jones" [cajitaMusical] [noSaquea]

-- TRIPULACIONES
perlaNegra :: Tripulacion
perlaNegra = [jackSparrow]
holandesErrante :: Tripulacion
holandesErrante = [davidJones]

-- ISLA
islaDeRon :: Isla
islaDeRon = repeat botellaDeRon

-- CIUDADANOS (POTENCIALES PIRATAS)
elizabethSwann :: Ciudadano
elizabethSwann = CCiudadano "Elizabeth Swann" [monedaDelCofreMuerto]
willTurner :: Ciudadano
willTurner = CCiudadano "Will Turner" [cuchillo]

luffyCiudadano = CCiudadano "Luffy no pirate" [sombreroDePaja]

-- CIUDAD
portRoyal :: Ciudad
portRoyal = [luffyCiudadano,elizabethSwann, willTurner]



-- Conocer el estado del Perla Negra después de
-- Saquear Port Royal.
perlaNegraSaqueaPortRoyal :: Tripulacion
perlaNegraSaqueaPortRoyal = saquearCiudad portRoyal perlaNegra
-- Agregar a Will y Elizabeth transformados a piratas que no saquean nada.
willTurnerPirata :: Pirata
willTurnerPirata = convertirEnPirata willTurner [noSaquea]
elizabethSwannPirata :: Pirata
elizabethSwannPirata = convertirEnPirata elizabethSwann [noSaquea]
perlaNegraConWill :: Tripulacion
perlaNegraConWill = sumarPirata willTurnerPirata perlaNegra
perlaNegraConWillYLiza :: Tripulacion
perlaNegraConWillYLiza = sumarPirata elizabethSwannPirata perlaNegraConWill
-- Anclar en Isla del Ron.
perlaNegraAnclaEnIslaDeRon :: Tripulacion
perlaNegraAnclaEnIslaDeRon = anclarEnIsla islaDeRon perlaNegraConWillYLiza
-- Y, finalmente, ser atacado por el Holandés Errante.
-- perlaNegraEsAtacadoPorHolanderErrante = 


-- runTests = hspec $ do
--     describe "Las aventuras del Perla Negra(?)" $ do
--         it "El Perla Negra saquea Port Royal" 
--             $ do (saquearCiudad portRoyal perlaNegra) `shouldBe` "[CPirata {nombre = "Capitan Jack Sparrow", botin = [CTesoro {nombreTesoro = "Moneda del Cofre Muerto", valor = 100},CTesoro {nombreTesoro = "Brujula", valor = 10000}], condicionesSaqueo = [<function>]}]"


-- PRUEBAS EXTRA:
sombreroDePaja :: Tesoro
sombreroDePaja = CTesoro "sombrero de paja" 100
tresEspadas :: Tesoro
tresEspadas = CTesoro "3 espadas" 1000

luffy :: Pirata
luffy = CPirata "Monkey D. Luffy" [sombreroDePaja] [buscaTesoroMayorA10]
zoro :: Pirata
zoro = CPirata "Ronronoa Zoro" [tresEspadas] [buscaTesoroMayorA10, tienePalabraClave "cerveza"]
