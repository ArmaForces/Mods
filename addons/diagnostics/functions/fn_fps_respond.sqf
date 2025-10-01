/*
    armaforces_diagnostics_fnc_fps_respond

    File: fn_fps_respond.sqf
    Date: 2019-06-21
    Last Update: 2019-06-21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Respond to FPS values request.

    Parameter(s):
        _requester - Player that requested FPS list [OBJECT, defaults to objNull]

    Returns:
        NOTHING
*/
params [
    ["_requester", objNull, [objNull]]
];

["armaforces_fpsResponse",
    [name player, diag_fps toFixed 2, diag_fpsMin toFixed 2],
    _requester
] call CBA_fnc_targetEvent;

nil
