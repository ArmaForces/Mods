#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

#include "initSettings.sqf"

GVAR(dlcList) = [
    [288520,  "Karts"],
    [304380,  "Helicopters"],
    [332350,  "Marksman"],
    [395180,  "Apex"],
    [571710,  "Laws of War"],
    [601670,  "Jets"],
    [744950,  "Tac Ops"],
    [798390,  "Tanks"],
    [1021790, "Contact"],
    [1042220, "GM"],
    // TODO: IDs for remaining DLCs
    []
];

if (hasInterface) then {
    ["DLC List", QGVAR(dlcListDialog)] call CBA_fnc_addPauseMenuOption;
    ["FPS List", QGVAR(fpsListDialog)] call CBA_fnc_addPauseMenuOption;

    [QGVAR(dlcRequest), FUNC(dlcRespond)] call CBA_fnc_addEventHandler;
    [QGVAR(dlcResponse), FUNC(dlcUpdate)] call CBA_fnc_addEventHandler;

    [QGVAR(fpsRequest), FUNC(fpsRespond)] call CBA_fnc_addEventHandler;
    [QGVAR(fpsResponse), FUNC(fpsUpdate)] call CBA_fnc_addEventHandler;
};

if (!isServer) exitWith {};

if (!QGVAR(markersEnabled)) exitWith {};

// By default only server is an FPS diag target
GVAR(fpsTargets) = [2];

// Add headless clients to diag targets when they join
addMissionEventHandler ["PlayerConnected", {
    params ["", "_uid", "", "", "_owner"];
    if ((_uid select [0,2] != "HC")) exitWith {};

    GVAR(fpsTargets) pushBack _owner;
}];

// Cleanup headless client markers on disconnect
addMissionEventHandler ["PlayerDisconnected", {
    params ["", "_uid", "", "", "_owner"];
    if ((_uid select [0,2] != "HC")) exitWith {};

    GVAR(fpsTargets) = GVAR(fpsTargets) - [_owner];

    private _fpsMarker = format ["%1_%2", QGVAR(fpsMarker), _owner];
    deleteMarker _fpsMarker;
}];

[{
    {
        [_x, _forEachIndex] remoteExec [QFUNC(updateDiagnosticMarker), _x];
    } forEach GVAR(fpsTargets);
}, 15] call CBA_fnc_addPerFrameHandler;
