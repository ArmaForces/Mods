#include "script_component.hpp"

if (!GVAR(loggingEnabled)) exitWith {};

if (hasInterface) then {
    GVAR(ehId) = player addEventHandler ["Hit", {
        params ["_target", "_shooter"];

        if (
            !isPlayer _shooter
            || {side group _target != side group _shooter
            || {_target isEqualTo _shooter}}
        ) exitWith {};

        [QGVAR(friendlyFire), [_target, _shooter, vehicle _shooter]] call CBA_fnc_globalEvent;
    }];
};

[QGVAR(friendlyFire), {
    params ["_victim", "_origin", "_originVehicle"];
    private _nl = toString [13, 10] + "    ";

    private _msg = if (_originVehicle isKindOf "CAManBase") then {
        [
            _nl,
            name _origin, " shot at ", name _victim, _nl,
            "Victim-Origin distance: ", _victim distance _origin
        ] joinString ""
    } else {
        private _displayName = getText (configFile >> "CfgVehicles" >> typeOf _origin >> "displayName");
        [
            _nl,
            _displayName, " shot at ", name _victim, _nl,
            "Gunner:                 ", name gunner _originVehicle, _nl,
            "Commander:              ", name commander _originVehicle, _nl,
            "Driver:                 ", name driver _originVehicle, _nl,
            "Shooter:                ", name _origin, _nl,
            "Victim-Origin distance: ", _victim distance _originVehicle
        ] joinString ""
    };

    WARNING(_msg);
}] call CBA_fnc_addEventHandler;
