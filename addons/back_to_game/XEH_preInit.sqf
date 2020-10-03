#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf"

if (hasInterface) then {
    GVAR(teleport) = false; // Used as flag for teleportation agreement
    GVAR(savegameData) = [];
};

if (isServer) then {
    GVAR(disconnectedPlayers) = true call CBA_fnc_createNamespace;
GVAR(savegameData) = [];
};

ADDON = true;
