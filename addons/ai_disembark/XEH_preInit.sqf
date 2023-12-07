#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"

["CAManBase", "GetOutMan", {
    _this call FUNC(onDisembark);
}] call CBA_fnc_addClassEventHandler;

["LandVehicle", "InitPost", {
    params ["_vehicle"];
    if (isAllowedCrewInImmobile _vehicle) exitWith {};
    private _allow = random 1 < GVAR(stayInImmobileChance);
    _vehicle allowCrewInImmobile [_allow, _allow];
}] call CBA_fnc_addClassEventHandler;

ADDON = true;
