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
    private _gameTimeCtrl = _display displayCtrl IDC_GAMETIME;

    (ctrlPosition _counterBgCtrl) params ["_offsetW", "", "_offsetW"];
    (ctrlPosition _gameTimeCtrl) params ["", "_y", "_w", "_h"];

    _gameTimeCtrl ctrlSetPosition [_offsetW + _offsetW, _y, _w, _h];
    _gameTimeCtrl ctrlCommit 0;
};

_display call FUNC(addPlayerStatePanel);

nil
