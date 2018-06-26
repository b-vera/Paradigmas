perro(hachi).
perro(duque).
perro(loco).
perro(papa).
perro(peepe).
perro(pkas).
perro(asjdjad).

gato(juan).
gato(ito).
gato(ñoño).
gato(prosdja).

feliz(lala).
feliz(lele).
feliz(lili).
feliz(lolo).

baila(lala) :- feliz(lala),
	write('si baila lala').

customer(gino,palacios,23000).
customer(bastian,vera,23345).

get_customers_bal(Fname, Lname) :-
	customer(Fname, Lname, Bal),
	write(Fname), tab(1),
	format('~w owes us $~2f ~n',[Lname,Bal]).

% \+ (alice = albert).
% not equal = \+ o \=




