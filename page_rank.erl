
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% This implements a page rank algorithm using map-reduce
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

-module(page_rank).
-compile(export_all).

%% Use map_reduce to count word occurrences
map(Url,ok) ->
    [{Url,Body}] = dets:lookup(debug_file,Url),
    %[{Url,Body}] = dets:lookup(web,Url),
    Urls = crawl:find_urls(Url,Body),
    [{U,1} || U <- Urls].
    
reduce(Url,Ns) ->
    [{Url,lists:sum(Ns)}].
    

page_rank_seq() ->
   dets:open_file(debug_file, [{file, "debug_file.dat"}]),
   Urls = dets:foldl(fun({K,_},Keys)->[K|Keys] end,[],debug_file),
   %dets:open_file(web,[{file,"web.dat"}]),
   %Urls = dets:foldl(fun({K,_},Keys)->[K|Keys] end,[],web),
   map_reduce_seq:map_reduce_seq(fun map/2, fun reduce/2, [{Url,ok} || Url <- Urls]),
   dets:close(debug_file). 
   %dets:close(web).

page_rank_distr() ->
   dets:open_file(web,[{file,"web.dat"}]),
   Urls = dets:foldl(fun({K,_},Keys)->[K|Keys] end,[],web),
    map_reduce:map_reduce_par(fun map/2, 32, fun reduce/2, 32, [{Url,ok} || Url <- Urls]),
    dets:close(web).

