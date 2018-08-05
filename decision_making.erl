-module(decision_making).
-import(math, [exp/1, pow/2]).
-export([if_01/1, case_01/2, case_02/2]).

if_01(GuardVar) ->
    if 
	GuardVar > 0 ->
	    io:format("It is a positive value.~n");
	GuardVar < 0 ->
	    io:format("it is a negative value.~n");
	GuardVar == 0 ->
	    io:format("The value is 0.~n")
    end.

case_01(ExprVar, GuardVar) when GuardVar >= 0 ->
    case ExprVar of
	1 ->
	    GuardVar * 10;
	2 ->
	    GuardVar * 100;
	3 ->
	    GuardVar * 1000;
	Otherwise -> io:format("No Match of: ~p.~n", [Otherwise]),
		     {error, "The case if not matching to 1, 2 or 3."}
    end;
case_01(ExprVar, GuardVar)when GuardVar < 0 ->
    io:format("The second input variable can not be minus!~n").

case_02(ExprVar, GuardVar) ->
    case ExprVar of
	1 when GuardVar >= 0 ->
	    GuardVar * GuardVar;
	1 when GuardVar < 0 ->
	    io:format("It is not a Valid Input!~n");
	2 when GuardVar > 0 ->
	    math:pow(GuardVar, 3);
	2 when GuardVar =< 0 ->
	    io:format("It is not a Valid Input!!~n");
	Otherwise -> io:format("No match to the case -> ~p.~n", [Otherwise]),
			     {error, "The case can only be 1 or 2."}
    end.

