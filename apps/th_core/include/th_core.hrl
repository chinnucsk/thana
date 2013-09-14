-ifndef(__TH_CORE_HRL__).
-define(__TH_CORE_HRL__, 1).

-include_lib("lager/include/lager.hrl").

-compile([ { parse_transform, lager_transform } ]).
-define(L_DEBUG, lager:debug).
-define(L_INFO,  lager:info).
-define(L_WARN,  lager:warning).
-define(L_ERROR, lager:error).
-define(L_ALERT, lager:alert).

-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).
-define(CHILD_ARGS(I, Type, Args), {I, {I, start_link, Args}, permanent, 5000, Type, [I]}).
-define(ID_CHILD_ARGS(I, M, Type, Args), {I, {M, start_link, Args}, permanent, 5000, Type, [M]}).

-endif.
