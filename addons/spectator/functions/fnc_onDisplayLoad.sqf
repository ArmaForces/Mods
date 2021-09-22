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

#define COUNTER_TEXT_DISABLED "  --:--.---"

params [["_display", displayNull]];

// prevent gametime and respawn delay overlap
private _counterDisplay = uiNamespace getVariable ["RscRespawnCounter", displayNull];
if (!isNull _counterDisplay) then {

    private _counterTxtCtrl = _counterDisplay displayCtrl IDC_COUNTER_TXT;
    private _counterBgCtrl = _counterDisplay displayCtrl IDC_COUNTER_BG;
    private _counterBg2Ctrl = _counterDisplay displayCtrl IDC_COUNTER_BG2;

    if (ctrlText _counterTxtCtrl == COUNTER_TEXT_DISABLED) exitWith {
        LOG("Respawn disabled, hidding counter");

        {
            _x ctrlSetFade 1;
            _x ctrlCommit 0;
        } forEach [_counterTxtCtrl, _counterBgCtrl, _counterBg2Ctrl];
    };

    private _gameTimeCtrl = _display displayCtrl IDC_GAMETIME;

    (ctrlPosition _counterBgCtrl) params ["_offsetW", "", "_offsetW"];
    (ctrlPosition _gameTimeCtrl) params ["", "_y", "_w", "_h"];

    _gameTimeCtrl ctrlSetPosition [_offsetW + _offsetW, _y, _w, _h];
    _gameTimeCtrl ctrlCommit 0;

    // display state monitor loop
    [{
        params ["_args", "_handle"];
        _args params ["_display", "_gameTimeCtrl", "_counterCtrls"];
        if (isNull _display) exitWith {
            _handle call CBA_fnc_removePerFrameHandler;
        };

        private _fade = ctrlFade _gameTimeCtrl;

        {
            _x ctrlSetFade _fade;
            _x ctrlCommit 0;
        } forEach _counterCtrls;

    }, 0, [_display, _gameTimeCtrl, [_counterBgCtrl, _counterBg2Ctrl, _counterTxtCtrl]]] call CBA_fnc_addPerFrameHandler;
};

_display call FUNC(addPlayerStatePanel);

// Removes death blur if present
if (!isNil "BIS_DeathBlur") then {
    BIS_DeathBlur ppEffectAdjust [0];
    BIS_DeathBlur ppEffectCommit 0;
};

nil
