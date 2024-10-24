#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"
/*
 * Author: veteran29
 * Respawn players module logic.
 *
 * Arguments:
 * 0: Module <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

[{
    params ["_logic"];

    private _synchronizedTriggers = synchronizedObjects _logic select {_x isKindOf "EmptyDetector"};
    if (_synchronizedTriggers isEqualTo []) exitWith {
        WARNING_1("No synchronized triggers: %1",_logic);
    };

    private _side = (_logic getVariable QGVAR(applyTo)) call BIS_fnc_sideType;
    private _filter = _logic getVariable QGVAR(filter);

    private _units = allPlayers select {
        !alive _x
        && side group _x == _side
        && {[_x] call _filter}
    };

    TRACE_1("",_filter);
    INFO_2("Respawning %2 players of side %1:",_side,count _units);
    {
        diag_log text format ["    %1", name _x];
    } forEach _units;

    [QGVAR(force), nil, _units] call CBA_fnc_targetEvent;

}, _this] call CBA_fnc_directCall;
