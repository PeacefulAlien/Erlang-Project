-module(exe_time_crawl).
-import(crawl, [crawl/2]).
-compile(export_all).

%exe_time/1 is a function to mearsure runtime of crawl:crawl/2 on a give Url and Depth. It takes 2xVar for argument.E.g. exe_time_crawl:exe_time("http://www.hh.se", 3).  

exe_time(Url, Depth) ->
    Start_time = os:timestamp(),
    crawl:crawl(Url, Depth),
    Exe_time = 0.000001 * timer:now_diff(os:timestamp(), Start_time),
    io:fwrite("Run Time of Crawl on Url:'~s' for Depth:'~w' is ~.2f s.~n",[Url, Depth, Exe_time] ).
 

