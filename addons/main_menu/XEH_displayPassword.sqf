#include "script_component.hpp"
/*
 * Author: veteran29
 * Handles initialization of password display.
 *
 * Arguments:
 * 0: Server password prompt display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display"];

if !(uiNamespace getVariable [QGVAR(autoConfirm), true]) exitWith {INFO("Auto password confirm disabled")};

private _ctrlConfirm = _display displayCtrl IDC_OK;
private _ctrlPassword = _display displayCtrl IDC_PASSWORD;

if (ctrlText _ctrlPassword == "") exitWith {};

ctrlActivate _ctrlConfirm;

nil
