#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afm_main_fnc_example
 *
 * Public: No
 */

params ["_display"];

private _ctrlText = _display displayCtrl IDC_MSGBOX_TEXT;
if (ctrlText _ctrlText != localize "STR_Msg_MP_Password") exitWith {};

INFO("Invalid server password, disabling auto confirm");

uiNamespace setVariable [QGVAR(autoConfirm), false];
