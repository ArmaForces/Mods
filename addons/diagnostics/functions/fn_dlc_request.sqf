/*
    armaforces_diagnostics_fnc_dlc_request

    File: fn_dlc_request.sqf
    Date: 2019-06-21
    Last Update: 2019-07-29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Request DLC ownership from clients.

    Parameter(s):
        NONE

    Returns:
        NOTHING
*/
private _list = uiNamespace getVariable [QGVAR(dlcListDialog), controlNull];

lnbClear _list;
_list lnbAddRow (["Player"] + (GVAR(dlcList) apply {"-"}));
_list lnbSetCurSelRow 1;

[{
    [QGVAR(dlcRequest), player] call CBA_fnc_globalEvent;
}] call CBA_fnc_execNextFrame;

nil
