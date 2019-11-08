/*
 * Author: 3Mydlo3
 * Function checks if unit has tracking device in equipment
 *
 * Arguments:
 * 0: The unit that will be checked if it has a tracking device  <OBJECT>
 *
 * Return Value:
 * 0: Has tracker <BOOL>
 *
 * Example:
 * [bob] call afm_friendly_tracker_fnc_hasTracker
 *
 * Public: No
 */

params ["_unit"];

((assignedItems _unit findIf {_unit == "ItemGPS" || {["UavTerminal", _unit] call BIS_fnc_inString}}) != -1)
