#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Adjusts initial direct speech volume for local player based on CBA settings.
 * Works also for players JIP.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!hasInterface) exitWith { nil };

private _volumeLevel = [GVAR(startBppVolume), GVAR(startLeaderVolume)] select (player isEqualTo leader player);

private _volume = switch (round _volumeLevel) do {
    case 0: {0.1};
    case 1: {0.4};
    case 2: {0.7};
    case 3: {1};
    case 4: {1.3};
    default {0.7};
};

[_volume] call acre_api_fnc_setSelectableVoiceCurve;

[{
    acre_sys_gui_volumeLevel = _this;
}, round _volumeLevel / 4] call CBA_fnc_execNextFrame;

nil
