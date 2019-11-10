#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function returns apropriate marker for given group.
 *
 * Arguments:
 * 0: Group to find marker for <GROUP>
 *
 * Return Value:
 * 0: Marker type <STRING>
 *
 * Example:
 * [group bob] call afm_friendly_tracker_fnc_getGroupMarkerType
 *
 * Public: No
 */

params ["_group"];

private _leader = leader _group;
private _vehicle = objectParent _leader;
private _side = side _leader;

private _prefix = ["b", "o", "n"] select ((["WEST", "EAST", "GUER"] find str _side) max 0);

private _type = ["motor_inf", "inf"] select (_leader == _vehicle);

format ["%1_%2", _prefix, _type];
