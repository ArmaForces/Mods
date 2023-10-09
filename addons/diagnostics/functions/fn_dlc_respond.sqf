/*
    armaforces_diagnostics_fnc_dlc_respond

    File: fn_dlc_respond.sqf
    Date: 2019-07-28
    Last Update: 2019-07-29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Respond to DLC ownership request.

    Parameter(s):
        _requester - Player that requested DLC list [OBJECT, defaults to objNull]

    Returns:
        NOTHING
*/
params [
    ["_requester", objNull, [objNull]]
];

private _ownedIds = getDLCs 1;

private _DLCs = GVAR(dlcList);

private _DLCsData = _DLCs apply {
    _x params ["_id", "_name"];

    [_name, _id in _ownedIds];
};

[QGVAR(dlcResponse),
    [name player, _DLCsData],
    _requester
] call CBA_fnc_targetEvent;

nil
