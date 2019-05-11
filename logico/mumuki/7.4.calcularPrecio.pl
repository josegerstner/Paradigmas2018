% Ejercicio 4:  calcularPrecio
% En la casa de bebidas ahora queremos saber el precio de venta de un producto, 
% que depende del costo de la bebida, y de a quíen se la vendemos.
% Las ventas se realizan a comerciantes y a particulares. Para los comerciantes, 
% el cálculo del precio es así:
%     a las aguas se les recarga un 25%.
%     a las gaseosas no se les recarga nada
%     a las bebidas alcoholicas se les recarga un 30%
% Y para los particulares, el cálculo del precio es así:
%     a las aguas minerales se les recarga un 30%
%     a las gaseosas se les recarga un 40%
%     a las bebidas alcohólicas nacionales se les recarga un 60%.
%     a las bebidas alcohólicas importadas se les recarga un 70%.
% Desarrollar el predicado calcularPrecio/3 que relaciona a un cliente, una bebida y 
% un precio de venta. Ejemplo de uso:
%     calcularPrecio(luisa, trapiche, Precio).
%     Precio = ...
% Nota: Considerar que los siguientes predicados ya se encuentran definidos:
%     esImportada/1, esNacional/1
%     esAgua/1, esGaseosa/1
%     esAlcoholica/1
%     costo/2: que relaciona a una bebida con su costo
%     esParticular/1, esComerciante/1
%  ¡Dame una pista!
% Notar que el cálculo de la forma siempre está basado en obtener un recargo sobre el 
% costo original. Para evitar repetición de lógica, se sugiere definir y usar 
% convenientemente un predicado recargo/3, que relacione al cliente, bebida y recargo.

costo(agua,2).
costo(coca,4).
esComerciante(distribuidor).
esParticular(pepe).
esAgua(agua).
esGaseosa(coca).
esAlcoholica(vino).
esNacional(quilmes).
esImportada(heineken).

calcularPrecio(Cliente, Bebida, PrecioVenta) :-
  costo(Bebida, Precio),
  recargo(Cliente, Bebida, Recargo),
  PrecioVenta is Precio + Recargo.

recargo(Cliente, Bebida, Recargo) :-
  esComerciante(Cliente),
  costo(Bebida, Precio),
  esAgua(Bebida),
  Recargo is Precio * 0.25.
recargo(Cliente, Bebida, Recargo) :-
  esComerciante(Cliente),
  costo(Bebida, Precio),
  esGaseosa(Bebida),
  Recargo is 0 + 0.
recargo(Cliente, Bebida, Recargo) :-
  esComerciante(Cliente),
  costo(Bebida, Precio),
  esAlcoholica(Bebida),
  Recargo is Precio * 0.3.
recargo(Cliente, Bebida, Recargo) :-
  esParticular(Cliente),
  costo(Bebida, Precio),
  esAgua(Bebida),
  Recargo is Precio * 0.3.
recargo(Cliente, Bebida, Recargo) :-
  esParticular(Cliente),
  costo(Bebida, Precio),
  esGaseosa(Bebida),
  Recargo is Precio * 0.4.
recargo(Cliente, Bebida, Recargo) :-
  esParticular(Cliente),
  costo(Bebida, Precio),
  esNacional(Bebida),
  Recargo is Precio * 0.6.
recargo(Cliente, Bebida, Recargo) :-
  esParticular(Cliente),
  costo(Bebida, Precio),
  esImportada(Bebida),
  Recargo is Precio * 0.7.