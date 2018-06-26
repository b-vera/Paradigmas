%------------------------
% relaciones basico
%-----------------------

orbita(mercurio,sol).
orbita(venus,sol).
orbita(tierra,sol).
orbita(marte,sol).
orbita(jupiter,sol).
orbita(urano,sol).
orbita(neptuno,sol).
orbita(pluton,sol).
orbita(luna,tierra).

planeta(X) :-
    orbita(X,sol).

satelite(Y) :-
    orbita(Y,X),
    planeta(X).

%------------------------
% relaciones basico
%-----------------------

airbag(opel,si).
airbag(renault,si).
airbag(fiat,no).

frenosABS(renault,si).
frenosABS(fiat,no).
frenosABS(opel,no).

frenos(renault,abs).
frenos(fiat,no_abs).
frenos(opel,no_abs).

monovolumen(renault,si).
monovolumen(fiat,no).
monovolumen(opel,no).

tiene(opel,1600).
tiene(fiats,1400).

cilindradaMedia(X) :-
    cilindrada(X,1600).

cilindradaMedia(X) :-
    cilindrada(X,1400).

altaSeguridad(X,Alta) :-
    frenos(X,abs),airbag(X,si).


cilindrada(X,Media):- tiene(X,1600).
cilindrada(X,Baja):- tiene(X,1400).

%-----------------------
%recursion y matematica
%-----------------------

sumacubos(0,0) :-!.
sumacubos(N,S) :-  N_ant is N-1,
                    Ncubo is N*N*N,
                    sumacubos(N_ant,S_out),
                    S is Ncubo + S_out.

factorial(0,1) :-!.
factorial(N,S) :- N_ant is N-1,
                    factorial(N_ant,S_out),
                    S is S_out * N.

sumatoria(0,0) :-!.
sumatoria(N,Answer) :- N_ant is N-1,
                        sumatoria(N_ant,Answer_ant),
                        Answer is Answer_ant + N.

%------------------------
% listas
%------------------------

contiene([X|Y],X).
contiene([X|Y],NUM) :-
    contiene(Y,NUM).

agregar([], [ELEM], ELEM).
agregar([X|Xs], [X|Ys], ELEM):-
    agregar(Xs, Ys, ELEM).

%------------------------
% fibonacci
%------------------------

% fib(0,0).
%
% fib(s(s(X)),F):-
%   fib(X,D),
%   fib(s(X),E),
%   suma(D,E,F).
%------------------------
% union e interseccion
%------------------------

elemento(X,[X|R]).
elemento(X,[Y|R]):-
    elemento(X,R).

inters([],Q,[]).
inetrs([X|R],Q,[X|Z]):-elemento(X,Q),!,inters(R,Q,Z).
inters([X|R],Q,Z):-inters(R,Q,Z).

union([],Q,Q).
union([X|R],Q,[X|Z]):- \+ elemento(X,Q),!,union(R,Q,Z).
union([X|R],Q,Z):-union(R,Q,Z).

%------------------------
% contar elem en lista
%------------------------

cont_elem(_,[],0) :-!.
cont_elem(X,[Y|R],S):-
    (X is Y,
    cont_elem(X,R,S1),
    S is S1 + 1);
    (not(X is Y),
    cont_elem(X,R,S1),
    S is S1).

%------------------------
% elem igual al ultimo elemento de la lista
%------------------------

ultimo(X,[X]):-!.
ultimo(ELEM,[_|S]):-
    ultimo(ELEM,S).

%------------------------
% grafo
%------------------------

%hechos
camino(a,b).
camino(c,b).
camino(d,a).
camino(a,d).
camino(d,c).
camino(c,f).
camino(e,d).
camino(e,d).
camino(e,a).
camino(a,e).
camino(g,e).
camino(g,k).
camino(g,f).
camino(f,g).
camino(f,h).
camino(k,j).
camino(j,i).
camino(i,j).
camino(i,h).
camino(h,i).

ruta(X,Y):- camino(X,Y).
ruta(X,Y):- camino(X,Z), ruta(Z,Y).

prueba(a,b).
prueba(A,B):- prueba(B,A).






%------------------------
% restaurant
%------------------------

% alimento(nombre,grasas_saturadas,cant_sal,cant_calorias).
contiene(papas_fritas,si,alta,alta).
contiene(tocino,si,alta,alta).
contiene(arroz,no,baja,baja).
contiene(pure,no,baja,baja).
contiene(tomate,no,baja,baja).
contiene(lechuga,no,baja,baja).
contiene(pescado_frito,si,baja,baja).
contiene(carne_frita,si,baja,media).
contiene(carne_asada,si,baja,media).

incluye(plato,alimento1,alimento2,alimento3).

es(plato,saludable):-
    incluye(plato,alimento1,alimento2,alimento3),
    % saludable(alimento1);
    % saludable(alimento2);
    % saludable(alimento3).

es(plato,medio_saludable):-
    incluye(plato,alimento1,alimento2,alimento3).
