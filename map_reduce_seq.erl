%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
%% This is a very simple implementation of map-reduce, in both
%% sequential and parallel versions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
-module(map_reduce_seq).
-compile(export_all).

%% Map Reduce Sequential
%% We begin with a simple sequential implementation, just to define
%% the semantics of map-reduce.
%% The input is a collection of key-value pairs. The map function maps
%% each key value pair to a list of key-value pairs. The reduce
%% function is then applied to each key and list of corresponding
%% values, and generates in turn a list of key-value pairs. These are
%% the result.

map_reduce_seq(Map,Reduce,Input) ->
    Mapped = [{K2,V2} || {K,V} <- Input, {K2,V2} <- Map(K,V)],
    reduce_seq(Reduce,Mapped).
    
reduce_seq(Reduce,KVs) ->
    [KV || {K,Vs} <- group(lists:sort(KVs)), KV <- Reduce(K,Vs)].
             
group([]) -> [];
group([{K,V}|Rest]) -> group(K,[V],Rest).
    
group(K,Vs,[{K,V}|Rest]) -> group(K,[V|Vs],Rest);
group(K,Vs,Rest) -> [{K,lists:reverse(Vs)}|group(Rest)].

