#include "script_component.hpp"

if (is3DEN || !(EGVAR(common,aceFastroping))) exitWith {};

if (isServer) then {
    ["Helicopter", "init", {
        params ["_vehicle"];
        if (!GVAR(autoAdd) || {!isNumber (configOf _vehicle >> QACEGVAR(fastroping,enabled))}) exitWith {};
        _vehicle call ACEFUNC(fastroping,equipFRIES);
    }, true, ["ACE_friesBase"], true] call CBA_fnc_addClassEventHandler;
};
