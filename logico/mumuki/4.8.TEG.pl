ocupaContinente(Player, Continente) :-
  not((ocupa(Pais1,Player,_), 
  ocupa(Pais2,Player2,_), 
  Player \= Player2,  
  estaEn(Continente,Pais1),  
  estaEn(Continente,Pais2), 
  Pais1 \= Pais2)).

estaPeleado(Continente) :-
  ocupa(_,Player,_),
  forall(ocupa(Pais,Player,_),
  estaEn(Continente,Pais)).

seAtrinchero(Player) :-
  forall(ocupa(Pais1, Player,_),
    (ocupa(Pais2, Player,_),
    estaEn(Continente, Pais1),
    estaEn(Continente, Pais2),
    Pais1 \= Pais2)).

% biblioteca
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).
