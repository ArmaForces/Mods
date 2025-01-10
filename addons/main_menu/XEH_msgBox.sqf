#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle initialization of message box. Disables auto password confirm if wrong password was provided.
 *
 * Arguments:
 * 0: RscMsgBox display [DISPLAY]
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display"];

private _ctrlText = _display displayCtrl IDC_MSGBOX_TEXT;
if (ctrlText _ctrlText != localize "STR_Msg_MP_Password") exitWith {};

INFO("Invalid server password, disabling auto confirm");

uiNamespace setVariable [QGVAR(autoConfirm), false];
