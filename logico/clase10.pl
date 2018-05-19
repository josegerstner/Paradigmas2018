% predicado(individuo)
persona(aristoteles).
persona(leon).
persona(dogman).

% Alguien es mortal si Alguien es persona
mortal(Alguien) :- persona(Alguien).
% Perro es mortal si Perro es un perro
mortal(Perro) :- perro(Perro).
% definir muchas cláusulas es una forma de hacer un OR

mortal(lassie).


% mortal(_) TODO es mortal

perro(lassie).
perro(ayudanteDeSanta).
perro(dogman).

unico(Alguien) :-
    persona(Alguien),
    perro(Alguien).

programaEn(leon, js).
programaEn(nahue, js).
programaEn(nahue, haskell).

programaEn(Alguien, Lenguaje) :- programaEn(Lenguaje, Alguien).

%programaEn(Quien, Lenguaje). %Existe alguien que programe en algun lenguaje?
%programaEn(_,_).
%programaEn(Quien, _). %Existe alguien que programe

programador(Alguien) :-
    programaEn(Alguien, _),
    persona(Alguien).