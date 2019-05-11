persona(aristoteles).
persona(leon).
persona(dogman).

%Alguien es mortal si Alguien es persona
mortal(Alguien) :- persona(Alguien).
%Perro es mortal si Perro es un perro
mortal(Perro) :- perro(Perro).
mortal(lassie).

%mortal(_). %Todo es mortal

perro(lassie).
perro(ayudanteDeSanta).
perro(dogman).

%Alguien es único si es persona Y es perro
unico(Alguien) :- 
    persona(Alguien),
    perro(Alguien).


programaEn(leon, js).
programaEn(nahue, js).
programaEn(nahue, haskell).


programador(Alguien) :-
    programaEn(Alguien, _),
    persona(Alguien).


%%%%%% CONSULTAS %%%%%%

% ?- persona(leon). % Leon es una persona?
% true.

% ?- persona(lucas). %Lucas es una persona?
% false.

% ?- persona(_). %Existe alguien que sea persona?
% true .

% ?- persona(Alguien). %Existe alguien que sea Persona?
% Alguien = aristoteles ;
% Alguien = leon.


% ?- mortal(leon). %Leon es mortal?
% true.

% ?- mortal(aristoteles).  %Aristoteles es mortal?
% true.

% ?- mortal(Alguno). %Existe Alguno que sea mortal?
% Alguno = aristoteles ;
% Alguno = leon ;
% Alguno = lassie.


% ?- perro(lassie). %Lassie es perro?
% true.

% ?- perro(Perro). %Existe algún perro?
% Perro = lassie ;
% Perro = ayudanteDeSanta.

% ?- perro(leon). %Leon es perro?
% false.

% ?- persona(lassie). %Lassie es persona?
% false.

% ?- persona(10). %El 10 es persona?
% false.

% ?- persona(perro). %Perro es persona?
% false.


% ?- unico(lassie). %Lassie es unico?
% false.

% ?- unico(_). %Existe alguien que sea unico?
% false.

% ?- unico(X). %Existe alguien que sea unico?
% false.

% ?- mortal(X). %Existe alguien que sea mortal?
% X = aristoteles ;
% X = leon ;
% X = lassie ;
% X = ayudanteDeSanta ;
% X = lassie.

% ?- make.

% ?- unico(X). %Existe alguien que sea unico?
% X = dogman.


% ?- programaEn(leon, haskell). %Leon programa en Haskell?
% false.

% ?- programaEn(leon, js). %Leon programa en JS?
% true.

% ?- programaEn(leon).
% ERROR: Undefined procedure: programaEn/1
% ERROR:     However, there are definitions for:
% ERROR:         programaEn/2
% false.

% ?- programaEn(leon, Lenguaje). %Existe algun lenguaje en que programa leon?
% Lenguaje = js.

% ?- programaEn(Quien, js). %Existe alguien que programe en js?
% Quien = leon ;
% Quien = nahue.

% ?- programaEn(Quien, Lenguaje). %Existe alguien que programe en algun lenguaje?
% Quien = leon,
% Lenguaje = js ;
% Quien = nahue,
% Lenguaje = js ;
% Quien = nahue,
% Lenguaje = haskell.

% ?- programaEn(Quien, _). %Existe alguien que programe en algun lenguaje?
% Quien = leon ;
% Quien = nahue ;
% Quien = nahue.

% ?- programaEn(_, _). %Existe alguien que programe en algun lenguaje?
% true ;
% true ;
% true.

% ?- programaEn(js, leon).  %JS programa en Leon?
% false.


% ?- programador(Alguien). %Existe alguien que sea programador?
% Alguien = leon ;
% false.

