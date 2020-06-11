#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle vehicle point keybind.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Key Handled <BOOL>
 *
 * Public: No
 */

if (!alive ACE_player) exitWith {false};
// Conditions: canInteract
if !([ACE_player, ACE_player, ["isNotInside", "isNotSwimming"]] call EFUNC(common,canInteractWith)) exitWith {false};

private _vehicle = vehicle ACE_player;
// make sure player is in vehicle and not in a static weapon (inverse of ACE Finger check):
if ((ACE_player == _vehicle) || {(_vehicle isKindOf "StaticWeapon")}) exitWith {false};

// Exit if run recently (run every 1 second)
if (diag_tickTime < (GVAR(lastPointTime) + 1)) exitWith {true};

GVAR(lastPointTime) = diag_tickTime;

private _pointPosASL = AGLtoASL positionCameraToWorld [0, 0, POINT_DISTANCE];

[QGVAR(pointed), [ACE_player, _pointPosASL], crew _vehicle] call CBA_fnc_targetEvent;

true // return
