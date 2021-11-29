#include "script_component.hpp"
/*
 * Author: veteran29
 * Update main menu server status text
 *
 * Arguments:
 * 0: Server status <STRING>
 * 1: Modlist       <STRING>
 * 2: Players count <NUMBER>
 * 3: Max players   <NUMBER>
 * 4: Server map    <STRING>
 *
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params [
    ["_status", "Loading..."],
    ["_modlist", "-"],
    ["_players", 0],
    ["_maxplayers", 0],
    ["_map", "-"]
];

private _statusText = format ["<br/>Status: %1<br/>Modlist: %2<br/>Players: %3/%4<br/>Map: %5", _status, _modlist, _players, _maxplayers, _map];
(uiNamespace getVariable QGVAR(ctrlServerStatus)) ctrlSetStructuredText parseText _statusText;

nil
