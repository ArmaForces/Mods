#define DEBUG_SYNCHRONOUS
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

// standard margins of text controls
#define MARGINS 0.0016

params [
    ["_status", "Loading..."],
    ["_modlist", "-"],
    ["_players", "-"],
    ["_playersMax", "-"],
    ["_map", "-"]
];
INFO("Updating server status text");

private _ctrlText = uiNamespace getVariable QGVAR(ctrlServerStatus);

///--- Trim modlist text to fit into the container
private _font = "RobotoCondensed";

private _headerW = (format ["%1:  ", LLSTRING(Status)]) getTextWidth [_font, ctrlFontHeight _ctrlText * 1.1];
private _maxW = ctrlPosition _ctrlText select 2;

while {
    private _textW = _modlist getTextWidth [_font, ctrlFontHeight _ctrlText * 1.11];
    private _totalW = _headerW + _textW + MARGINS;

    _totalW > _maxW
} do {
    _modlist = _modlist select [0, count _modlist - 2];
};
///-------------

private _statusText = format [
    ["<t size='1.1'>",
        format ["<br/>%1:  <t size='1'>%2</t>", LLSTRING(Status), '%1'],
        format ["<br/>%1: <t size='1'>%2</t>", LLSTRING(Modlist), '%2'],
        format ["<br/>%1: <t size='1'>%2</t>", LLSTRING(Players), '%3'],
        format ["<br/>%1: <t size='1'>%2</t>", LLSTRING(Map), '%4'],
    "</t>"] joinString "",
    _status,
    _modlist,
    [format ["%1/%2", _players, _playersMax], "-"] select (_playersMax == "-"),
    [_map, "-"] select (_map == "")
];
_ctrlText ctrlSetStructuredText parseText _statusText;

nil
