% ¿Qué acabamos de aprender?
% En Prolog, todas las cosas que preguntamos están implícitamente cuantificadas
% mediante un operador de existencia. Eso significa que da lo mismo si hay una sola
% o multiples formas de probar algo: a Prolog sólo le importa que exista al menos
% una prueba para responder yes.
% Veamos si queda claro: escribí un predicado sonVecinos/2
% que nos dice si dos personas distintas son vecinas;
% esto ocurre cuando viven en la misma zona
% ¡Dame una pista!
% Ojo que pide que sean personas distintas.
% Podés asegurarte de que lo sean usando el predicado infijo \=/2
% que dados dos individuos se cumple si son diferentes.

sonVecinos(Persona1, Persona2) :- viveEn(Persona1, Zona), viveEn(Persona2, Zona), Persona1 \= Persona2.