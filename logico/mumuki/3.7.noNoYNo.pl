% Ya estamos convencidos de que en Prolog es fácil preguntar si existe una forma de probar algo,
% ¿no?. Por ejemplo, si queremos saber si Tomás tiene auto, podemos consultar así: 
% ? tieneAuto(tomas).
% yes
% ? tieneAuto(victoria).
% no
% Pero ¿cómo hacemos para decir lo contrario? ¿Cómo hacemos para preguntar si NO
% existen pruebas de que Tomás tenga auto? Adiviná, existe un predicado not/1,
% que niega consultas. 
% Descubrilo vos mismo; probá las siguientes consultas:
% not(tieneAuto(tomas))
% not(tieneAuto(victoria))

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