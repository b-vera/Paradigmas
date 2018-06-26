estructura(chatbot,[
            ["Hola! Bienvenido a su asistente de salud virtual, ¿Me podrias decir tu nombre? ",
                            "Bienvenido! me llaman asistente de salud virtual y tu? ¿como te llamas? ",
                            "Estas hablando con su asistente de salud virtual ¿Cual es tu nombre?"],
            [" ¿presenta usted alguna molestia o malestar?",
                              " ¿con que puedo ayudarle esta vez respecto a su salud? ",
                              " ¿que problema ha sentido ultimamente?"],
            ["Hasta luego, Cuidese y ante cualquier duda puede volver a consultar :)",
                             "Gracias por consultar y espero que te mejores :), hasta pronto",
                             "Hasta pronto! espero haber sido de gran ayuda :)!"],
            ["calor", "cansado", "mocos", "estomago", "no"],
            ["es probable que tengas fiebre, te recomiendo usar paños frios para reducir la temperatura",
                             "por lo que me cuentas puede que te falten vitaminas y minerales en tu cuerpo",
                             "por lo que me cuentas puedo decir que te encuentras con un resfriado comun, por lo que necesitas descansar, hidratarte y un tapsin en la noche",
                             "es probable que tengas gastroenteritis, asi que tendras que cuidar tu alimentacion",
                             "Me alegra haber resuelto tus dudas :D"]
            ]).

% TDA

% constructor
datos(Usuario, Mensaje, TDA) :-
    dateTimeFormat(Value),
    TDA = [Value,Usuario, Mensaje].

% funcion de pertenencia
is_dato([]).
is_dato([Head|Tail]) :-
    string(Head),
    is_dato(Tail).

% selectores
get_date_time(Datos,DateTime) :-
    nth(DateTime, 1, Datos).

get_usuario(Datos,Usuario) :-
    nth(Usuario, 2, Datos).

get_mensaje(Datos,Mensaje) :-
    nth(Mensaje, 3, Datos).

% modificadores
set_usuario(Datos,Usuario,Nuevo) :-
    get_date_time(Datos,DateTime),
    get_mensaje(Datos,Mensaje),
    Nuevo = [DateTime,Usuario,Mensaje].

set_mensaje(Datos,Mensaje,Nuevo) :-
    get_date_time(Datos,DateTime),
    get_usuario(Datos,Usuario),
    Nuevo = [DateTime,Usuario,Mensaje].

% beginDialog
beginDialog(Chatbot,InputLog,Seed,OutputLog) :-
    evaluateSeed(Seed,Out),
    Value is Out,
    estructura(Chatbot, Lista),
    L = Lista,
    nth(OutputLog2,1,L),
    LIST = OutputLog2,
    choiceMessage(LIST,Value,OutputLog3),
    datos("chatbot",OutputLog3,TDA),
    append(InputLog,TDA,OutputLog).

% endDialog
endDialog(Chatbot,InputLog,Seed,OutputLog) :-
    evaluateSeed(Seed,Out),
    Value is Out,
    estructura(Chatbot, Lista),
    L = Lista,
    nth(OutputLog2,3,L),
    LIST = OutputLog2,
    choiceMessage(LIST,Value,OutputLog3),
    datos("chatbot",OutputLog3,TDA),
    append(InputLog,TDA,OutputLog).

% sendMessage
sendMessage(Msg,Chatbot,InputLog,Seed,OutputLog) :-
    (length(InputLog,3),
    evaluateSeed(Seed,Out),
    Value is Out,
    estructura(Chatbot, Lista),
    L = Lista,
    nth(OutputLog2,2,L),
    LIST = OutputLog2,
    choiceMessage(LIST,Value,OutputLog3),
    string_concat("hola " , Msg, OutputLog4),
    string_concat(OutputLog4 , OutputLog3, OutputLog5),
    datos("usuario",Msg,TDAuser),
    append(InputLog,TDAuser,OutputLog6),
    datos("chatbot",OutputLog5,TDA),
    append(OutputLog6,TDA,OutputLog));
    (estructura(Chatbot, Lista),
    L = Lista,
    nth(OutputLog2,4,L),
    nth(OutputLog3,5,L),
    split_string(Msg," ","",OutputLog4),
    intersection(OutputLog2,OutputLog4,OutputLog5),
    nth(Word,1,OutputLog5),
    indexOf(OutputLog2, Word, Index),
    nth(Answer,Index,OutputLog3),
    datos("usuario",Msg,TDAuser),
    append(InputLog,TDAuser,OutputLog6),
    datos("chatbot",Answer,TDA),
    append(OutputLog6,TDA,OutputLog)).
    % datos("Usuario",LIST,TDA),
    % append(InputLog,TDA,OutputLog)).

% entrega la posicion del elemento
indexOf([Element|_], Element, 0):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.

% entrega el elemento en indice K
nth(X,1,[X|_]).
nth(X, K, [_|L]) :- nth(X, K1, L), K is K1 + 1.
% https://medium.com/@soniayap/prolog-find-nth-element-7589f81b89dd

% escoge mensaje segun una semilla
choiceMessage([X|_],0,X):-!.
choiceMessage([_|Xs],NUM,Out) :-
    AUX is NUM - 1,
    choiceMessage(Xs,AUX,Out).

% evalua valor de la semilla
evaluateSeed(NUM,Out) :-
    (0 is mod(NUM,3),
    Out is 0 );
    (1 is mod(NUM,3),
    Out is 1 );
    (2 is mod(NUM,3),
    Out is 2 ).

% formato hora/fecha en conjunto a string
dateTimeFormat(Out):-
        get_date_time_value(day, ValueD),
        get_date_time_value(month, ValueM),
        get_date_time_value(year, ValueY),
        get_date_time_value(hour, ValueH),
        get_date_time_value(minute, ValueMi),
        string_concat(ValueD,"/",Out1),
        string_concat(Out1,ValueM,Out2),
        string_concat(Out2,"/",Out3),
        string_concat(Out3,ValueY,Out4),
        string_concat(Out4," ",Out5),
        string_concat(Out5,ValueH,Out6),
        string_concat(Out6,":",Out7),
        string_concat(Out7,ValueMi,Out).

% obtener valores fecha/hora
get_date_time_value(Key, Value) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(Key, DateTime, Value).

logToStr(Log,StrRep) :-
    atomic_list_concat(Log," \n ",StrRep),
    write(StrRep).

test(User, Chatbot, InputLog, Seed, OutputLog):-
    beginDialog(Chatbot,InputLog,Seed,OutputLog1),
    sendMessage(User,Chatbot,OutputLog1,Seed,OutputLog2),
    sendMessage("tengo mocos",Chatbot,OutputLog2,Seed,OutputLog3),
    endDialog(Chatbot,OutputLog3,Seed,OutputLog4),
    logToStr(OutputLog4,OutputLog).
