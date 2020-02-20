#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function restarts all spectators.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call afm_spectator_fnc_restart
 *
 * Public: No
 */

if (!isServer) exitWith {};

call FUNC(disable);
call FUNC(enable);
