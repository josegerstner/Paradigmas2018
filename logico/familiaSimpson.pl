% ----------------------------
% Clase 11 - PDP 2018
% ----------------------------

% saber:
% quien es el padre de una persona
% hermanos de una persona

% padre(Persona)
padre(Alguien) :- padreDe(_, Alguien).
hijo(Alguien) :- padreDe(Alguien, _).

% padreDe(Hijo, Padre).
padreDe(bart, homero).
padreDe(bart, marge).
padreDe(lisa, homero).
padreDe(lisa, marge).
padreDe(maggie, homero).
padreDe(maggie, marge).
padreDe(homero, abraham).
padreDe(homero, mona).
padreDe(herbert, abraham).
padreDe(herbert, mona).
padreDe(marge, clancy).
padreDe(marge, jaqueline).
% padreDe(patty, clancy).
% padreDe(patty, jaqueline).
padreDe(selma, clancy).
padreDe(selma, jaqueline).
padreDe(ling, selma).

% totalmente inversible
hermanos(Alguien, Hermano) :-
    padreDe(Alguien, Padre), % Unificacion Alguien Hermano
    padreDe(Hermano, Padre),
    Alguien \= Hermano.

% inversible pero no tanto
% between(1,10,N). %true
% between(1,Max,4). %rompe
% between(Min,10,4). %rompe

tranquilo(Alguien) :-
    persona(Alguien),
    not(padre(Alguien)).

persona(Alguien) :- padre(Alguien).
persona(Alguien) :- hijo(Alguien).

abueloCompleto(Abuelo) :-
    padre(Abuelo),
    forall(padreDe(Padre, Abuelo), padre(Padre)).

abueloDeTodos(Abuelo) :-
    padre(Abuelo),
    forall(padre(Padre), padreDe(Padre, Abuelo)).

estaLoco(Alguien) :-
    padre(Alguien),
    forall(padreDe(Hijo, Alguien),esPequenio(Hijo)).
estaLoco(leo).

esPequenio(Alguien) :-
    edad(Alguien, Edad),
    Edad < 10.

edad(bart, 10).
edad(lisa, 8).
edad(maggie, 2).
edad(ling, 1).