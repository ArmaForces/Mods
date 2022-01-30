#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[QACEGVAR(medical,death), {
    params ["_unit"];
    TRACE_1("Death",_unit);
    [{
        if (!alive _this) exitWith {};
        _this setDamage 1;
        [QGVAR(medicalDeathError), _this] call CBA_fnc_globalEvent;
    }, _unit, 1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

GVAR(enabled) = true;
[QGVAR(medicalDeathError), {
    if (hasInterface && (!call BIS_fnc_isDebugConsoleAllowed || {!GVAR(enabled)})) exitWith {};
    params ["_unit"];
    private _msg = format ["Unit not killed after entering Dead state: %1", _unit];
    _msg call CBA_fnc_notify;
    ERROR(_msg);
}] call CBA_fnc_addEventHandler;

ADDON = true;
