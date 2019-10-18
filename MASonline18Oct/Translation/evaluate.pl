%%% evaluate.pl
%%% -----------------------------------------------------------------

:- module(evaluate,[main/0,main/1,my_predicate/2]).
:- use_module(library(prologbeans)).
:- use_module(library(codesio),[read_from_codes/2]).
:- include('parser.pl').


%% Register acceptable queries and start the server (using default port)
main:-
    main(gui).

main(gui):-
    register_query(evaluate(C,P), my_predicate(C, P)),
    register_query(shutdown, shutdown_server),
    start.

main(batch):-
    register_query(evaluate(C,P), my_predicate(C, P)),
    register_query(shutdown, shutdown_server),
    register_event_listener(server_started, server_started_listener),
    register_event_listener(server_shutdown, server_shutdown_listener),
    start,
    halt.

%% converting sentence to predicate fact
my_predicate(Chars, P) :- 
		tokenize(Chars,Out),
		s(Structure,Sem,Out,[]),asserta(Sem),
		write('The fact '),write(Sem),write(' was added to the KB.'),nl, P=Sem.
    
% This will be called if we build a run-time system
user:runtime_entry(start) :-
    main(batch).

server_started_listener :-
    get_server_property(port(Port)),
    format(user_error, 'port:~w~n', [Port]),
    flush_output(user_error).

server_shutdown_listener :-
   format(user_error, '~Nevaluate.pl: Shutdown~n', []),
   flush_output(user_error).

shutdown_server :-
    shutdown(now).
