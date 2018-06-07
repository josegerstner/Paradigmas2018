% Clase 13
% Enunciado : https://docs.google.com/document/d/1yVpgaZI06_nL9zvN3kJnY9uJlSdhI4IWK0Mok0b0OUo/edit

% -------------------------------------------------
% Punto 1
% -------------------------------------------------

% grupoSensante(Madre, Sensante).
grupoSensante(angelica, capheus).
grupoSensante(angelica, sun).
grupoSensante(angelica, nomi).
grupoSensante(angelica, kala).
grupoSensante(angelica, riley).
grupoSensante(angelica, lito).
grupoSensante(angelica, will).
grupoSensante(angelica, wolfgang).

madre(angelica).
sensante(Sensante) :-
    grupoSensante(_, Sensante).

conectadoCon(Persona, Madre) :-
    grupoSensante(Madre, Sensante).
conectadoCon(Persona, OtraPersona) :-
    grupoSensante(Madre, Persona),
    grupoSensante(Madre, OtraPersona).
conectadoCon(jonas, angelica).
conectadoCon(srWhispers, Miron) :-
    loVioALosOjos(Miron).

loVioALosOjos(jonas).
loVioALosOjos(angelica).


% -------------------------------------------------
% Punto 2
% -------------------------------------------------

leGusta(capheus, actor(jeanClaudeVanDamme)).
leGusta(capheus, cancion(whatsUp)).
leGusta(sun, deporte(kickboxing)).
leGusta(sun, cancion(whatsUp)).
leGusta(nomi, persona(amanita)).
leGusta(nomi, cancion(whatsUp)).
leGusta(kala, persona(wolfgang)).
leGusta(kala, cancion(whatsUp)).
leGusta(riley, persona(will)).
leGusta(riley, cancion(whatsUp)).
leGusta(lito, persona(hernando)).
leGusta(lito, cancion(whatsUp)).
leGusta(will, cancion(whatsUp)).
leGusta(wolfgang, persona(kala)).
leGusta(wolfgang, cancion(whatsUp)).

parejaSensante(Persona1, Persona2) :-
    seGustanMutuamente(Persona1, Persona2),

seGustanMutuamente(Persona1, Persona2) :-
    leGusta(Persona1, Persona2),
    leGusta(Persona2, Persona1).

sintonizador(Persona) :-
    leGusta(Alguien),
    grupoSensante(_, Alguien).

% -------------------------------------------------
% Punto 3
% -------------------------------------------------

viveEn(capheus, nairobi).
viveEn(sun, seul).
viveEn(nomi, sanFrancisco).
viveEn(kala, mumbai).
viveEn(riley, londres).
viveEn(lito, mexicoDF).
viveEn(will, chicago).
viveEn(wolfgang, berlin).

disperso(Grupo) :-
    forall(grupoSensante(Madre, Persona), )

grupo(Grupo) :-
    

vivenEnDistintasZonas(Persona, Alguien) :-
    viveEn(Persona, Zona1),
    viveEn(Alguien, Zona2),
    Zona1 \= Zona2.

% -------------------------------------------------
% Punto 4
% -------------------------------------------------