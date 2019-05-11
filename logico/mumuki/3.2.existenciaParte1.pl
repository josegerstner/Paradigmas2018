% Ah, pero dijimos que ibamos a usar autos para llegar a algunos lugares. Sabemos que:
% tomas y fede tienen auto.
% las personas que tienen auto llegan fácil a cualquier destino.
% batman llega fácil a cualquier destino (obvio, ¡medios de transporte le sobran!)
% Escribí los predicados tieneAuto/1 y llegaFacil/2

tieneAuto(tomas).
tieneAuto(fede).
llegaFacil(Persona,_) :- tieneAuto(Persona).
llegaFacil(batman, _).

% ¿Ves algún problema con lo que hiciste? ¿Qué pasa si preguntamos si fede llega fácil al Valhala?
% ? llegaFacil(fede, valhala).
% Si tu solución responde yes, tenemos un pequeño problema acá, porque nosotros 
% nunca dijimos que valhala sea un destino válido al que se pueda llegar con auto 
% (el que Valhala es un lugar mitológico :P).
% Por ahora, te lo dejamos para pensar. Hablaremos mas de ésto en próximas lecciones.