#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

if (hasInterface) then {
    GVAR(teleport) = false; // Used as flag for teleportation agreement
    GVAR(savegameData) = [];
};

if (isServer) then {
    GVAR(disconnectedPlayers) = createHashMap;
    GVAR(saveHandlers) = [];
};

if (EGVAR(common,aceHearing)) then {
    [
        {_this getVariable ["ACE_hasEarPlugsIn", false]},
        {
            params ["_player", "_hasEarPlugsIn"];
            _player setVariable ["ACE_hasEarPlugsIn", _hasEarPlugsIn, true];
        }
    ] call FUNC(addHandler);
};

ADDON = true;
