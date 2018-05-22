% En nuestra agencia matrimonial ahora queremos conocer a las personas deseables.
% Desarrollar esDeseable/1, sabiendo que una persona es deseable si es compatible 
% con, por lo menos, dos personas distintas.
% Ejemplo de uso (suponiendo que Juan es deseable):
% ?- esDeseable(juan).
% true.
% Nota: asumir que existe un predicado esCompatible/2, que dice si
% una mujer es compatible con un hombre.

esDeseable(Persona) :- esCompatible(Persona, X1), esCompatible(Persona, X2), X1 \= X2.
esDeseable(Persona) :- esCompatible(X1, Persona), esCompatible(X2, Persona), X1 \= X2.