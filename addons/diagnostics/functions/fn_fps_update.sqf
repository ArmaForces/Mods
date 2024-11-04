/*
    armaforces_diagnostics_fnc_fps_update

    File: fn_fps_update.sqf
    Date: 2019-06-21
    Last Update: 2019-07-29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Update FPS List display contents.

    Parameter(s):
        NONE

    Returns:
        NOTHING
*/
private _list = uiNamespace getVariable [QGVAR(fpsListDialog), controlNull];

_list lnbAddRow _this;

// Colorize cells depending on fps value
private _lastRow = (lnbSize _list)#0 - 1;
params ["", "_fps", "_fpsMin"];
// AVG FPS
switch (true) do {
    case (parseNumber _fps < 20): {
        _list lnbSetColor [[_lastRow, 1], [1,0,0,1]];
    };
    case (parseNumber _fps < 40): {
        _list lnbSetColor [[_lastRow, 1], [1,1,0,1]];
    };
    default {
        _list lnbSetColor [[_lastRow, 1], [0,1,0,1]];
    };
};
// MIN FPS
switch (true) do {
    case (parseNumber _fpsMin < 20): {
        _list lnbSetColor [[_lastRow, 2], [1,0,0,1]];
    };
    case (parseNumber _fpsMin < 40): {
        _list lnbSetColor [[_lastRow, 2], [1,1,0,1]];
    };
    default {
        _list lnbSetColor [[_lastRow, 2], [0,1,0,1]];
    };
};

_list lnbSortByValue [0, false];

nil
