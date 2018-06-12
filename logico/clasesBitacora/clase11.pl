% padreDe(Persona, Padre)
padreDe(bart, homero).
padreDe(bart, marge).
padreDe(lisa, homero).
padreDe(lisa, marge).
padreDe(maggie, homero).
padreDe(maggie, marge).
padreDe(homero, abe).
padreDe(homero, mona).
padreDe(helbert, abe).
padreDe(helbert, mona).
padreDe(marge, clancy).
padreDe(marge, jacqueline).
% padreDe(patty, clancy).
% padreDe(patty, jacqueline).
padreDe(selma, clancy).
padreDe(selma, jacqueline).
padreDe(ling, selma).

edad(bart, 10).
edad(lisa, 8).
edad(maggie, 2).
edad(marge, 38).
edad(selma, 43).
edad(patty, 43).
edad(ling, 1).

padre(Alguien) :- padreDe(_, Alguien).
hijo(Alguien) :- padreDe(Alguien, _).

hermanos(Alguien, Hermano) :- 
    padreDe(Alguien, Padre),
    padreDe(Hermano, Padre),
    Alguien \= Hermano.


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
    forall(padreDe(Hijo, Alguien), esPequeño(Hijo)).

esPequeño(Alguien) :-
    edad(Alguien, Edad), 
    Edad < 10.