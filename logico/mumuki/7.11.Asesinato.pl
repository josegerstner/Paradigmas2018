% Ejercicio 11:  asesinato
% Escribí un programa Prolog que resuelva el siguiente problema lógico:
% Un asesino siempre odia a su víctima y nunca es mas rico que ella. 
% El asesino de la tía Agatha, además, vive en la mansión Dreadbury.
% Tía Agatha, el carnicero y Charles son las únicas personas que viven en la mansion.
% Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
% Agatha odia a todos los que viven en la mansión, excepto al carnicero.
% Quien no es odiado por el carnicero y vive en la mansión, es mas rico que tía Agatha
% El carnicero odia a las mismas personas que odia tía Agatha.
% Al programa le tengo que poder preguntar quién es el asesino de la tía Agatha, y 
% tiene que brindar una sola respuesta, de la siguiente forma:
% ? asesino(agatha, Asesino).
% Asesino = ???
%  ¡Dame una pista!
% No agregues información que no se provea en el enunciado. Al asumir ciertas cosas que 
% no se explicitan podés llegar a un resultado distinto del esperado.

asesino(Victima, Asesino) :-
    odia(Asesino, Victima),
    not(esMasRico(Asesino, Victima)),
    viveEn(Asesino, mansionDreadbury).

viveEn(agatha, mansionDreadbury).
viveEn(carnicero, mansionDreadbury).
viveEn(charles, mansionDreadbury).

odia(agatha, Persona) :-
    viveEn(Persona, mansionDreadbury),
    Persona \= carnicero.
odia(charles, Persona) :-
    viveEn(Persona, mansionDreadbury),
    not(odia(agatha, Persona)).
odia(carnicero, Persona) :-
    odia(agatha, Persona).

esMasRico(Persona, agatha) :-
    viveEn(Persona, mansionDreadbury),
    not(odia(carnicero, Persona)).