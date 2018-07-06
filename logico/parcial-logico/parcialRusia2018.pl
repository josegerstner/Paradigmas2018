% Parcial Lógico PDP - Rusia 2018
% Alumno: José Ernesto Gerstner Javid
% https://docs.google.com/document/d/1yUmRSrWemfGw_LUg4z-9TKm9-2x7mreMBxxpnptEQDg/edit

% -------------------------------------------------------------
% PUNTO 1
% -------------------------------------------------------------

% lleva(Pais, Jugador).
lleva(argentina, messi).
lleva(argentina, mascherano).
lleva(nigeria, victorMoses).
lleva(islandia, halldorsson).
lleva(croacia, livakovic).

% arquero(CantidadPenalesAtajados)
% defensor(TipoDefensor, PromedioAmarillasXPartido)
% delantero(GolesHechos, PromedioGolXPartido, Altura)

% jugador(Nombre, TipoJugador)
jugador(messi, delantero(616, 0.81, 1.7)).
jugador(mascherano, defensor(rustico, 0.2)).
jugador(mascherano, defensor(habilidoso, 0.2)).
jugador(halldorsson, arquero(0)).
jugador(victorMoses, delantero(20, 0.09, 1.77)).
jugador(livakovic, arquero(1)).

esArquero(Jugador, CantidadPenalesAtajados) :-
    jugador(Jugador, arquero(CantidadPenalesAtajados)).
esDelantero(Jugador, GolesHechos, PromedioGolXPartido, Altura) :-
    jugador(Jugador, delantero(GolesHechos, PromedioGolXPartido, Altura)).
esDefensor(Jugador, TipoDefensor, PromedioAmarillasXPartido) :-
    jugador(Jugador, defensor(TipoDefensor, PromedioAmarillasXPartido)).

:- begin_tests(lleva).
test(argentina_lleva_a_messi,
 true(Pais == argentina), true(Jugador == messi)) :-
    lleva(Pais, Jugador).
test(argentina_no_lleva_a_romero, fail) :-
    lleva(argentina, romero).
:- end_tests(lleva).

:- begin_tests(esArquero).
test(halldorsson_es_arquero,
 set(Arquero = [halldorsson, livakovic])) :-
    esArquero(Arquero, _).
:- end_tests(esArquero).

:- begin_tests(esDelantero).
test(messi_y_victor_son_delanteros,
 set(Delantero = [messi, victorMoses])) :-
    esDelantero(Delantero, _, _, _).
:- end_tests(esDelantero).

:- begin_tests(esDefensor).
test(mascherano_es_defensor,
 true(Defensor == mascherano), nondet) :-
    esDefensor(Defensor, _, _).
:- end_tests(esDefensor).

% -------------------------------------------------------------
% PUNTO 2
% -------------------------------------------------------------

tieneJugadorEstrella(Pais, Jugador) :-
    lleva(Pais, Jugador),
    jugador(Jugador, Posicion),
    esBuenaPosicion(Posicion).

esBuenaPosicion(arquero(CantidadPenalesAtajados)) :-
    CantidadPenalesAtajados >= 3.

% -------------------------------------------------------------
% PUNTO 2
% -------------------------------------------------------------

tieneJugadorEstrella(Pais, Jugador) :-
    lleva(Pais, Jugador),
    esJugadorEstrella(Jugador).

esJugadorEstrella(Jugador) :-
    esArqueroEstrella(Jugador).
esJugadorEstrella(Jugador) :-
    esDefensorEstrella(Jugador).
esJugadorEstrella(Jugador) :-
    esDelanteroEstrella(Jugador).

esArqueroEstrella(Jugador) :-
    esArquero(Jugador, CantidadPenalesAtajados),
    CantidadPenalesAtajados >= 3.

esDefensorEstrella(Jugador) :-
    esDefensor(Jugador, TipoDefensor, PromedioAmarillasXPartido),
    TipoDefensor \= rustico,
    PromedioAmarillasXPartido < 0.5.

esDelanteroEstrella(Jugador) :-
    esDelantero(Jugador, GolesHechos, PromedioGolXPartido, Altura),
    PromedioGolXPartido > 0.5,
    condicionesDelanteroEstrella(GolesHechos, Altura).

condicionesDelanteroEstrella(GolesHechos, _) :-
    GolesHechos > 100.
condicionesDelanteroEstrella(_, Altura) :-
    Altura > 1.8.

:- begin_tests(esJugadorEstrella).
test(messi_y_mascherano_son_estrellas,
 set(Jugador == [messi, mascherano])) :-
    esJugadorEstrella(Jugador).
:- end_tests(esJugadorEstrella).

:- begin_tests(tieneJugadorEstrella).
test(messi_y_mascherano_son_estrellas_en_argentina,
 true(Pais == argentina), set(Jugador == [messi, mascherano])) :-
    tieneJugadorEstrella(Pais, Jugador).
:- end_tests(tieneJugadorEstrella).

% -------------------------------------------------------------
% PUNTO 3
% -------------------------------------------------------------

esJugadorFavorito(Jugador, Pais) :-
    lleva(Pais, Jugador),
    puntosJugador(Jugador, PuntosJugador),
    forall(lleva(Pais, OtroJugador),
        (puntosJugador(OtroJugador, 
            PuntosOtroJugador), 
            PuntosJugador is 
                max(PuntosJugador, PuntosOtroJugador))).

puntosJugador(Jugador, Puntos) :-
    puntosArquero(Jugador, Puntos).
puntosJugador(Jugador, Puntos) :-
    puntosDefensor(Jugador, Puntos).
puntosJugador(Jugador, Puntos) :-
    puntosDelantero(Jugador, Puntos).

puntosArquero(Jugador, Puntos) :-
    esArquero(Jugador, Puntos).

puntosDefensor(Jugador, Puntos) :-
    esDefensor(Jugador, TipoDefensor, PromedioAmarillasXPartido),
    condicionesPuntosDefensor(TipoDefensor,
         PromedioAmarillasXPartido, Puntos).

condicionesPuntosDefensor(TipoDefensor, _, PuntosCondicionales) :-
    TipoDefensor = rustico,
    PuntosCondicionales = 30.
condicionesPuntosDefensor(TipoDefensor,
     PromedioAmarillasXPartido, PuntosCondicionales) :-
    TipoDefensor = habilidoso,
    condicionesPuntosHabilidoso(PromedioAmarillasXPartido,
         PuntosCondicionales).

condicionesPuntosHabilidoso(PromedioAmarillasXPartido, PuntosHabilidoso) :-
    PromedioAmarillasXPartido < 0.5,
    PuntosHabilidoso = 100.
condicionesPuntosHabilidoso(PromedioAmarillasXPartido, PuntosHabilidoso) :-
    PromedioAmarillasXPartido >= 0.5,
    PuntosHabilidoso = 50.

puntosDelantero(Jugador, Puntos) :-
    esDelantero(Jugador, Puntos, _, _).

:- begin_tests(esJugadorFavorito).
test(messi_es_jugador_favorito_de_argentina,
 true(Pais == argentina), true(Jugador == messi)) :-
    esJugadorFavorito(Jugador, Pais).
test(mascherano_no_es_jugador_favorito_de_argentina, fail) :-
    esJugadorFavorito(mascherano, argentina).
test(livakovic_es_jugador_favorito_de_croacia, nondet) :-
    esJugadorFavorito(livakovic, croacia).
:- end_tests(esJugadorFavorito).

:- begin_tests(puntosJugador).
test(messi_tiene_616_puntos,
 true(Jugador == messi), true(Puntos == 616)) :-
    puntosJugador(Jugador, Puntos).
:- end_tests(puntosJugador).

% -------------------------------------------------------------
% PUNTO 4a
% -------------------------------------------------------------

% contra(Local, Visitante).
contra(argentina, nigeria).
contra(argentina, islandia).
contra(nigeria, islandia).
contra(nigeria, croacia).
contra(islandia, croacia).

jueganEntreEllos(Pais, OtroPais) :-
    contra(Pais, OtroPais).
jueganEntreEllos(Pais, OtroPais) :-
    contra(OtroPais, Pais).

tieneChancesDeGanar(croacia, nigeria).
tieneChancesDeGanar(nigeria, islandia).
tieneChancesDeGanar(Pais, OtroPais) :-
    jueganEntreEllos(Pais, OtroPais),
    cumpleCondicionesGanadoras(Pais, OtroPais).

cumpleCondicionesGanadoras(Pais, OtroPais) :-
    tieneJugadorEstrella(Pais, _),
    not(tieneJugadorEstrella(OtroPais, _)).
cumpleCondicionesGanadoras(Pais, _) :-
    forall(lleva(Pais, Jugador), 
        (puntosJugador(Jugador, Puntos), Puntos > 200)).

:- begin_tests(tieneChancesDeGanar).
test(argentina_tiene_chances_contra_nigeria_e_islandia,
 set(OtroPais = [nigeria, islandia])) :-
    tieneChancesDeGanar(argentina, OtroPais).
:- end_tests(tieneChancesDeGanar).

% -------------------------------------------------------------
% PUNTO 4b
% -------------------------------------------------------------

esSuertudo(Pais) :-
    estaTranquilo(Pais, _),
    forall(contra(Pais, OtroPais), estaTranquilo(Pais, OtroPais)).

estaTranquilo(Pais, OtroPais) :-
    tieneChancesDeGanar(Pais, OtroPais).
estaTranquilo(Pais, OtroPais) :-
    tieneChancesDeGanar(Pais, TercerPais),
    estaTranquilo(TercerPais, OtroPais).

:- begin_tests(estaTranquilo).
test(nigeria_esta_tranquilo_contra_islandia,
 true(Pais == nigeria), true(OtroPais == islandia)) :-
    estaTranquilo(Pais, OtroPais).
:- end_tests(estaTranquilo).

:- begin_tests(esSuertudo).
test(argentina_y_croacia_son_suertudos_como_el_alimento_de_alf,
 set(Pais = [argentina, croacia])) :-
    esSuertudo(Pais).
:- end_tests(esSuertudo).

% -------------------------------------------------------------
% PUNTO 5
% -------------------------------------------------------------
%
% En el punto 1 usé tuplas para diferenciar los tipos de jugadores:
% jugador(Nombre, TipoJugador)
% jugador(messi, delantero(616, 0.81, 1.7)).
%
% En el punto 2 usé polimorfismo aprovechando que abrí las tuplas antes.
% Por mas que tengan una lógica diferente, se unen en un predicado:
% esJugadorEstrella(Jugador) :-
%     esArqueroEstrella(Jugador).
% esJugadorEstrella(Jugador) :-
%     esDefensorEstrella(Jugador).
% esJugadorEstrella(Jugador) :-
%     esDelanteroEstrella(Jugador).
%
% En el punto 3 uśe aritmética para saber los puntos de un jugador:
% esJugadorFavorito(Jugador, Pais) :-
%     lleva(Pais, Jugador),
%     puntosJugador(Jugador, PuntosJugador),
%     forall(lleva(Pais, OtroJugador),
%         (puntosJugador(OtroJugador, 
%             PuntosOtroJugador), 
%             PuntosJugador is 
%                 max(PuntosJugador, PuntosOtroJugador))).
%
% En el punto 4 usé recursividad para saber si dos equipos se enfrentan:
% jueganEntreEllos(Pais, OtroPais) :-
%     contra(Pais, OtroPais).
% jueganEntreEllos(Pais, OtroPais) :-
%     contra(OtroPais, Pais).
%
% En todos los puntos usé inversibilidad, negación o forall