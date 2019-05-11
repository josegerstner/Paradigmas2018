tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(belgrado,serbio).

habla(pepe,bulgaro).
habla(pepe,italiano).
habla(juancho,arabe).
habla(lucy,griego).

capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

destinoPosible(Persona, Ciudad) :-
    nivelActual(Persona, Nivel),
    tarea(Nivel, buscar(_, Ciudad)).

idiomaUtil(Persona, Idioma) :-
    destinoPosible(Persona, Ciudad),
    idioma(Ciudad, Idioma).

excelenteCompaniero(Persona, OtraPersona) :-
    idiomaUtil(Persona,_),
    habla(OtraPersona,_),
    forall(idiomaUtil(Persona, Idioma), habla(OtraPersona, Idioma)).

interesante(Nivel) :-
    tarea(Nivel,_),
    forall(tarea(Nivel, buscar(Cosa, _)), estaViva(Cosa)).
interesante(Nivel) :-
    tarea(Nivel,_),
    tarea(Nivel, buscar(_, Ciudad)), idioma(Ciudad, italiano).

estaViva(arbol).
estaViva(perro).
estaViva(flor).

complicado(Participante) :-
    forall(idiomaUtil(Participante, Idioma),
    not(habla(Participante, Idioma))).
complicado(Participante) :-
    not(nivelActual(Participante, basico)),
    capital(Participante, Capital),
    Capital < 1500.
complicado(Participante) :-
    nivelActual(Participante, basico),
    capital(Participante, Capital),
    Capital < 500.

homogeneo(Nivel) :-
    tarea(Nivel,buscar(Cosa,_)),
    forall(tarea(Nivel, buscar(OtraCosa,_)), Cosa == OtraCosa).