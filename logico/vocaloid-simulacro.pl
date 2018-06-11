% vocaloid(Nombre)
vocaloid(megurineLuka).
vocaloid(hatsuneMiku).
vocaloid(gumi).
vocaloid(seeU).
vocaloid(kaito).

% sabeCantar(Vocaloid, Cancion).
% cancion(Nombre, Duracion).
sabeCantar(megurineLuka, cancion(nightFever, 4)).
sabeCantar(megurineLuka, cancion(foreverYoung, 5)).
sabeCantar(hatsuneMiku, cancion(tellYourWorld, 4)).
sabeCantar(gumi, cancion(foreverYoung, 4)).
sabeCantar(gumi, cancion(tellYourWorld, 5)).
sabeCantar(seeU, cancion(novemberRain, 6)).
sabeCantar(seeU, cancion(nightFever, 5)).

dura(cancion(_, Duracion), Duracion).

esNovedoso(Vocaloid) :-
    sabeCantarDosCanciones(Vocaloid),
    sabeAlgunaCancionConDuracionMayorQue(Vocaloid, 5).
esNovedoso(Vocaloid) :-
    sabeAlgunaCancionConDuracionMayorQue(Vocaloid, 10).

sabeAlgunaCancionConDuracionMayorQue(Vocaloid, Duracion) :-
    sabeCantar(Vocaloid, cancion(_, DuracionCancion)),
    DuracionCancion > Duracion.

sabeCantarDosCanciones(Vocaloid) :-
    sabeCantar(Vocaloid, Cancion1),
    sabeCantar(Vocaloid, Cancion2),
    Cancion1 \= Cancion2.

esAcelerado(Vocaloid) :-
    sabeCantar(Vocaloid, _),
    forall(sabeCantar(Vocaloid, cancion(_, Duracion)), Duracion =< 4).

% concierto(Nombre, Pais, CantidadFama, TipoConcierto).
concierto(MikuExpo, EEUU, 2000, gigante(6)).
% gigante(DuracionCancion)
% gigante del cual se sabe la duración maxima por canción. 
% El cantante no puede saber canciones mas largas que dicho valor y, 
% además, tiene que ser novedoso o acelerado.
condicionGigante(Vocaloid) :-
    

% Miku Expo, es un concierto gigante que se va a realizar en Estados Unidos, 
% le brinda 2000 de fama al vocaloid que pueda participar en él y el tiempo 
% maximo por canción es de 6 minutos.	
% Magical Mirai, se realizará en Japón y también es gigante, pero da una fama
% de 3000 y el tiempo maximo por canción es de 10 minutos.	
% Vocalekt Visions, se realizará en Estados Unidos y es mediano brinda 1000 de
% fama y exige que el vocaloid sepa novemberRain.	
% Miku Fest, se hará en Argentina y es un concierto pequeño que solo da 100 de
% fama al vocaloid que participe en él, con la condición de que sepa una o mas
% canciones de mas de 4 minutos.
