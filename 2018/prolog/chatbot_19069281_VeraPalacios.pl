%%  ========== Dominios ==========
%% Chatbot    = listas de listas de strings
%% InputLog   = lista de strings
%% Seed       = integer
%% OutputLog  = lista de strings
%% Msg        = string
%% Index      = integer
%% NUM        = integer

%%  ========== Predicados ==========
%% datos(Usuario, Mensaje, TDA)
%% is_dato([])
%% get_date_time(Datos,DateTime)
%% get_usuario(Datos,Usuario)
%% get_mensaje(Datos,Mensaje)
%% set_usuario(Datos,Usuario,Nuevo)
%% set_mensaje(Datos,Mensaje,Nuevo)
%% beginDialog(Chatbot,InputLog,Seed,OutputLog)
%% endDialog(Chatbot,InputLog,Seed,OutputLog)
%% sendMessage(Msg,Chatbot,InputLog,Seed,OutputLog)
%% indexOf([_|Tail], Element, Index)
%% nth(X, K, [_|L])
%% choiceMessage([_|Xs],NUM,Out)
%% evaluateSeed(NUM,Out)
%% dateTimeFormat(Out)
%% get_date_time_value(Key, Value)
%% logToStr(Log,StrRep)
%% test(User, Chatbot, InputLog, Seed, OutputLog)

%%  ========== Objetivos (Principal) ==========
%% beginDialog(Chatbot,InputLog,Seed,OutputLog)      = comenzar la conversacion con el chatbot
%% endDialog(Chatbot,InputLog,Seed,OutputLog)        = cierre de la conversacion con el chatbot
%% sendMessage(Msg,Chatbot,InputLog,Seed,OutputLog)  = desarollar la convresacion con el chatbot
%% logToStr(Log,StrRep)                              = Mostrar al usuarios de manera comoda los resultados
%% test(User, Chatbot, InputLog, Seed, OutputLog)    = Evalua usuarios preestablecidos

%%  ========== Clausulas de Horn ==========

%%  HECHOS:

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

user("user1",["me siento cansado","en la tarde me dolio el estomago","tengo mocos"]).
user("user2",["tengo demasiada calor","llego en la noche a  mi casa muy cansado","no"]).

%% REGLAS:

% TDA:

%%  ========== datos - constructor ==========
%%
%% Constructor que define el formato de los datos ingresados
%%
%% Entradas: Usuario   = nombre del usuario
%%           Mensaje   = mensaje ingresado por usuario
%%
%% Salidas:  TDA       = lista con hora/fecha, usuario y msg
%%
datos(Usuario, Mensaje, TDA) :-
    dateTimeFormat(Value),
    TDA = [Value,Usuario, Mensaje].


%%  ========== is_dato - funcion de pertenencia ==========
%%
%% Predicado encargada de la verificacion de los datos
%%
%% Entradas: [Head|Tail] = lista con elementos
%%
%% Salidas:  Booleano
%%
is_dato([]).
is_dato([Head|Tail]) :-
    string(Head),
    is_dato(Tail).


%%  ========== get_date_time - selector ==========
%%
%% selector encargado de obtener la fecha/hora
%%
%% Entradas: Datos       = lista con los datos
%%
%% Salidas:  DataTimee   = salida con la fecha/hora
%%
get_date_time(Datos,DateTime) :-
    nth(DateTime, 1, Datos).

%%  ========== get_usuario - selector ==========
%%
%% selector encargado de obtener el usuario
%%
%% Entradas: Datos       = lista con los datos
%%
%% Salidas:  Usuario     = salida con el usuario
%%
get_usuario(Datos,Usuario) :-
    nth(Usuario, 2, Datos).


%%  ========== get_mensaje - selector ==========
%%
%% selector encargado de obtener el mensaje
%%
%% Entradas: Datos       = lista con los datos
%%
%% Salidas:  Mensaje     = salida con el mensaje
%%
get_mensaje(Datos,Mensaje) :-
    nth(Mensaje, 3, Datos).


%%  ========== set_usuario - modificador ==========
%%
%% selector encargado de obtener el mensaje
%%
%% Entradas: Datos       = lista con los datos
%%           Usuario     = usuario nuevo a ingresar
%% Salidas:  Nuevo       = salida con el nuevo usuario
%%
set_usuario(Datos,Usuario,Nuevo) :-
    get_date_time(Datos,DateTime),
    get_mensaje(Datos,Mensaje),
    Nuevo = [DateTime,Usuario,Mensaje].


%%  ========== set_usuario - modificador ==========
%%
%% selector encargado de obtener el mensaje
%%
%% Entradas: Datos       = lista con los datos
%%           Mensaje     = mensaje nuevo a ingresar
%% Salidas:  Nuevo       = salida con el nuevo mensaje
%%
set_mensaje(Datos,Mensaje,Nuevo) :-
    get_date_time(Datos,DateTime),
    get_usuario(Datos,Usuario),
    Nuevo = [DateTime,Usuario,Mensaje].


%%  ========== beginDialog ==========
%%
%% predicado encargada de la inicializacion del chatbot.
%% Entrega el mensaje de bienvenida de parte del chatbot
%% de manera aleatoria segun la semilla.
%%
%% Entradas: Chatbot   = Hecho con las respuestas del Chatbot
%%           InputLog  = lista Vacia
%%           Seed      = Numero
%%
%% Salidas: OutputLog  = lista con el Log generado
%%
beginDialog(Chatbot,InputLog,Seed,OutputLog) :-
    evaluateSeed(Seed,Out),
    Value is Out,
    estructura(Chatbot, Lista),
    L = Lista,
    nth(OutputLog2,1,L),
    LIST = OutputLog2,
    choiceMessage(LIST,Value,OutputLog3),
    datos("BEGIN_DIALOG",0,ID),
    datos("chatbot",OutputLog3,TDA),
    append(InputLog,ID,OutputLog4),
    append(OutputLog4,TDA,OutputLog).


%%  ========== endDialog ==========
%%
%% predicado encargada de la Finalizacion del chatbot.
%% Entrega el mensaje de despedida de parte del chatbot
%% de manera aleatoria segun la semilla.
%% Aplica etiqueta de cierre que indica fin de conversacion.
%%
%% Entradas: Chatbot   = Hecho con las respuestas del Chatbot
%%           InputLog  = lista Vacia
%%           Seed      = Numero
%%
%% Salidas: OutputLog  = lista con el Log Modificado
%%
endDialog(Chatbot,InputLog,Seed,OutputLog) :-
    evaluateSeed(Seed,Out),
    Value is Out,
    estructura(Chatbot, Lista),
    L = Lista,
    nth(OutputLog2,3,L),
    LIST = OutputLog2,
    choiceMessage(LIST,Value,OutputLog3),
    datos("chatbot",OutputLog3,TDA),
    append(InputLog,TDA,OutputLog4),
    datos("END_DIALOG",0,ID),
    append(OutputLog4,ID,OutputLog).


%%  ========== sendMessage ==========
%%
%% predicado que recibe el mensaje ingresado por el usuario.
%% En primera insancia recibe el nombre el usuario.
%% Compara el mensaje con la base de datos en la respuestas
%% del chatbot, y en caso de encontrar una coincidencia,
%% este retorna la respectiva respuesta segun el sintoma.
%%
%% Entradas: Msg       = Mensaje ingresado por el usuario
%%           Chatbot   = Hecho con las respuestas del Chatbot
%%           InputLog  = lista Vacia
%%           Seed      = Numero
%%
%% Salidas: OutputLog  = lista con el Log Modificado
%%
sendMessage(Msg,Chatbot,InputLog,Seed,OutputLog) :-
    (length(InputLog,6),
    evaluateSeed(Seed,Out),
    Value is Out,
    estructura(Chatbot, Lista),
    L = Lista,
    nth(OutputLog2,2,L),
    LIST = OutputLog2,
    choiceMessage(LIST,Value,OutputLog3),
    string_concat("Hola " , Msg, OutputLog4),
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
    I is Index + 1,
    nth(Answer,I,OutputLog3),
    datos("usuario",Msg,TDAuser),
    append(InputLog,TDAuser,OutputLog6),
    datos("chatbot",Answer,TDA),
    append(OutputLog6,TDA,OutputLog7),
    datos("chatbot","¿Tiene alguna otra duda?",TDAQ),
    append(OutputLog7,TDAQ,OutputLog)).


%%  ========== indexOf ==========
%%
%% predicado que retorna la posicion en la que se encuentra
%% un elemento en una lista.
%%
%% Entradas: [_|Tail]  = Lista a recorrer recursivamente
%%           Element   = elemento a buscar su posicion
%%
%% Salidas:  Index     = numero con la posicion del elemento
%%
indexOf([Element|_], Element, 0):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.


%%  ========== nth ==========
%%
%% predicado que retorna el elemento de una lista segun su indice.
%% obtenida desde:
%% https://medium.com/@soniayap/prolog-find-nth-element-7589f81b89dd
%%
%% Entradas: K       = indice del elemento
%%           [_|L]   = Lista a recorrer recursivamente
%%
%% Salidas:  X       = elemento obtenido en el indice ingresado
%%
nth(X,1,[X|_]).
nth(X, K, [_|L]) :- nth(X, K1, L), K is K1 + 1.


%%  ========== choiceMessage ==========
%%
%% predicado que retorna el mensaje seleccionado dentro de una lista
%% de respuestas de nuestros chatbot.
%% Para esto se ingresa la semilla modificada como indice.
%%
%% Entradas: [_|Xs]   = Lista a recorrer recursivamente
%%           NUM      = numero de indice a buscar
%%
%% Salidas:  Out      = mensaje de respuesta seleccionado
%%
choiceMessage([X|_],0,X):-!.
choiceMessage([_|Xs],NUM,Out) :-
    AUX is NUM - 1,
    choiceMessage(Xs,AUX,Out).


%%  ========== evaluateSeed ==========
%%
%% predicado que modifica el valor de la semilla ingresada,
%% para poder elegir dentro de las respuestas quee posee
%% nuestro chatbot.
%%
%% Entradas: NUM      = numero de indice a buscar
%%
%% Salidas:  Out      = mensaje de respuesta seleccionado
%%
evaluateSeed(NUM,Out) :-
    (0 is mod(NUM,3),
    Out is 0 );
    (1 is mod(NUM,3),
    Out is 1 );
    (2 is mod(NUM,3),
    Out is 2 ).


%%  ========== dateTimeFormat ==========
%%
%% predicado que obtiene los valores para metadatos,
%% tales como dia, mes, año y la hora.
%% Posterior a esto se realiza una concatenacion de
%% estos datos.
%%
%% Salidas:  Out      = string con fecha/hora actual
%%
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


%%  ========== get_date_time_value ==========
%%
%% predicado que genera toda la informacion respecto
%% a fecha/hora.
%% obtenido desde:
%% https://stackoverflow.com/questions/22731856/how-to-get-current-system-year-in-prolog-as-a-number
%%
%% Entradas: Key      = valor el cual se desea obtener (dia,mes,etc..)
%%
%% Salidas:  value    = atomos con el nombre de lo consultado.
%%
get_date_time_value(Key, Value) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(Key, DateTime, Value).


%%  ========== logToStr ==========
%%
%% transforma el log generado durante una conversacion
%% en formato string con el motivo de realizar una facil
%% y comoda revision del funcionamiento.
%%
%% Entradas: Log       = Log de la conversacion
%%
%% Salidas:  StrRep    = string con el log Modificado
%%
logToStr(Log,StrRep) :-
    atomic_list_concat(Log," \n ",StrRep),
    write(StrRep).


%%  ========== test ==========
%%
%% predicado que genera una conversacion en base a respuestas
%% automaticas para asi ejemplificar el funcionamiento del codigo.
%%
%% Entradas: User      = listado con usuario y mensajes predeterminados
%%           Chatbot   = Hecho con las respuestas del Chatbot
%%           InputLog  = lista Vacia
%%           Seed      = Numero
%%
%% Salidas: OutputLog  = lista con el Log Modificado
%%

test(User, Chatbot, InputLog, Seed, OutputLog):-
    user(User,Msg),
    L = Msg,
    beginDialog(Chatbot,InputLog,Seed,OutputLog1),
    sendMessage(User,Chatbot,OutputLog1,Seed,OutputLog2),
    nth(Answer1,1,L),
    sendMessage(Answer1,Chatbot,OutputLog2,Seed,OutputLog3),
    nth(Answer2,2,L),
    sendMessage(Answer2,Chatbot,OutputLog3,Seed,OutputLog4),
    nth(Answer3,3,L),
    sendMessage(Answer3,Chatbot,OutputLog4,Seed,OutputLog5),
    endDialog(Chatbot,OutputLog5,Seed,OutputLog).

    %%oe napa, agarra el caea de papa

%%//won lindo
