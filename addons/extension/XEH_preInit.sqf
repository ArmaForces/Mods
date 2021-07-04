#include "script_component.hpp"
ADDON = false;

if (!isServer) exitWith {};

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(enabled) = EXT callExtension "setup" == "true";
GVAR(handlers) = createHashMap;

addMissionEventHandler ["ExtensionCallback", {
    params ["_name", "_function", "_data"];

    // TRACE_3("Extension callback",_name,_function,_data);

    if (_name == EXT_LOG) exitWith {
        LOG_SYS(_function,_data);
    };
    if (_name != EXT) exitWith {};

    _data call (GVAR(handlers) get _function);
}];


ADDON = true;
