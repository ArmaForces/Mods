#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function cancels all unfinished tasks.
 *
 * Arguments:
 * 0: Unit to cancel all his tasks (if left empty then for all playable units) <OBJECT>
 *
 * Return Value:
 * 0: Successfully canceled unit's tasks <BOOL>
 *
 * Example:
 * [player] call afm_tasks_fnc_cancelUnfinishedTasks
 *
 * Public: Yes
 */

params [["_unit", objNull]];

// Unit was given
if (!(_unit isEqualTo objNull)) exitWith {
    {
        [_x, "Canceled"] call FUNC(finishTask);
    } forEach (_unit call BIS_fnc_tasksUnit);
    true
};

// Nothing given, we need to gather all tasks for all players.
private _allTasks = [];
{
    private _tasks = _x call BIS_fnc_tasksUnit;
    _allTasks append _tasks;
} forEach allPlayers;

// Remove duplicates
_allTasks = _allTasks arrayIntersect _allTasks;

// And cancel them all.
{
    [_x, "Canceled"] call FUNC(finishTask);
} forEach _allTasks;

true
