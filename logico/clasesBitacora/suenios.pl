% cree(Persona, Personaje).
cree(gabriel, campanita).
cree(lucas, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, campanita).
cree(macarena, magocapria).
cree(macarena, reyesMagos).
% Diego no cree en nadie -> Universo cerrado

% suenioLoteria(gabriel).
% suenioFutbolista(lucas, arsenal).
% suenioSolista(juan, 100000).
% suenioBanda(macarena, erucaSativa, 10000).

% suenio(Persona, Suenio).
suenio(gabriel, ganarLoteria).
suenio(lucas, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(juan, cantante(losPiojos, 500000)).
suenio(macarena, cantante(erucaSativa, 10000)).

% esAmbicioso(Persona).
esAmbicioso(Persona) :-
    dificultadPorSuenio(Persona, Dificultad),
    Dificultad > 10.

dificultadPorSuenio(Persona, Dificultad) :-
    suenio(Persona, Suenio),
    dificultad(Suenio, Dificultad).

% dificultad(Suenio, Dificultad).
dificultad(ganarLoteria, 13).

dificultad(Cantante, Dificultad) :-
    discos(Cantante, Discos),
    dificultadPorDiscos(Discos, Dificultad).

dificultad(Futbolista, Dificultad) :-
    equipo(Futbolista, Equipo),
    dificultadPorEquipo(Equipo, Dificultad).

% discos(Cantante, Discos).
discos(cantante(Discos), Discos).
discos(cantante(_, Discos), Discos).

dificultadPorDiscos(Discos, 6) :-
    muchosDiscos(Discos).

dificultadPorDiscos(Discos, 4) :-
    pocosDiscos(Discos).

muchosDiscos(Discos) :-
    Discos > 500000.

pocosDiscos(Discos) :-
    not(muchosDiscos(Discos)).

% equipoChico(Equipo).
equipoChico(arsenal).
equipoChico(aldosivi).

% equipo(Futbolista, Equipo)
equipo(futbolista(Equipo), Equipo).

dificultadPorEquipo(Equipo, 3) :-
    equipoChico(Equipo).

dificultadPorEquipo(Equipo, 16) :-
    not(equipoChico(Equipo)).


tieneQuimica(Personaje, Persona) :-
    cree(Persona, Personaje),
    cumpleCondiciones(Persona, Personaje).

cumpleCondiciones(Persona, campanita) :-
    dificultadPorSuenio(Persona, Dificultad),
    Dificultad < 5.

cumpleCondiciones(Persona, Personaje) :-
    Personaje \= campanita,
    todosSueniosPuros(Persona),
    not(esAmbicioso(Persona)).

todosSueniosPuros(Persona) :-
    forall(suenio(Persona, Suenio), esPuro(Suenio)).

% esPuro(Suenio).
esPuro(futbolista(_)).
esPuro(Cantante) :-
    discos(Cantante, Discos),
    Discos < 200000.


amiges(campanita, reyesMagos).
% amiges(reyesMagos, campanita).
amiges(campanita, conejoDePascua).
amiges(conejoDePascua, cavenaghi).

puedeAlegrar(Personaje, Persona) :-
    suenio(Persona, _),
    tieneQuimica(Personaje, Persona),
    algunoSaludablePara(Personaje).

algunoSaludablePara(Personaje) :-
    amiges(Personaje, Backup),
    algunoSaludablePara(Backup).

algunoSaludablePara(Personaje) :-
    not(enfermo(Personaje)).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).