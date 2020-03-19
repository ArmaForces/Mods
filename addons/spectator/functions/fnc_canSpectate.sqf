#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if given player should see spectator camera
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 *
 * Return Value:
 * Can spectate <BOOL>
 *
 * Example:
 * [player] call afm_spectator_fnc_canSpectate
 *
 * Public: No
 */

params [["_player", player]];

!(alive _player)
|| {GVAR(allowUnconscious)
&& {[_player] call EFUNC(common,isUnconscious)}}
