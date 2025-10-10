/*
    armaforces_diagnostics_fnc_dlc_open

    File: fn_dlc_open.sqf
    Date: 2019-06-21
    Last Update: 2019-07-29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Handle DLC List display open.

    Parameter(s):
        _display - DLC List display [DISPLAY, defaults to displayNull]

    Returns:
        NOTHING
*/
params [
    ["_display", displayNull, [displayNull]]
];

if !([] call BIS_fnc_isDebugConsoleAllowed) exitWith {
    ["No debug console access"] call CBA_fnc_notify;
};

private _width = safezoneW * 0.75;

// Confirm
private _confirm = _display ctrlCreate ["RscButtonMenu", 10];
uiNamespace setVariable [QGVAR(dlcConfirm), _confirm];

private _confirmHeight = safezoneH / 23;
private _confirmY = safezoneY + safezoneH/1.3 - 1.1 * _confirmHeight;

_confirm ctrlSetPosition [
    0.5 - _width/2 + _width*0.2,
    _confirmY,
    _width*0.8, _confirmHeight
];
_confirm ctrlCommit 0;
_confirm ctrlSetText toUpper "REFRESH";

_confirm ctrlAddEventHandler ["MouseButtonDown", {
    params ["_confirm", "_button"];
    if (_button != 0) exitWith {};
    _confirm ctrlEnable false;
    [{_this ctrlEnable true}, _confirm, 2] call CBA_fnc_waitAndExecute;

    [] call FUNC(dlcRequest);
}];

private _close = _display ctrlCreate ["RscButtonMenu", 1];
_close ctrlSetPosition [
    0.5 - _width/2,
    _confirmY,
    _width*0.2, _confirmHeight
];
_close ctrlCommit 0;
_close ctrlSetText "CLOSE";

// List
private _listHeight = safezoneH/2;

private _listBg = _display ctrlCreate ["RscText", 2]; // centered RscListNBox
_listBg ctrlSetBackgroundColor [0,0,0,0.8];

private _list = _display ctrlCreate ["RscListNBox", 3]; // centered RscListNBox
uiNamespace setVariable [QGVAR(dlcListDialog), _list];

_list lnbAddRow (["Player"] + (GVAR(dlcList) apply {""}));

private _listColOffsets = [];
{
    _x params ["", "_name"];

    _listColOffsets pushBack 0.12 + ((1 - 0.12) / count GVAR(dlcList)) * _forEachIndex;
} forEach GVAR(dlcList);

_list lnbSetColumnsPos ([0] + _listColOffsets);

{
    _x ctrlSetPosition [
        0.5 - _width / 2,
        _confirmY - _listHeight - _confirmHeight/10 ,
        _width, _listHeight
    ];
    _x ctrlCommit 0;
} forEach [_listBg, _list];

[] call FUNC(dlcRequest);

nil
