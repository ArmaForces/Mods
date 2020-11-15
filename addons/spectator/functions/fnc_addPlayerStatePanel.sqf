#include "script_component.hpp"
/*
 * Author: veteran29
 * Adds player state to spectator display.
 *
 * Arguments:
 * 0: Spectator display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define PLAYER_STATE_INITIAL_POS [safeZoneX + safeZoneW/2 - (2 * _h), safeZoneY + safeZoneH/2, _w + _h, _h]
#define PLAYER_STATE_TARGET_POS [_offsetX + _w, _y, _w + _h, _h]

#define STATE_ICON (["\a3\ui_f\data\igui\cfg\mptable\killed_ca.paa", "\a3\missions_f_oldman\data\img\hints\sleeping_ca.paa"] select alive player)
#define STATE_TEXT ([LLSTRING(State_Dead), LLSTRING(State_Alive)] select alive player)

params ["_display"];

private _tabsCtrl = _display displayCtrl IDC_TABS;
(ctrlPosition _tabsCtrl) params ["_offsetX", "_y", "_w", "_h"];

private _ctrlPlayerStateGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_ctrlPlayerStateGroup ctrlSetPosition PLAYER_STATE_INITIAL_POS;
_ctrlPlayerStateGroup ctrlCommit 0;

private _ctrlPlayerStateIcon = _display ctrlCreate ["RscPicture", -1, _ctrlPlayerStateGroup];
_ctrlPlayerStateIcon ctrlSetPosition [0, 0, _h, _h];
_ctrlPlayerStateIcon ctrlSetText STATE_ICON;
_ctrlPlayerStateIcon ctrlCommit 0;

private _ctrlPlayerStateText = _display ctrlCreate ["RscText", -1, _ctrlPlayerStateGroup];
_ctrlPlayerStateText ctrlSetPosition [_h, 0, _w, _h];
_ctrlPlayerStateText ctrlSetText STATE_TEXT;
_ctrlPlayerStateText ctrlCommit 0;

// move the player state icons to corner after delay and start PFH
[{
    params ["_display", "_ctrlPlayerStateGroup", "_ctrlPlayerStateText", "_ctrlPlayerStateIcon"];
    private _tabsCtrl = _display displayCtrl IDC_TABS;
    (ctrlPosition _tabsCtrl) params ["_offsetX", "_y", "_w", "_h"];

    _ctrlPlayerStateGroup ctrlSetPosition PLAYER_STATE_TARGET_POS;
    _ctrlPlayerStateGroup ctrlCommit 1;

    // display state monitor loop
    [{
        params ["_args", "_handle"];
        _args params ["_display", "_ctrlPlayerStateText", "_ctrlPlayerStateIcon"];
        if (isNull _display) exitWith {
            _handle call CBA_fnc_removePerFrameHandler;
        };

        private _ctrlTabs = _display displayCtrl IDC_TABS;
        private _fade = ctrlFade _ctrlTabs;

        _ctrlPlayerStateText ctrlSetText STATE_TEXT;
        _ctrlPlayerStateIcon ctrlSetText STATE_ICON;

        _ctrlPlayerStateText ctrlSetFade _fade;
        _ctrlPlayerStateIcon ctrlSetFade _fade;

        _ctrlPlayerStateText ctrlCommit 0;
        _ctrlPlayerStateIcon ctrlCommit 0;

    }, 0, [_display, _ctrlPlayerStateText, _ctrlPlayerStateIcon]] call CBA_fnc_addPerFrameHandler;

}, [_display, _ctrlPlayerStateGroup, _ctrlPlayerStateText, _ctrlPlayerStateIcon], 5] call CBA_fnc_waitAndExecute;
