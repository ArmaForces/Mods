#include "script_component.hpp"
/*
 * Author: veteran29
 * Handles initialization of multiplayer display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Display name <STRING>
 *
 * Return Value:
 * None
 *
 */

params ["_display", "_displayName"];

TRACE_2("Multiplayer display init",_display,_displayName);

// base offset values
ctrlPosition (_display displayCtrl IDC_CANCEL) params ["_baseX", "_baseY", "_offsetW", "_offsetH"];
ctrlPosition MP_PWD_BORDER_CONTROL params ["_boundX", "", "_boundW"];
private _rightBorder = _boundX + _boundW;

/*
    Create controls
*/
private _passwordInput  = _display ctrlCreate ["RscEdit", -1];
private _passwordButton = _display ctrlCreate ["RscButtonMenu", -1];
private _missionsButton = _display ctrlCreate ["RscButtonMenu", -1];

#define BUTTON_SPACING (0.1 * GUI_GRID_W)
#define BUTTON_W _offsetW
#define MP_PWD_INPUT_X (_baseX + BUTTON_W * 2 + (2 * BUTTON_SPACING))

_missionsButton ctrlSetPosition [
    _baseX + BUTTON_W + BUTTON_SPACING,
    _baseY,
    BUTTON_W,
    _offsetH
];
_missionsButton ctrlCommit 0;

_passwordInput ctrlSetPosition [
    MP_PWD_INPUT_X,
    _baseY,
    _rightBorder - MP_PWD_INPUT_X - BUTTON_W - BUTTON_SPACING,
    _offsetH //+ pixelH
];
_passwordInput ctrlSetBackgroundColor [0, 0, 0, 0.75];
_passwordInput ctrlCommit 0;

_passwordButton ctrlSetPosition [
    _rightBorder - BUTTON_W,
    _baseY,
    BUTTON_W,
    _offsetH
];
_passwordButton ctrlCommit 0;

[_passwordInput, _passwordButton, _missionsButton, _displayName] call FUNC(addMultiplayerButtonsLogic);

nil
