/*
    armaforces_diagnostics_fnc_fps_request

    File: fn_fps_request.sqf
    Date: 2019-06-21
    Last Update: 2019-07-29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Request FPS values from clients.

    Parameter(s):
        NONE

    Returns:
        NOTHING
*/
private _list = uiNamespace getVariable [QGVAR(fpsListDialog), controlNull];

lnbClear _list;
_list lnbAddRow ["Player", "FPS Avg ", "FPS Min"];

[QGVAR(fpsRequest), player] call CBA_fnc_globalEvent;

nil
