% Queremos ayudar a una agencia matrimonial a armar parejas. La agencia tiene estas reglas:
% Las mujeres melancólicas son compatibles con los varones serenos.
% Las mujeres decididas son compatibles con los varones reflexivos.
% Las mujeres soñadoras son compatibles con los varones decididos.
% Desarrollá esCompatible/2: que relaciona a una mujer y un hombre cuando son compatibles.
% ?- esCompatible(maria,juan).
% yes.
% Asumí que ya existe en la base de conocimiento hechos de la forma
% sereno/1, decidido/1, melancolico/1, soniador/1, reflexivo/1, hombre/1 y mujer/1.

esCompatible(Mujer, Hombre) :- melancolico(Mujer), mujer(Mujer), sereno(Hombre), hombre(Hombre).
esCompatible(Mujer, Hombre) :- decidido(Mujer), mujer(Mujer), reflexivo(Hombre), hombre(Hombre).
esCompatible(Mujer, Hombre) :- soniador(Mujer), mujer(Mujer), decidido(Hombre), hombre(Hombre).