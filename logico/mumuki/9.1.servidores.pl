servidor(ps1, fila1, 1).
servidor(ps2, fila1, 2).
servidor(was1, fila2, 1).
servidor(was1_2, fila2, 4).
servidor(fs_x48, fila2, 1).
esCliente(ps1,fs_x48). % aca dice que el servidor PS1 es cliente de FS_X48
esCliente(was1,fs_x48). % aca dice que el servidor WAS1 es cliente de FS_X48

requiereAtencion(Servidor, corteDeLuz(Fila), inmediata) :-
  servidor(Servidor, Fila, _).
  
requiereAtencion(Servidor, rebooteo(Server), normal) :-
  servidor(Servidor,_,_),
  Servidor == Server.
requiereAtencion(Servidor, rebooteo(Server), normal) :-
  esCliente(Servidor, Server).

requiereAtencion(Servidor, cuelgue(Server), inmediata) :-
  servidor(Servidor, _, Criticidad),
  between(1, 2, Criticidad),
  Servidor == Server.
requiereAtencion(Servidor, cuelgue(Server), normal) :-
  servidor(Servidor, _, Criticidad),
  between(3, 4, Criticidad),
  Servidor == Server.

:- begin_tests(requiereAtencion).
  test(fs_x48_requiere_atencion_normal_por_rebooteo, set(Servidor == [fs_x48, ps1, was1])) :-
    requiereAtencion(Servidor, rebooteo(fs_x48), normal).

  test(fs_x48_requiere_atencion_inmediata_por_corteDeLuz, set(Servidor == [ps1, ps2])) :-
    requiereAtencion(Servidor, corteDeLuz(fila1), inmediata).

  test(fs_x48_requiere_atencion_inmediata_por_cuelgue, set(Servidor == ps2, Tipo == inmediata), nondet) :-
    requiereAtencion(Servidor, cuelgue(ps2), Tipo).

:- end_tests(requiereAtencion).