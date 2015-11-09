-module(proc_people_generator).

-export([run/4]).

run(0, Person, _Environment, _RandomSeed) ->
  Person;
run(Days, Person, Environment, RandomSeed) ->
  {NextSeed, DailyEvents} = proc_people_environment:get_events(Environment, Person, RandomSeed),
  {NextSeed2, NextPerson} = proc_people_person:react(Person, Environment, DailyEvents, NextSeed),
  run(Days - 1, NextPerson, Environment, NextSeed2).
