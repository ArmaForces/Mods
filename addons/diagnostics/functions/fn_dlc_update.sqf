/*
    armaforces_diagnostics_fnc_dlc_update

    File: fn_dlc_update.sqf
    Date: 2019-06-21
    Last Update: 2019-07-29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Update DLC List display contents.

    Parameter(s):
        NONE

    Returns:
        NOTHING
*/
params [
    ["_playerName", "", [""]],
    ["_DLCsData", [], []]
];

private _list = uiNamespace getVariable [QGVAR(dlcListDialog), controlNull];

private _lastRow = _list lnbAddRow ([_playerName] + (_DLCsData apply {_x select 0}));

private ["_color"];
{
    _color = [[1,0,0,1], [0,1,0,1]] select _x;
    _list lnbSetColor [[_lastRow, _forEachIndex+1], _color];
} forEach (_DLCsData apply {_x select 1})


