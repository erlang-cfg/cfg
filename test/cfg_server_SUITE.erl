%% Auto-generated by https://github.com/Pouriya-Jahanbakhsh/estuff
%% -----------------------------------------------------------------------------
-module(cfg_server_SUITE).
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
    _ = cfg_test_utils:clean_env(),
    Cfg = [
              {host, <<"1.1.1.1">>},
              {port, 8080}
          ],
    _ = lists:foreach(fun({K, V}) -> application:set_env(cfg, K, V) end, Cfg),
    ?assertMatch([_, _], application:get_all_env(cfg)),
    
    Filters = [
                  {host, {'&', [binary, binary_to_list]}, "127.0.0.1"},
                  {port, {'&', [integer, {size, {0, 65535}}]}}
              ],
    _ = ets:new(cfg, [named_table, public]),
    
    _ = erlang:process_flag(trap_exit, true),
    Result = cfg_server:start_link({local, cfg}, [{env, cfg}], Filters, {ets, cfg}, #{error_unknown_config => false, notify_tag => my_tag, delete_on_terminate => true, change_priority => true, notify => message}),
    ?assertMatch({ok, _}, Result),
   
    ?assertMatch({ok, "1.1.1.1"}, cfg:get({ets, cfg}, host)),

    ?assertMatch(ok, cfg_server:subscribe(cfg, host)),
    ?assertMatch(ok, cfg_server:subscribe(cfg, host)),
    ?assertMatch(ok, cfg_server:subscribe(cfg, port)),
    
    _ = application:set_env(cfg, host, <<"2.2.2.2">>),
    
    ?assertMatch(ok, cfg_server:reload(cfg)),
    
    ?assertMatch({ok, "2.2.2.2"}, cfg:get({ets, cfg}, host)),
    
    ?assertMatch({my_tag, {{value, "1.1.1.1"}, {value, "2.2.2.2"}}}, receive {my_tag, _}=M -> M after 1000 -> timeout end),
    
    
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
