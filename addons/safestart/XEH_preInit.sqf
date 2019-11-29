#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(aceSafemode)= isClass (configFile >> "CfgPatches" >> "ace_safemode");

#include "initSettings.sqf"

[QGVAR(enableSafety), {
    params ["_player"];

    [_player] call FUNC(lowerWeapon);

    if (GVAR(aceSafemode) && {GVAR(startLocked)}) then {
        [_player, currentWeapon _player, true] call ACEFUNC(safemode,setWeaponSafety);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(lowerWeapon), {
    params ["_unit"];

    _unit action ["WeaponOnBack", _unit];

}] call CBA_fnc_addEventHandler;

ADDON = true;
