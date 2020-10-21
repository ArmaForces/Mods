#include "script_component.hpp"

if (is3DEN || !(EGVAR(common,aceFastroping))) exitWith {};

if (isServer) then {
    ["Helicopter", "init", {
        if (!GVAR(autoAdd)) exitWith {};
        _this call ACEFUNC(fastroping,equipFRIES);
    }, true, ["ACE_friesBase"], true] call CBA_fnc_addClassEventHandler;
};
