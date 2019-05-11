% -----------------------------------------
% Las comidas
% -----------------------------------------

alimento(Alimento) :-
    proviene(Alimento, _).
alimento(Alimento) :-
    tiene(_, Alimento).

% proviene(Alimento, Producto)
proviene(pan, trigo).
proviene(jamon, cerdo).
proviene(leche, vaca).
proviene(queso, leche).
proviene(chipa, queso).

% esAnimal(Animal)
esAnimal(cerdo).
esAnimal(vaca).

derivaDe(Derivado,Alimento):-
    proviene(Derivado,Alimento).

derivaDe(Derivado,Alimento):-
    proviene(Derivado,Otro),
    derivaDe(Otro,Alimento).

esLacteo(Alimento):-
    derivaDe(Alimento,leche).

tieneGluten(Alimento):-
    derivaDe(Alimento,trigo).

derivaDeAnimal(Alimento):-
    derivaDe(Alimento,Alguno),
    esAnimal(Alguno).
    
% -----------------------------------------
% Validaciones
% esLacteo(queso).
% tieneGluten(pan).
% esDerivado(queso).
% esDerivado(jamon).

% -----------------------------------------
% La alimentacion
% -----------------------------------------

% puedeComer(Dieta, Alimento)
puedeComer(vegana, Alimento) :-
    alimento(Alimento),
    not(derivaDeAnimal(Alimento)).

puedeComer(celiaca, Alimento) :-
    alimento(Alimento),
    not(tieneGluten(Alimento)).

puedeComer(omnivora, Alimento) :-
    alimento(Alimento).

% dieta(Persona, Dieta)
dieta(analia, vegana).
dieta(benito, celiaca).
dieta(claudia, omnivora).
dieta(cerdita, omnivora).

% tiene(Plato, Producto)
tiene(sandwichDeJamonYQueso, pan).
tiene(sandwichDeJamonYQueso, jamon).
tiene(sandwichDeJamonYQueso, queso).
tiene(wokDeVegetales, pan).
tiene(wokDeVegetales, arroz).
tiene(wokDeVegetales, zanahoria).
tiene(wokDeVegetales, cebolla).
tiene(wokDeVegetales, morron).

plato(sandwichDeJamonYQueso).
plato(wokDeVegetales).

% plato(Plato) :-
%     tiene(Plato, _).

quiereComer(Persona, Plato) :-
    dieta(Persona, Dieta),
    debeComer(Dieta,Plato).

% -----------------------------------------
% Validaciones
% quiereComer(analia, wokDeVegetales). % true
% quiereComer(benito, Algo). % false
% quiereComer(claudia, sandwichDeJamonYQueso). % true
% quiereComer(claudia, wokDeVegetales). % true

% -----------------------------------------
% Algo saludable
% -----------------------------------------

% esRecomendable(Dieta, Enfermedad)
esRecomendable(vegana, hipertension).
esRecomendable(vegana, colesterolAlto).
esRecomendable(celiaca, intolerancteAlGluten).
esRecomendable(celiaca, obesidad).

% diagnostico(Enfermedad, Criticidad, Nivel)

% diagnostico(Persona, Diagnostico)
tieneDiagnostico(analia, diagnostico(obesidad, dePrevencion, 5)).
tieneDiagnostico(benito, diagnostico(hipertension, dePrevencion, 4)).
tieneDiagnostico(claudia, diagnostico(colesterolAlto, critico, 3)).

esPeligroso(Diagnostico) :-
    peligrosidad(Diagnostico, Peligrosidad),
    Peligrosidad >= 10.

% peligrosidad(Diagnostico, Peligrosidad)
peligrosidad(diagnostico(_, dePrevencion, Nivel), Peligrosidad) :-
    Peligrosidad is Nivel * 2.
peligrosidad(diagnostico(_, critico, Nivel), Peligrosidad) :-
    Peligrosidad is Nivel * 5.

debeComer(Dieta, Plato) :-
    plato(Plato),
    forall(tiene(Plato, Ingrediente), puedeComer(Dieta, Ingrediente)).

% no esta muy bonito. traten de no repetir logica :)
recomendar(Plato, Persona) :-
    tieneDiagnostico(Persona,Diagnostico),
    enfermedad(Diagnostico,Enfermedad),
    esRecomendable(DietaRecomendada, Enfermedad),
    debeComer(DietaRecomendada,Plato).

recomendar(Plato, Persona) :-
    tieneDiagnostico(Persona, Diagnostico),
    not(esPeligroso(Diagnostico)),
    dieta(Persona, Dieta),
    quiereComer(Dieta, Plato).

recomendar(Plato,Persona) :-
    not(tieneDiagnostico(Persona,_)),
    quiereComer(Persona,Plato).

enfermedad(diagnostico(Enfermedad,_,_) , Enfermedad).

% -----------------------------------------
% Validaciones
% recomendar(Plato, analia). % false
% recomendar(Plato, benito). % Plato = wokDeVegetales
% recomendar(Plato, claudia). % Plato = wokDeVegetales

% -----------------------------------------
% TESTS
% -----------------------------------------

:- begin_tests(esLacteo).
test(es_lacteo_queso,nondet) :-
    esLacteo(queso).
:- end_tests(esLacteo).

:- begin_tests(tieneGluten).
test(tiene_gluten_pan,nondet) :-
    tieneGluten(pan).
:- end_tests(tieneGluten).

:- begin_tests(derivaDeAnimal).
test(es_derivado_queso, nondet) :-
    derivaDeAnimal(queso).
test(es_derivado_jamon, nondet) :-
    derivaDeAnimal(jamon).
:- end_tests(derivaDeAnimal).

:- begin_tests(quiereComer).
test(analia_quiere_comer_wokDeVegetales, nondet) :-
    quiereComer(analia, wokDeVegetales).
test(benito_no_quiere_comer_nada, fail) :-
    quiereComer(benito, _).
test(claudia_quiere_comer_sandwichDeJamonYQueso, nondet) :-
    quiereComer(claudia, sandwichDeJamonYQueso).
test(claudia_quiere_comer_wokDeVegetales, nondet) :-
    quiereComer(claudia, wokDeVegetales).
:- end_tests(quiereComer).

:- begin_tests(recomendar).
test(analia_no_tiene_plato_recomendado) :-
    not(recomendar(_, analia)).
test(benito_tiene_recomendado_wokDeVegetales,
    set(Plato == [wokDeVegetales]), nondet) :-
    recomendar(Plato, benito).
test(claudia_tiene_recomendado_wokDeVegetales,
    set(Plato == [wokDeVegetales]), nondet) :-
    recomendar(Plato, claudia).
:- end_tests(recomendar).