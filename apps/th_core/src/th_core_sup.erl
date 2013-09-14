-module(th_core_sup).

-include_lib("th_core/include/th_core.hrl").

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(CHILD(Id, Mod, Type, Args), {Id, {Mod, start_link, Args}, permanent, 5000, Type, [Mod]}).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init([]) ->
	?L_INFO("START"),
	{ok,
		{{one_for_one, 5, 10}, [
		]}
	}.

