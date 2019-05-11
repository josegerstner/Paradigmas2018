% Clase 12

siguienteMal(N, Siguiente) :-
    Siguiente = N + 1.

siguienteFloat(N, Siguiente) :-
    Siguiente =:= N + 1.

siguiente(N, Siguiente) :-
    Siguiente is N + 1.