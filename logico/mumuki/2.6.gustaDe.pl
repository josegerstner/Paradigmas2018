% En un grupo de amigos, sabemos que:
% Luis gusta de Nora
% Roque gusta de Ana
% Roque gusta de Nora
% Marcos gusta de Zulema
% Todos los chicos que gustan de Ana, también gustan de Zulema
% A Juan le gustan todas las chicas que le gustan a Roque
% A Juan le gusta Nuria
% A Ana no le gusta nadie
% A Zulema le gusta Ana
% Desarrollá un predicado gustaDe/2, que nos diga si una persona gusta de la otra.

gustaDe(luis, nora).
gustaDe(roque, ana).
gustaDe(roque, nora).
gustaDe(marcos, zulema).
gustaDe(Chico, zulema) :- gustaDe(Chico, ana).
gustaDe(juan, Chica) :- gustaDe(roque, Chica).
gustaDe(juan, nuria).
gustaDe(zulema, ana).