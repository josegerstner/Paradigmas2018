% Enunciado: https://docs.google.com/document/d/1jKOXHdqNdQWhFPIK7ic3wYzsGTHmZY6MaQKypWbnF9g

% vocaloid(Nombre)
vocaloid(megurineLuka).
vocaloid(hatsuneMiku).
vocaloid(gumi).
vocaloid(seeU).
vocaloid(kaito).

% sabeCantar(Vocaloid, Cancion).
% cancion(Nombre, Duracion).
sabeCantar(megurineLuka, cancion(nightFever, 4)).
sabeCantar(megurineLuka, cancion(foreverYoung, 5)).
sabeCantar(hatsuneMiku, cancion(tellYourWorld, 4)).
sabeCantar(gumi, cancion(foreverYoung, 4)).
sabeCantar(gumi, cancion(tellYourWorld, 5)).
sabeCantar(seeU, cancion(novemberRain, 6)).
sabeCantar(seeU, cancion(nightFever, 5)).

dura(cancion(_, Duracion), Duracion).

esNovedoso(Vocaloid) :-
    sabeCantarDosCanciones(Vocaloid),
    sabeAlgunaCancionConDuracionMayorQue(Vocaloid, 5).
esNovedoso(Vocaloid) :-
    sabeAlgunaCancionConDuracionMayorQue(Vocaloid, 10).

sabeAlgunaCancionConDuracionMayorQue(Vocaloid, Duracion) :-
    sabeCantar(Vocaloid, cancion(_, DuracionCancion)),
    DuracionCancion > Duracion.

sabeCantarDosCanciones(Vocaloid) :-
    sabeCantar(Vocaloid, Cancion1),
    sabeCantar(Vocaloid, Cancion2),
    Cancion1 \= Cancion2.

esAcelerado(Vocaloid) :-
    sabeCantar(Vocaloid, _),
    forall(sabeCantar(Vocaloid, cancion(_, Duracion)), Duracion =< 4).

esNovedosoOAcelerado(Vocaloid) :-
    esAcelerado(Vocaloid).
esNovedosoOAcelerado(Vocaloid) :-
    esNovedoso(Vocaloid).

% concierto(Nombre, Pais, CantidadFama, TipoConcierto).
concierto(mikuExpo, estadosUnidos, 2000, gigante(6)).
concierto(magicalMirai, japon, 3000, gigante(10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(novemberRain)).
concierto(mikuFest, argentina, 100, pequenio(4)).

% cumpleCondiciones(Vocaloid, Concierto)
cumpleCondiciones(hatsuneMiku, concierto(_,_,_,_)).
cumpleCondiciones(Vocaloid, concierto(_, _, _, gigante(Maximo))) :-
    esNovedosoOAcelerado(Vocaloid),
    forall(sabeCantar(Vocaloid, cancion(_, Duracion)), Duracion =< Maximo).
cumpleCondiciones(Vocaloid, concierto(_, _, _, mediano(CancionPedida))) :-
    sabeCantar(Vocaloid, cancion(Cancion, _)),
    Cancion == CancionPedida.
cumpleCondiciones(Vocaloid, concierto(_, _, _, pequenio(Minimo))) :-
    forall(sabeCantar(Vocaloid, cancion(_, Duracion)), Duracion >= Minimo).

fama(concierto(_, _, FamaConcierto, _), Fama) :-
    Fama = FamaConcierto.

% puedeParticipar(Vocaloid, Concierto).
puedeParticipar(Vocaloid, Concierto) :-
    cumpleCondiciones(Vocaloid, Concierto).

% esMasFamoso(Vocaloid).
esMasFamoso(Vocaloid) :-
    vocaloid(Vocaloid).

nivelDeFama(Vocaloid, Nivel) :-
    puedeParticipar(Vocaloid, concierto(_,_,Fama,_)),
    atom_length(Vocaloid, LargoNombre),
    Nivel is Fama * LargoNombre.


% conoce(Vocaloid, OtroVocaloid)
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).
conoce(Vocaloid, OtroVocaloid) :-
    conoce(OtroVocaloid, Vocaloid).
conoce(Vocaloid, OtroVocaloid) :-
    forall(conoce(Vocaloid, Alguien),
    conoce(OtroVocaloid, Alguien)),
    Vocaloid \= OtroVocaloid.

% -----------------------------------------------------------------------
% TESTS
% -----------------------------------------------------------------------
:- begin_tests(sabeCantar).
test(kaito_no_sabe_ninguna_cancion, fail) :-
    sabeCantar(kaito, _).
:- end_tests(sabeCantar).

:- begin_tests(esNovedoso).
test(miku_no_es_novedosa, fail) :-
    esNovedoso(hatsuneMiku).
test(megurineLuka_no_es_novedosa, fail) :-
    esNovedoso(megurineLuka).
test(gumi_no_es_novedosa, fail) :-
    esNovedoso(gumi).
test(seeU_es_novedosa, nondet) :-
    esNovedoso(seeU).
:- end_tests(esNovedoso).

:- begin_tests(esAcelerado).
test(miku_es_acelerada) :-
    esAcelerado(hatsuneMiku).
test(megurineLuka_no_es_acelerada, fail) :-
    esAcelerado(megurineLuka).
test(gumi_no_es_acelerada, fail) :-
    esAcelerado(gumi).
test(seeU_no_es_acelerada, fail) :-
    esAcelerado(seeU).
:- end_tests(esAcelerado).

:- begin_tests(cumpleCondiciones).
test(miku_siempre_cumple_condiciones, nondet) :-
    cumpleCondiciones(hatsuneMiku, concierto(mikuExpo, estadosUnidos, 2000, gigante(6))),
    cumpleCondiciones(hatsuneMiku, concierto(magicalMirai, japon, 3000, gigante(10))),
    cumpleCondiciones(hatsuneMiku, concierto(vocalektVisions, estadosUnidos, 1000, mediano(novemberRain))),
    cumpleCondiciones(hatsuneMiku, concierto(mikuFest, argentina, 100, pequenio(4))).

test(megurineLuka_no_cumple_condiciones_mikuExpo, fail) :-
    cumpleCondiciones(megurineLuka, concierto(mikuExpo, estadosUnidos, 2000, gigante(6))).
test(megurineLuka_no_cumple_condiciones_magicalMirai, fail) :-
    cumpleCondiciones(megurineLuka, concierto(magicalMirai, japon, 3000, gigante(10))).
test(megurineLuka_no_cumple_condiciones_vocalektVisions, fail) :-
    cumpleCondiciones(megurineLuka, concierto(vocalektVisions, estadosUnidos, 1000, mediano(novemberRain))).
test(megurineLuka_cumple_condiciones_mikuFest) :-
    cumpleCondiciones(megurineLuka, concierto(mikuFest, argentina, 100, pequenio(4))).

test(gumi_no_cumple_condiciones_mikuExpo, fail) :-
    cumpleCondiciones(gumi, concierto(mikuExpo, estadosUnidos, 2000, gigante(6))).
test(gumi_no_cumple_condiciones_magicalMirai, fail) :-
    cumpleCondiciones(gumi, concierto(magicalMirai, japon, 3000, gigante(10))).
test(gumi_no_cumple_condiciones_vocalektVisions, fail) :-
    cumpleCondiciones(gumi, concierto(vocalektVisions, estadosUnidos, 1000, mediano(novemberRain))).
test(gumi_cumple_condiciones_mikuFest) :-
    cumpleCondiciones(gumi, concierto(mikuFest, argentina, 100, pequenio(4))).

test(seeU_cumple_condiciones_mikuExpo, nondet) :-
    cumpleCondiciones(seeU, concierto(mikuExpo, estadosUnidos, 2000, gigante(6))).
test(seeU_cumple_condiciones_magicalMirai, nondet) :-
    cumpleCondiciones(seeU, concierto(magicalMirai, japon, 3000, gigante(10))).
test(seeU_cumple_condiciones_vocalektVisions, nondet) :-
    cumpleCondiciones(seeU, concierto(vocalektVisions, estadosUnidos, 1000, mediano(novemberRain))).
test(seeU_cumple_condiciones_mikuFest) :-
    cumpleCondiciones(seeU, concierto(mikuFest, argentina, 100, pequenio(4))).
:- end_tests(cumpleCondiciones).

% Bonus: https://www.youtube.com/watch?v=n5n7CSGPzqw