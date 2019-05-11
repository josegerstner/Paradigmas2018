% Parece que el not/1 es fácil de usar, ¿no?
% Pongamos a prueba lo que acabamos de aprender:
% Escribí un predicado loLleva/2, que relaciona a dos personas cuando
% la primera puede llevar a la segunda; esto se da cuando son vecinos,
% la primera tiene auto y la segunda no.

loLleva(Persona1, Persona2) :-
  sonVecinos(Persona1, Persona2),
  tieneAuto(Persona1),
  not(tieneAuto(Persona2)).

% Momento ahí. ¿Notaste algo extraño en el predicado not? ¿Qué toma por parametro?
% ¡No es un número, no es un átomo, no es un avión! ¡Es una consulta!
% Por extraño que parezca, not/1, en el paradigma lógico se trata de un predicado
% de orden superior: es un predicado que toma consultas (y no simplemente individuos)
% por parámetro.


% Biblioteca:
viveEn(mariano, avellaneda).
viveEn(fede, avellaneda).
viveEn(victoria, versalles).
viveEn(rodrigo, villaBallester).
viveEn(tomas, nuniez).

quedaEn(utn, almagro).
quedaEn(utn, villaLugano).
quedaEn(exactas, nuniez).
quedaEn(river, nuniez).
quedaEn(racing, avellaneda). 
quedaEn(montoto, palermo).
quedaEn(montoto, nuniez).
quedaEn(montoto, avellaneda).

tieneAuto(tomas).
tieneAuto(fede). 

llegaFacil(batman, _).
llegaFacil(Persona, _) :-
 tieneAuto(Persona).
llegaFacil(Persona, Destino) :-
  viveEn(Persona, Zona),
  quedaEn(Destino, Zona).

destinosProximos(Destino, OtroDestino) :-
   quedaEn(Destino, Zona),
   quedaEn(OtroDestino, Zona).

sonVecinos(UnaPersona, OtraPersona) :-
    UnaPersona \= OtraPersona,
    viveEn(UnaPersona, Zona), 
    viveEn(OtraPersona, Zona).