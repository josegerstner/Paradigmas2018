% Ahora queremos saber si alguien está bien ubicado:
% esto ocurre cuando vive en una zona en la que están todos los
% destinos a los que quiere ir. Para eso, contamos con la nueva información de quiereIr/2:
% quiereIr(fede, racing).
% quiereIr(fede, montoto).
% quiereIr(victoria, montoto).
% quiereIr(tomas, montoto).
% quiereIr(tomas, utn).
% ¿Pero cómo podemos hacer para saber si todos los lugares a donde quiere ir están en su zona?
% ¿Se te ocure alguna forma de resolverlo, usando sólo lo que vimos hasta ahora? 
% Escribí el predicado bienUbicado/1. Asumí que ya escribimos quiereIr/2 por vos.
%  ¡Dame una pista!
% Pensá que si en una zona están todos los lugares que uno quiere, eso significa...
% que no existe ningún lugar al que quiera ir y no esté en esa zona.
% Y si las cosas se complican mucho, ¡delegá!
% Si no recordás qué predicados ya existían, revisá la biblioteca :wink:.


bienUbicado(Persona) :- 
  viveEn(Persona, Barrio),
  forall(quiereIr(Persona, Lugar), 
    quedaEn(Lugar, Barrio)).

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

loLleva(UnaPersona, OtraPersona) :-
    tieneAuto(UnaPersona),
    not(tieneAuto(OtraPersona)), 
    sonVecinos(UnaPersona, OtraPersona).

quiereIr(fede, racing).
quiereIr(fede, montoto).
quiereIr(victoria, montoto).
quiereIr(tomas, montoto).
quiereIr(tomas, utn).