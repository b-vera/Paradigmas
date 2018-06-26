% dominios: cadena de strings
% 	palabras = symbol

% predicados

verbo("corre").
verbo("nada").
verbo("vuela").

sustantivo("niña").
sustantivo("niño").
sustantivo("papa").
sustantivo("mama").
sustantivo("perro").
sustantivo("gato").

pronombre("el").
pronombre("la").
pronombre("los").
pronombre("las").
pronombre("ellos").
pronombre("ellas").

% meta: corroborar si palabra es oracion

% clausulas
oracion(X,Y,Z):-
	verbo(Z),
	sustantivo(Y),
	pronombre(X).
