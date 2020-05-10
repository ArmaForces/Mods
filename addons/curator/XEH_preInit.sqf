#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(curators) = [];

["ModuleCurator_F", "InitPost", {
    params ["_curator"];
    _curator addEventHandler ["CuratorObjectPlaced", {
        params ["", "_object"];
        [QGVAR(objectAdd), _object] call CBA_fnc_serverEvent;
    }];
    _curator addEventHandler ["CuratorGroupPlaced", {
        params ["", "_group"];
        [QGVAR(groupAdd), _group] call CBA_fnc_serverEvent;
    }];
}] call CBA_fnc_addClassEventHandler;

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

    // Create curator on demand
    [QGVAR(zeusAssign), {
        params ["_unit"];
        if !(isPlayer _unit) exitWith {};

        INFO_1("Assigning Zeus to '%1'", _unit);

        private _curatorModule = [_unit] call FUNC(getFreeCuratorModule);
        unassignCurator getAssignedCuratorLogic _unit;
        _unit assignCurator _curatorModule;
    }] call CBA_fnc_addEventHandler;

    // Unassign curator on demand
    [QGVAR(zeusUnassign), {
        params ["_unit"];
        if !(isPlayer _unit) exitWith {};

        INFO_1("Unassigning Zeus from '%1'", _unit);

        private _curatorModule = getAssignedCuratorLogic _unit;
        if (_curatorModule isEqualTo objNull) exitWith {};
        unassignCurator _curatorModule;
    }] call CBA_fnc_addEventHandler;
};

ADDON = true;
