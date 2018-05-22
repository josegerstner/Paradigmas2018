% Escribí un programa Prolog que responda consultas acerca de qué colores atraen
% a una determinada persona, de acuerdo con la siguiente información:
% A Mabel y a Ana les atrae el rosa.
% A Mara le atraen el celeste y el lila.
% A Juan le atraen todos los colores pastel.
% A todas las mujeres y a Pablo les atrae el azul.
% A los varones mayores y a Mabel les atrae el rojo.
% A todos los porteños (sin importar el sexo) y a Adrián les atrae el amarillo.
% A Ana y a Juan les atrae el naranja.
% Mabel, Mara y Pablo son porteños.
% Ana y Pablo son mayores.
% El rosa, el celeste y el lila son colores pastel.
% Codificá el predicado atraeA/2: que relaciona una persona y un color,
% cuando a la persona le atrea este color.
% Ejemplos de consulta:
% ? atraeA(mabel, rosa).
% yes

atraeA(mabel, rosa).
atraeA(ana, rosa).
atraeA(mara, celeste).
atraeA(mara, lila).
atraeA(juan, Pastel) :- pastel(Pastel).
atraeA(Mujer, azul) :- mujer(Mujer).
atraeA(pablo, azul).
atraeA(Hombre, rojo) :- hombre(Hombre), mayor(Hombre).
atraeA(mabel, rojo).
atraeA(Portenio, amarillo) :- portenio(Portenio).
atraeA(adrian, amarillo).
atraeA(ana, naranja).
atraeA(juan, naranja).
portenio(mabel).
portenio(mara).
portenio(pablo).
mayor(ana).
mayor(pablo).
pastel(rosa).
pastel(celeste).
pastel(lila).
mujer(mabel).
mujer(ana).
mujer(mara).
hombre(juan).
hombre(pablo).
hombre(adrian).