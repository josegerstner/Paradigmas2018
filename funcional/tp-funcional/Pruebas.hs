---------------------------------------------------
-- Pruebas.hs
-- Este archivo contiene el runTests

module Pruebas
where 
import Test.Hspec
import Funcional

------------------------------------------------------------------------------------
-- MODELADO
------------------------------------------------------------------------------------
bart = Participante {
    nombre = "Bart",
    padre = "Homero",
    fuerza = 25,
    precisionP = 60,
    palos = [putter,madera],
    puntosParticipante = 0
}

todd = Participante {
    nombre = "Todd",
    padre = "Ned",
    fuerza = 15,
    precisionP = 80,
    palos = [putter,hierro3,hierro5],
    puntosParticipante = 0
}

rafa = Participante {
    nombre = "Rafa",
    padre = "Clancy",
    fuerza = 10,
    precisionP = 1,
    palos = [putter],
    puntosParticipante = 0
}

hierroN :: Hierro
hierroN n = hierro n
hierro1 = hierro 1
hierro2 = hierro 2
hierro3 = hierro 3
hierro4 = hierro 4
hierro5 = hierro 5
hierro6 = hierro 6
hierro7 = hierro 7
hierro8 = hierro 8
hierro9 = hierro 9
hierro10 = hierro 10


tiroBart = Tiro {
    velocidad = 10,
    precision = 120,
    altura = 0,
    efecto= esHabilidoso bart,
    puntosTiro = 0
}

tiroTodd = Tiro {
    velocidad = 100,
    precision = 80,
    altura = 5,
    efecto = esHabilidoso todd,
    puntosTiro = 0
}

tiroRafa = Tiro {
    velocidad = 70,
    precision = 0,
    altura = 49,
    efecto = esHabilidoso rafa,
    puntosTiro = 0
}

bartAtraviesaTunel = Tiro {
    velocidad = 20,
    precision = 100,
    altura = 0,
    efecto = esHabilidoso bart,
    puntosTiro = 1
}

bartQuedaEnHoyo = Tiro {
    velocidad = 0,
    precision = 0,
    altura = 0,
    efecto = False,
    puntosTiro = 1
}

tiroToddHierro7 = hierro 7 todd

laguna2Metros :: Obstaculo
laguna2Metros = laguna 2

tiroConEfecto = Tiro {
    velocidad = 0,
    precision = 100,
    altura = 0,
    efecto = True,
    puntosTiro = 0
}

tiroConVelocidadYPrecision100 = Tiro {
    velocidad = 100,
    precision = 100,
    altura = 0,
    efecto = False,
    puntosTiro = 0
}

torneoEntrenamiento :: Torneo
torneoEntrenamiento = Torneo {
    participantes = [bart, rafa],
    recorridos = [primerRecorrido, segundoRecorrido, tercerRecorrido]
}

torneoFinDeSemana :: Torneo
torneoFinDeSemana = Torneo {
    participantes=[bart, todd],
    recorridos = [primerRecorrido, segundoRecorrido, tercerRecorrido]
}

torneoChivo = Torneo {
    participantes=[rafa, todd, bart],
    recorridos = [primerRecorrido, segundoRecorrido]
}

primerRecorrido :: Recorrido
primerRecorrido = Recorrido {
    obstaculos = [hoyo]
}
segundoRecorrido :: Recorrido
segundoRecorrido = Recorrido {
    obstaculos = [tunelConRampa,molino,hoyo]
}
tercerRecorrido :: Recorrido
tercerRecorrido = Recorrido{
    obstaculos = [laguna3Metros,molino,hoyo]
}

laguna3Metros :: Obstaculo
laguna3Metros = laguna 3
------------------------------------------------------------------------------------
-- CORRER TESTS
------------------------------------------------------------------------------------
runTests = hspec $ do
    describe "Tiros" $ do
        --------------------------------------
        -- TESTS DE LA PRIMERA PARTE
        --------------------------------------
        it "1) Bart golpea con un palo putter y produce un tiro con Velocidad: 10 Precisión: 120 Altura: 0" 
            $ do (efectuarTiro putter bart) `shouldBe` tiroBart
        it "2) Todd golpea un palo de madera y produce un tiro v100 p70 a5" 
            $ do (efectuarTiro madera todd) `shouldBe` tiroTodd
        it "3) Rafa golpea con un palo de hierro n 7 producte tiro v70 p0 a49" 
            $ do (efectuarTiro (hierro 7) rafa ) `shouldBe` tiroRafa
        it "4) Tiro de Bart no atraviesa el tunel con rampita y queda en v20 p100 a0"
            $do  atravesarObstaculo tiroBart tunelConRampa `shouldBe` bartAtraviesaTunel
        it "5) Tiro de Bart queda en el Hoyo"
            $do  atravesarObstaculo tiroBart hoyo `shouldBe` bartQuedaEnHoyo        
        it "6) Tiro de Todd con Hierro 7 atraviesa Laguna 2 metros"
            $do  superaLaguna tiroToddHierro7 `shouldBe` True
        --------------------------------------
        -- TESTS DE LA SEGUNDA PARTE
        --------------------------------------
        it "7) Tiro de precisión 100, sin velocidad y con efecto puede atravesar el hoyo"
            $do  superaHoyo tiroConEfecto `shouldBe` True
        it "8) Tiro de precisión 100, sin velocidad y con efecto puede atravesar el molino"
            $do  superaMolino tiroConEfecto `shouldBe` True
        it "9) Tiro de precisión 100, velocidad 100 y sin efecto puede atravesar el molino"
            $do  superaMolino tiroConVelocidadYPrecision100 `shouldBe` True
        it "10) Bart gana 2 puntos en el primer recorrido: entra en el hoyo y pasa el recorrido completo"
            $do  puntosTiro (elegirPalo bart primerRecorrido) `shouldBe` 2
        it "11) Bart gana 0 puntos en el tercer recorrido: ya que no logra atravesar la laguna"
            $do  puntosTiro (elegirPalo bart tercerRecorrido) `shouldBe` 0
        it "12) Los padres de los jugadores que no ganaron en el torneo de entrenamiento es Clancy, ya que Bart gana"
            $do  padresPerdedores torneoEntrenamiento `shouldBe` ["Clancy"]
        it "13) Los padres de los jugadores que no ganaron en el torneo de fin de semana son Homero y Ned, ya que empatan"
            $do  padresPerdedores torneoFinDeSemana `shouldBe` ["Ned", "Homero"]
