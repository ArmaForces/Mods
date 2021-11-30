#include "script_component.hpp"
/*
 * Author: veteran29
 * Inject server status panel into main menu.
 *
 * Arguments:
 * 0: Main display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define IDC_MAIN_SPOTLIGHT_GROUP_1 1020

if (uiNamespace getVariable [QGVAR(serverStatus), false]) exitWith {};
uiNamespace setVariable [QGVAR(serverStatus), true];

params ["_display"];

private _ctrlSpotlightMain = _display displayctrl IDC_MAIN_SPOTLIGHT_GROUP_1;
TRACE_1("Adding server status text",_ctrlSpotlightMain);

// get dimensions from the center spotlight
ctrlPosition _ctrlSpotlightMain params ["_x", "_y", "_w", "_h"];
_h = _h / 2.5;
_y = _y - _h;

// main container
private _ctrlGrpServerStatus = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_ctrlGrpServerStatus ctrlSetPosition [_x, _y, _w, _h];
_ctrlGrpServerStatus ctrlCommit 0;

// header
private _ctrlTextHeader = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrpServerStatus];
_ctrlTextHeader ctrlSetStructuredText parseText "<t align='center'>SERVER INFO</t>";
_ctrlTextHeader ctrlSetPosition [0, 0, _w, _h];
_ctrlTextHeader ctrlEnable false;
_ctrlTextHeader ctrlCommit 0;

// text
private _ctrlText = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrpServerStatus];
_ctrlText ctrlSetBackgroundColor [0,0,0,0.5];
_ctrlText ctrlSetPosition [0, 0, _w, _h];
_ctrlText ctrlCommit 0;

uiNamespace setVariable [QGVAR(ctrlServerStatus), _ctrlText];
[] call FUNC(updateServerStatus);

nil
