#include "script_component.hpp"

if (isServer) then {
    [QGVAR(zeusConnected), {
        params ["_unit"];
        if !(_unit getVariable [QGVAR(isZeus), false]) exitWith {};

        private _curatorModule = [_unit] call FUNC(getFreeCuratorModule);
        _unit assignCurator _curatorModule;
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    if (player getVariable [QGVAR(isZeus), false]) then {
        [QGVAR(zeusConnected), [player]] call CBA_fnc_serverEvent;
    };
};
