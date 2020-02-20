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

WARNING("Restarting spectator!");
[QGVAR(reloadLocal)] call CBA_fnc_globalEvent;

nil
