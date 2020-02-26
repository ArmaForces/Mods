#include "script_component.hpp"

if (isServer) then {
    [QGVAR(zeusAssign), {
        params ["_unit"];
        if !(isPlayer _unit) exitWith {};

        INFO_1("Assigning Zeus to '%1'", _unit);

        private _curatorModule = [_unit] call FUNC(getFreeCuratorModule);
        _unit assignCurator _curatorModule;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(zeusUnassign), {
        params ["_unit"];
        if !(isPlayer _unit) exitWith {};

        INFO_1("Unassigning Zeus from '%1'", _unit);

        private _curatorModule = getAssignedCuratorLogic _unit;
        if (_curatorModule isEqualTo objNull) exitWith {};
        unassignCurator (GVAR(curators) select _curatorModule);
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(objectAdd), player] call CBA_fnc_serverEvent;
};
