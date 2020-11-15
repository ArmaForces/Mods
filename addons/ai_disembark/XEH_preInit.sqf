#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

["CAManBase", "GetOutMan", {
    _this call FUNC(onDisembark);
}] call CBA_fnc_addClassEventHandler;

["LandVehicle", "InitPost", {
    (_this select 0) allowCrewInImmobile (random 1 < GVAR(stayInImmobileChance))
}] call CBA_fnc_addClassEventHandler;

ADDON = true;
