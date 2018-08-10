-module(crawl_to_file).
-import(lists, [flatlength/1]).
-import(dets, [open_file/2, close/1, insert/2] ).
-compile(export_all).

%This module is build to process the result from module(crawl) and keep the encapsulation of module(crawl). Input is crawl:crawl(Url, D). E.g. Url = "http://www.hh.se", D = 3. Or Result = crawl:crawl(Url, D), crawl_to_file:file_output(Result).

file_output(Result) ->
    A = lists:flatlength(Result),
   dets:open_file(web, [{file, "web.dat"}]),
    if  A == 0 ->
	    io:format("Invalid input!~nIt is an empty list.~n");
        A == 1 ->
	    dets:insert(web, [Element || Element <- Result]);
        A > 1 ->
	    dets:insert(web, [Element || Element  <- Result])
    end,
    file:close(web).

crawl_to_file(Url, Depth) ->
    file_output(crawl:crawl(Url, Depth)).

