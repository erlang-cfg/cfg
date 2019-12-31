%% Auto-generated by https://github.com/Pouriya-Jahanbakhsh/estuff
%% -----------------------------------------------------------------------------
-module(cfg_SUITE).
-author('pouriya.jahanbakhsh@gmail.com').
%% -----------------------------------------------------------------------------
%% Exports:

%% ct callbacks:
-export([init_per_suite/1
        ,end_per_suite/1
        ,all/0
        ,init_per_testcase/2
        ,end_per_testcase/2]).

%% Testcases:
-export(['1'/1
        ,'2'/1
        ,'3'/1
        ,'4'/1
        ,'5'/1
        ,'6'/1
        ,'7'/1
        ,'8'/1
        ,'9'/1
        ,'10'/1]).

%% -----------------------------------------------------------------------------
%% Records & Macros & Includes:

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

%% -----------------------------------------------------------------------------
%% ct callbacks:


all() ->
    ToInteger =
        fun
            ({Func, 1}) ->
                try
                    erlang:list_to_integer(erlang:atom_to_list(Func))
                catch
                    _:_ ->
                        0
                end;
            (_) -> % Arity > 1 | Arity == 0
                0
        end,
    % contains 0 for other functions:
    Ints = [ToInteger(X) || X <- ?MODULE:module_info(exports)],
    % 1, 2, ...
    PosInts = lists:sort([Int || Int <- Ints, Int > 0]),
    % '1', '2', ...
    [erlang:list_to_atom(erlang:integer_to_list(X)) || X <- PosInts].


init_per_suite(Cfg) ->
    application:start(sasl),
    Cfg.


end_per_suite(Cfg) ->
    application:stop(sasl),
    Cfg.


init_per_testcase(_TestCase, Cfg) ->
    Cfg.


end_per_testcase(_TestCase, _Cfg) ->
    ok.

%% -----------------------------------------------------------------------------
%% Test cases:


'1'(_) ->
    _ = lists:foreach(fun({K, _}) -> application:unset_env(cfg, K) end, application:get_all_env(cfg)),
    Cfg = [
        {host, <<"1.1.1.1">>},
        {port, 8080}
    ],
    Filters = [
        {host, {'&', [binary, {f, fun(X) -> {ok, erlang:binary_to_list(X)} end}]}, "127.0.0.1"},
        {port, {'&', [integer, {size, {min, 0}}, {size, {max, 65535}}]}}
    ],
    _ = lists:foreach(fun({K, V}) -> application:set_env(cfg, K, V) end, Cfg),
    _ = ets:new(cfg, [named_table]),
    
    ?assertMatch({ok, [{host, "1.1.1.1"}, {port, 8080}], []}, cfg:load([{env, cfg}], Filters, {ets, cfg})),
    ?assertMatch({ok, "1.1.1.1"}, cfg:get({ets, cfg}, host)),
    ?assertMatch({ok, 8080}, cfg:get({ets, cfg}, port, 9090)),
    ?assertMatch(ok, cfg:delete({ets, cfg}, port)),
    ?assertMatch(not_found, cfg:get({ets, cfg}, port)),
    ?assertMatch({ok, 9090}, cfg:get({ets, cfg}, port, 9090)),
    ?assertMatch({ok, "1.1.1.1"}, cfg:get({ets, cfg}, host)),
    ?assertMatch(ok, cfg:delete({ets, cfg})),
    ?assertMatch(not_found, cfg:get({ets, cfg}, host)),
    
    ok.


'2'(Cfg) ->
    _ = Cfg,
    ok.



'3'(Cfg) ->
    _ = Cfg,
    ok.



'4'(Cfg) ->
    _ = Cfg,
    ok.



'5'(Cfg) ->
    _ = Cfg,
    ok.



'6'(Cfg) ->
    _ = Cfg,
    ok.



'7'(Cfg) ->
    _ = Cfg,
    ok.



'8'(Cfg) ->
    _ = Cfg,
    ok.



'9'(Cfg) ->
    _ = Cfg,
    ok.



'10'(Cfg) ->
    _ = Cfg,
    ok.
