%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% This implements a page rank algorithm using map-reduce
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

-module(page_rank_seq).
-compile(export_all).

%% Use map_reduce to count word occurrences
map(Url,ok) ->
    [{Url,Body}] = dets:lookup(web,Url),
    Urls = crawl:find_urls(Url,Body),
    %%func map's output, 'Urls' is a list of Url-occurence tuples
    [{U,1} || U <- Urls].
    
reduce(Url,Ns) ->
    [{Url,lists:sum(Ns)}].
    

page_rank_seq() ->
   dets:open_file(web,[{file,"web.dat"}]),
   Urls = dets:foldl(fun({K,_},Keys)->[K|Keys] end,[],web),
   %%map_reduce_seq/3 = map_reduce_seq(Map, Reduce, Input). 
   %%'Map' and 'Reduce' are functions, 'Input' is a list of tuples, 
   %%in this case, [{Url, ok} [{Url,ok} || Url <- Urls].
   map_reduce_seq:map_reduce_seq(fun map/2, fun reduce/2, [{Url,ok} || Url <- Urls]),
   dets:close(web, [{file, "web.dat"}].

