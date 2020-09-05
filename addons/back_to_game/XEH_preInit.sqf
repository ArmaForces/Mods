#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf.h"

GVAR(disconnectedPlayers) = true call CBA_fnc_createNamespace;
GVAR(savegameData) = [];
GVAR(teleport) = false; // Used as flag for teleportation agreement

ADDON = true;
