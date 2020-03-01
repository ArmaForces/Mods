#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function reads task owners from supplied array and returns processed array.
 *
 * Arguments:
 * 0: Task owners array <ARRAY>
 *
 * Return Value:
 * 0: Processed task owners <ARRAY>
 *
 * Example:
 * [["true", "west", "bob", "rob_group"]] call afm_main_fnc_example
 *
 * Public: No
 */

params ["_taskOwnersRaw"];

private _taskOwners = [];

{
    // If "All" keyword is used just return [true]
    if (_x isEqualTo "All" || {_x isEqualTo "true"}) exitWith {_taskOwners = [true]};
    // Check if side was given
    private _side = call compile _x;
    if (!isNil "_side" && {_side in [WEST, EAST, INDEPENDENT, CIVILIAN]}) then {
        _taskOwners pushBackUnique _side;
    } else {
        // Try to reach object
        private _object = missionNamespace getVariable [_x, objNull];
        if (_object isEqualTo objNull) exitWith {};
        _taskOwners pushBackUnique _object;
    };
} forEach _taskOwnersRaw;

// Nothing eligible was found, show to everyone
if (_taskOwners isEqualTo []) exitWith {[true]};

_taskOwners
