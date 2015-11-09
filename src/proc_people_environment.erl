-module(proc_pepole_environment).

-record(env, {daily_routines=[], normal_people=[], societal_values=[] }).
-record(routine, {age_range={0,99}, events=[]}).
-record(event, {description, outcomes=[]}).
-record(outcome, {description, personality_weights=[], impacts=[]}).

-export([new/0, get_events/3]).

new() ->
  #env{}.

get_events(#env{daily_routines=Routines}, Person, RandomSeed) ->
  Routine = get_routine_for_person(Person, Routines),
  events_from_routine(Routine, RandomSeed).

get_routine_for_person(Person, Routines) ->
  Age = proc_people_person:get_age(Person),
  find_routine_for_age(Age, Routines).

find_routine_for_age(Age, [#routine{age_range={Low,High}}=Routine | _Routines]) when
    Age >= Low andalso Age < High->
  Routine;
find_routine_for_age(Age, [_OutOfRangeRoutine | Routines]) ->
  find_routine_for_age(Age, Routines).

events_from_routine(#routine{events=Events}, Seed) ->
  {Events, Seed}.
