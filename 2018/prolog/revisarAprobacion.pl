catedra(juan, 1).
catedra(luciano, 6.5).
catedra(cristobal, 7).
catedra(felipe, 4.5).
catedra(romina, 3.9).
catedra(francisco, 2.5).
catedra(katherine, 5.5).

laboratorio(juan, 1).
laboratorio(luciano, 2.5).
laboratorio(cristobal, 7).
laboratorio(felipe, 5.3).
laboratorio(romina, 2.8).
laboratorio(francisco, 3.4).
laboratorio(katherine, 6.6).

calculoAprobacion(Numero) :-
	(Numero > 4).

aprobo_catedra(Persona) :-
	catedra(Persona,Valor),
	calculoAprobacion(Valor).

aprobo_laboratorio(Persona) :-
	laboratorio(Persona,Valor),
	calculoAprobacion(Valor).

reprobo_todo(Persona) :-
	not(aprobo_catedra(Persona)),
	not(aprobo_laboratorio(Persona)).

aprobo_asignatura(Persona) :-
	aprobo_catedra(Persona),
	aprobo_laboratorio(Persona).

guarda_la_nota(Persona) :-
	aprobo_laboratorio(Persona),not(aprobo_catedra(Persona));
	aprobo_catedra(Persona) , not(aprobo_laboratorio(Persona)).
