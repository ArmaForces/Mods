#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function reads all properties of all properties of given config (excludes subclasses)
 * and saves to namespace for easier access
 * (and ability to easily create default value if property doesn't exits)
 *
 * Arguments:
 * 0: Config to read from <CONFIG>
 * 1: Namespace to save data to <CBA_NAMESPACE>
 *
 * Return Value:
 * 0: Filled/created namespace <CBA_NAMESPACE>
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_config", ["_namespace", objNull]];

if (_namespace isEqualTo objNull) then {
    _namespace = call CBA_fnc_createNamespace;
};

// Get item properties
// Read config values for found properties
{
    private _value = switch (true) do {
        case (isNumber _x): {getNumber _x};
        case (isText _x): {getText _x};
        case (isArray _x): {getArray _x};
    };
    _namespace setVariable [configName _x, _value];
} forEach (configProperties [_config, "!(isClass _x)", true]);

_namespace
