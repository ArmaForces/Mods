#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if given player should see spectator camera
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call afm_spectator_fnc_canSpectate
 *
 * Public: No
 */

params [["_player", player]];

private _unconscious = if (GVAR(allowUnconscious)) then {
    if (EGVAR(common,aceMedical)) then {
        _player getVariable ["ACE_isUnconscious", false];
    } else {
        lifeState _player isEqualTo "INCAPACITATED"
    };
} else {
    false
};

!(alive player) || {_unconscious}
