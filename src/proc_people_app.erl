-module(proc_people_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	proc_people_sup:start_link().

stop(_State) ->
	ok.
