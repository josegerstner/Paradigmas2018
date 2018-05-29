servidor(ps1, fila1, 1).
servidor(ps2, fila1, 2).
servidor(was1, fila2, 1).
servidor(was1_2, fila2, 4).
servidor(fs_x48, fila2, 1).

esCliente(ps1,fs_x48). % acá dice que el servidor PS1 es cliente de FS_X48
esCliente(was1,fs_x48). % acá dice que el servidor WAS1 es cliente de FS_X48

requiereAtencion(Servidor, corteDeLuz(Fila), inmediata) :-
  servidor(Servidor, Fila, _).
requiereAtencion(Servidor, rebooteo(Servidor), normal) :-
  servidor(Servidor,_,_),
  forall(esCliente(Cliente, Servidor), servidor(Cliente,_,_)).
requiereAtencion(Servidor, cuelgue(Servidor), inmediata) :-
  servidor(Servidor, _, Criticidad),
  between(1, 2, Criticidad).
requiereAtencion(Servidor, cuelgue(Servidor), normal) :-
  servidor(Servidor, _, Criticidad),
  between(3, 4, Criticidad).