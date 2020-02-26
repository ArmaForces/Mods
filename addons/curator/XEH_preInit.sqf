#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(curators) = [];

if (isServer) then {
    ["ModuleCurator_F", "InitPost", {
        params ["_curator"];
        {
            [QGVAR(objectAdd), _x] call CBA_fnc_localEvent;
        } forEach (allUnits + vehicles);
    }] call CBA_fnc_addClassEventHandler;

    [QGVAR(objectAdd), {
        params ["_object"];
        {
            _x addCuratorEditableObjects [[_object], true];
        } forEach allCurators;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(groupAdd), {
        params ["_group"];
        {
            [QGVAR(objectAdd), _x] call CBA_fnc_localEvent;
        } forEach units _group;
    }] call CBA_fnc_addEventHandler;
};

ADDON = true;
