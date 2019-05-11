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
    grupoSensante(Madre, Persona).
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
    pertenecenAlMismoGrupo(Persona1, Persona2).

seGustanMutuamente(Persona1, Persona2) :-
    leGusta(Persona1, persona(Persona2)),
    leGusta(Persona2, persona(Persona1)),
    Persona1 \= Persona2.

pertenecenAlMismoGrupo(Persona1, Persona2) :-
    grupoSensante(Madre, Persona1),
    grupoSensante(Madre, Persona2),
    Persona1 \= Persona2.

sintonizador(Gusto) :-
    leGusta(Persona, Gusto),
    forall(pertenecenAlMismoGrupo(Persona, OtraPersona), leGusta(OtraPersona, Gusto)).

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

disperso(grupo(Madre)) :-
    grupoSensante(Madre, Persona),
    viveEn(Persona, Lugar1),
    forall(pertenecenAlMismoGrupo(Persona, OtraPersona), (viveEn(OtraPersona, Lugar2), Lugar1 \= Lugar2)).
    
grupo(Madre) :-
    grupoSensante(Madre, _),
    forall(grupoSensante(_, Persona), grupoSensante(Madre, Persona)).

vivenEnDistintasZonas(Persona, Alguien) :-
    viveEn(Persona, Zona1),
    viveEn(Alguien, Zona2),
    Zona1 \= Zona2.

% -------------------------------------------------
% Punto 4
% -------------------------------------------------

% habilidad(Persona, conductor(NombreDeVehículo,CantPasajeros)).
habilidad(capheus, conductor(vanDamm, 25)).
habilidad(sun, negocios).
habilidad(sun, pelear).
habilidad(sun, coser).
habilidad(nomi, bloguera).
habilidad(nomi, delincuente(hacker)).
habilidad(kala, quimica).
habilidad(riley, dj).
habilidad(lito, actor).
habilidad(will, policia).
habilidad(wolfgang, inteligente).
habilidad(wolfgang, pelear).
habilidad(wolfgang, delincuente(ladronDeJoyas)).

habilidosa(Persona) :-
    habilidad(Persona, _),
    forall(habilidad(Persona, Habilidad), not(esMala(Habilidad))).

esMala(policia).
esMala(delincuente(_)).
esMala(conductor(_, CantPasajeros)) :-
    CantPasajeros < 20.