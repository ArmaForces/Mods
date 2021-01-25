#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle spectator display load.
 *
 * Arguments:
 * 0: Spectator display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params [["_display", displayNull]];

// prevent gametime and respawn delay overlap
private _counterDisplay = uiNamespace getVariable ["RscRespawnCounter", displayNull];
if (!isNull _counterDisplay) then {
    private _counterBgCtrl = _counterDisplay displayCtrl IDC_COUNTER_BG;
    private _counterBg2Ctrl = _counterDisplay displayCtrl IDC_COUNTER_BG2;
    private _counterTxtCtrl = _counterDisplay displayCtrl IDC_COUNTER_TXT;
    private _gameTimeCtrl = _display displayCtrl IDC_GAMETIME;

    (ctrlPosition _counterBgCtrl) params ["_offsetW", "", "_offsetW"];
    (ctrlPosition _gameTimeCtrl) params ["", "_y", "_w", "_h"];

    _gameTimeCtrl ctrlSetPosition [_offsetW + _offsetW, _y, _w, _h];
    _gameTimeCtrl ctrlCommit 0;

    // display state monitor loop
    [{
        params ["_args", "_handle"];
        _args params ["_display", "_counterBgCtrl", "_counterBg2Ctrl", "_counterTxtCtrl", "_gameTimeCtrl"];
        if (isNull _display) exitWith {
            _handle call CBA_fnc_removePerFrameHandler;
        };

        private _fade = ctrlFade _gameTimeCtrl;

        _counterTxtCtrl ctrlSetFade _fade;
        _counterTxtCtrl ctrlCommit 0;

        _counterBgCtrl ctrlSetFade _fade;
        _counterBgCtrl ctrlCommit 0;

        _counterBg2Ctrl ctrlSetFade _fade;
        _counterBg2Ctrl ctrlCommit 0;

    }, 0, [_display, _counterBgCtrl, _counterBg2Ctrl, _counterTxtCtrl, _gameTimeCtrl]] call CBA_fnc_addPerFrameHandler;
};

_display call FUNC(addPlayerStatePanel);

nil
