#include "script_component.hpp"
/*
 * Author: veteran29
 * Join ArmaForces server from main menu.
 * Based on article from KillZonekid
 *
 * Arguments:
 * 0: Spotlight tile control that was clicked <CONTROL>
 * 1: Server address <STRING>
 * 2: Server port <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_button", "_server", ["_port", 2302]];

// if no world is loaded missionNamespace will be empty
// copy logging function from uiNamespace
if (isNil "CBA_fnc_log") then {
    CBA_fnc_log = uiNamespace getVariable "CBA_fnc_log";
};

// Disable Enchanced Multiplayer Menu for compatiblity with this script
uiNamespace setVariable ["EMM_multiplayerMenu_enabled", false];

INFO_2("Auto joining to %1:%2",_server,_port);

connectToServer [_server, _port, ""];

nil
