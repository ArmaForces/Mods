/*
    armaforces_diagnostics_fnc_update

    File: fnc_update.sqf
    Date: 2019-06-01
    Last Update: 2019-06-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Creates or updates FPS marker.

    Parameter(s):
        _id     - ID of client that is updating fps marker  [NUMBER]
        _offset - Offset of the marker                      [NUMBER]

    Returns:
        NOTHING
*/
params ["_id", "_offset"];

private _fpsMarkerName = format ["%1_%2", QGVAR(fpsMarker), _id];
private _pos = [0, -500 - (400 * _offset)];

private _fpsMarker = createMarker [_fpsMarkerName, _pos];
_fpsMarker setMarkerPos _pos;

_fpsMarker setMarkerType "mil_dot";
_fpsMarker setMarkerSize [0.7, 0.7];

private _localgroups = {local _x} count allGroups;
private _localunits = {local _x} count allUnits;

private _fps = diag_fps;
private _markerColor = switch true do {
    case (_fps < 15): {"ColorRED"};
    case (_fps < 25): {"ColorORANGE"};
    case (_fps < 35): {"ColorYELLOW"};
    default {"ColorGREEN"};
};

_fpsMarker setMarkerColor _markerColor;

_fpsMarker setMarkerText format ["NetID %1:  %2 fps, %3 local groups, %4 local units", _id, _fps toFixed 2, _localgroups, _localunits];

nil
