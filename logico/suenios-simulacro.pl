% cree(Persona, Personaje).
cree(lucas, campanita).
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).
% diego no cree en nadie -> Universo cerrado

% suenioLoteria(gabriel).
% suenioFutbolista(lucas, arsenal).
% suenioSolista(juan, 100000).
% suenioBanda(macarena, erucaSativa, 10000).

% suenio(Persona, Suenio).
suenio(gabriel, ganarLoteria).
suenio(lucas, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(erucaSativa, 10000)).

% esAmbicioso(Persona)
esAmbicioso(Persona) :-
    suenio(Persona, Suenio),
    dificultad(Suenio, Dificultad),
    Dificultad > 10.

% dificultad(Suenio, Dificultad).
dificultad(ganarLoteria, 13).
dificultad(Futbolista, Dificultad) :-
    equipo(Futbolista, Equipo),
    dificultadPorEquipo(Equipo, Dificultad).
dificultad(Cantante, Dificultad) :-
    discos(Cantante, Discos),
    dificultad(Discos, Dificultad).

% dificultadPorEquipo(Equipo, Dificultad)
dificultadPorEquipo(Equipo, 3) :-
    equipoChico(Equipo).
dificultadPorEquipo(Equipo, 16) :-
    not(equipoChico(Equipo)).

dificultadPorDiscos(Discos, 6):-
    muchosDiscos(Discos).
dificultadPorDiscos(Discos, 4):-
    pocosDiscos(Discos).

muchosDiscos(Discos) :-
    Discos > 500000.
pocosDiscos(Discos) :-
    not(muchosDiscos(Discos)).

% discos(Cantante, Discos)
discos(cantante(Discos), Discos).
discos(cantante(_,Discos), Discos).

% equipoChico(Equipo).
equipoChico(arsenal).
equipoChico(aldosivi).

equipo(futbolista(Equipo), Equipo).

% tieneQuimica(Personaje, Persona)
tieneQuimica(Personaje, Persona) :-
    cree(Persona, Personaje),
    cumpleCondiciones(Persona, Personaje).

cumpleCondiciones(Persona, campanita) :-
    suenio(Persona, Suenio),
    dificultad(Suenio, Dificultad),
    Dificultad < 5.
cumpleCondiciones(Persona, Personaje) :-
    todosSueniosPuros(Persona),
    not(esAmbicioso(Persona)),
    Personaje \= campanita.

% todosSueniosPuros(Persona)
todosSueniosPuros(Persona) :-
    forall(suenio(Persona, Suenio), esPuro(Suenio)).

% esPuro(Suenio).
esPuro(futbolista(_)).
esPuro(Cantante) :-
    discos(Cantante, Discos),
    Discos < 200000.

amigos(campanita, reyesMagos).
amigos(campanita, conejoDePascua).
amigos(conejoDePascua, cavenaghi).

puedeAlegrar(Personaje, Persona) :-
    suenio(Persona, _),
    tieneQuimica(Personaje, Persona),
    algunoSaludablePara(Personaje).

% algunoSaludablePara(Personaje)
algunoSaludablePara(Personaje) :-
    not(enfermo(Personaje)).
algunoSaludablePara(Personaje) :-
    amigos(Personaje, Backup),
    algunoSaludablePara(Backup).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).