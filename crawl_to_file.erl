-module(crawl_to_file).
-import(lists, [flatlength/1, nth/2]).
-import(dets, [open_file/2, close/1, insert/2] ).
-compile(export_all).

%This module is build to process the result from module(crawl) and keep the encapsulation of module(crawl). Input is crawl:crawl(Url, D). E.g. Url = "http://www.hh.se", D = 3. Or Result = crawl:crawl(Url, D), crawl_to_file:file_output(Result).

file_output(List) ->
    A = lists:flatlength(List),
    dets:open_file(debug_file, [{file, "debug_file.dat"}]),
    %dets:open_file(web, [{file, "web.dat"}]),
    if  A == 0 ->
	    io:format("Invalid input!~nIt is an empty list.~n");
        A == 1 ->
	    io:format("2nd.~n"),
	    dets:insert(debug_file, lists:nth(1, List));
	    %dets:insert(web, lists:nth(1, List));
        A > 1 ->
	    io:format("3rd.~n"),
	    [Head | Rest] = List,
	    dets:insert(debug_file, Head),
	    %dets:insert(web, Head),
	    file_output(Rest)
    end,
    dets:close(debug_file).
    %dets:close(web).
