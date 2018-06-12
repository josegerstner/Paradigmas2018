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
concierto(Concierto) :-
    concierto(Concierto, _, _, _).
pais(Concierto, Pais) :-
    concierto(Concierto, PaisConcierto, _, _),
    Pais = PaisConcierto.
fama(Concierto, Fama) :-
    concierto(Concierto, _, FamaConcierto, _),
    Fama = FamaConcierto.
conciertoGigante(Concierto, Maximun) :-
    concierto(Concierto,_,_,gigante(Maximo)),
    Maximun = Maximo.
conciertoMediano(Concierto, CancionPedida) :-
    concierto(Concierto,_,_,mediano(Cancion)),
    Cancion = CancionPedida.
conciertoPequenio(Concierto, Minimum) :-
    concierto(Concierto,_,_,pequenio(Minimo)),
    Minimo = Minimum.

% cumpleCondiciones(Vocaloid, Concierto)
cumpleCondiciones(hatsuneMiku, _).
cumpleCondiciones(Vocaloid, Concierto) :-
    concierto(Concierto),
    esNovedosoOAcelerado(Vocaloid),
    conciertoGigante(Concierto, Maximo),
    forall(sabeCantar(Vocaloid, cancion(_, Duracion)), 
        Duracion =< Maximo).
cumpleCondiciones(Vocaloid, Concierto) :-
    concierto(Concierto),
    sabeCantar(Vocaloid, cancion(Cancion, _)),
    conciertoMediano(Concierto, CancionPedida),
    Cancion == CancionPedida.
cumpleCondiciones(Vocaloid, Concierto) :-
    concierto(Concierto),
    conciertoPequenio(Concierto, Minimo),
    forall(sabeCantar(Vocaloid, cancion(_, Duracion)), 
        Duracion >= Minimo).

% puedeParticipar(Vocaloid, Concierto).
puedeParticipar(Vocaloid, Concierto) :-
    cumpleCondiciones(Vocaloid, Concierto).

% esMasFamoso(Vocaloid).
esMasFamoso(Vocaloid) :-
    vocaloid(Vocaloid),
    maximoNivelDeFama(Vocaloid, NivelVocaloid),
    forall(vocaloid(OtroVocaloid),
        (maximoNivelDeFama(OtroVocaloid, NivelOtroVocaloid),
        NivelVocaloid is max(NivelVocaloid, NivelOtroVocaloid))).

maximoNivelDeFama(Vocaloid, Nivel) :-
    nivelDeFama(Vocaloid, Nivel),
    forall(nivelDeFama(Vocaloid, NivelVocaloid),
        Nivel is max(Nivel, NivelVocaloid)).

nivelDeFama(Vocaloid, Nivel) :-
    puedeParticipar(Vocaloid, Concierto),
    fama(Concierto, Fama),
    atom_length(Vocaloid, LargoNombre),
    Nivel is Fama * LargoNombre.

% conoce(Vocaloid, OtroVocaloid)
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

seConocen(Vocaloid, OtroVocaloid) :-
    conoce(Vocaloid, OtroVocaloid).
seConocen(Vocaloid, OtroVocaloid) :-
    conoce(OtroVocaloid, Vocaloid).
seConocen(Vocaloid, OtroVocaloid) :-
    conoce(Vocaloid, OtroVocaloidDistinto),
    seConocen(OtroVocaloidDistinto, OtroVocaloid).

esElUnico(Vocaloid, Concierto) :-
    vocaloid(Vocaloid),
    puedeParticipar(Vocaloid, Concierto),
    forall(seConocen(Vocaloid, OtroVocaloid),
        (not(puedeParticipar(OtroVocaloid, Concierto)),
        Vocaloid \= OtroVocaloid)).


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
    cumpleCondiciones(hatsuneMiku, mikuExpo),
    cumpleCondiciones(hatsuneMiku, magicalMirai),
    cumpleCondiciones(hatsuneMiku, vocalektVisions),
    cumpleCondiciones(hatsuneMiku, mikuFest).
test(megurineLuka_no_cumple_condiciones_mikuExpo, fail) :-
    cumpleCondiciones(megurineLuka, mikuExpo).
test(megurineLuka_no_cumple_condiciones_magicalMirai, fail) :-
    cumpleCondiciones(megurineLuka, magicalMirai).
test(megurineLuka_no_cumple_condiciones_vocalektVisions, fail) :-
    cumpleCondiciones(megurineLuka, vocalektVisions).
test(megurineLuka_cumple_condiciones_mikuFest) :-
    cumpleCondiciones(megurineLuka, mikuFest).
test(gumi_no_cumple_condiciones_mikuExpo, fail) :-
    cumpleCondiciones(gumi, mikuExpo).
test(gumi_no_cumple_condiciones_magicalMirai, fail) :-
    cumpleCondiciones(gumi, magicalMirai).
test(gumi_no_cumple_condiciones_vocalektVisions, fail) :-
    cumpleCondiciones(gumi, vocalektVisions).
test(gumi_cumple_condiciones_mikuFest) :-
    cumpleCondiciones(gumi, mikuFest).
test(seeU_cumple_condiciones_mikuExpo, nondet) :-
    cumpleCondiciones(seeU, mikuExpo).
test(seeU_cumple_condiciones_magicalMirai, nondet) :-
    cumpleCondiciones(seeU, magicalMirai).
test(seeU_cumple_condiciones_vocalektVisions, nondet) :-
    cumpleCondiciones(seeU, vocalektVisions).
test(seeU_cumple_condiciones_mikuFest) :-
    cumpleCondiciones(seeU, mikuFest).
:- end_tests(cumpleCondiciones).

:- begin_tests(nivelDeFama).
test(megurineLuka_tiene_nivel_de_fama_1200, true(Nivel == 1200)) :-
    nivelDeFama(megurineLuka, Nivel).
test(hatsuneMiku_tiene_los_siguientes_niveles_de_fama, set(Nivel = [22000, 33000, 11000, 1100])) :-
    nivelDeFama(hatsuneMiku, Nivel).
test(gumi_tiene_nivel_de_fama_400, true(Nivel == 400)) :-
    nivelDeFama(gumi, Nivel).
test(seeU_tiene_los_siguientes_niveles_de_fama, set(Nivel = [8000, 12000, 4000, 400])) :-
    nivelDeFama(seeU, Nivel).
:- end_tests(nivelDeFama).

:- begin_tests(esMasFamoso).
test(miku_es_la_mas_famosa, true(Vocaloid == hatsuneMiku), nondet) :-
    esMasFamoso(Vocaloid).
:- end_tests(esMasFamoso).

% Bonus: https://www.youtube.com/watch?v=n5n7CSGPzqw