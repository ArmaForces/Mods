#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function reloads local spectator
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call afm_spectator_fnc_reloadLocal
 *
 * Public: No
 */

WARNING("Reloading spectator!");

if (["IsInitialized"] call BIS_fnc_EGSpectator) then {
    private _oldSpectatorCamera = BIS_EGSpectatorCamera_Camera;
    GVAR(oldSpectatorCamera) = [
        getPos _oldSpectatorCamera,
        vectorDir _oldSpectatorCamera,
        vectorUp _oldSpectatorCamera,
        attachedTo (["GetDummyTarget"] call BIS_fnc_EGSpectatorCamera)
    ];
    [QGVAR(stop)] call CBA_fnc_localEvent;
};

if ([player] call FUNC(canSpectate)) then {
    // Start spectator
    [QGVAR(start)] call CBA_fnc_localEvent;

    // Move camera to last position if spectator was enabled before
    if (!isNil QGVAR(oldSpectatorCamera)) then {
        WARNING("Moving camera to old position.");
        private _newSpectatorCamera = BIS_EGSpectatorCamera_camera;
        _newSpectatorCamera setPos (GVAR(oldSpectatorCamera) select 0);
        _newSpectatorCamera setVectorDir (GVAR(oldSpectatorCamera) select 1);
        _newSpectatorCamera setVectorUp (GVAR(oldSpectatorCamera) select 2);
        private _targetObject = GVAR(oldSpectatorCamera) select 3;
        if (!(_targetObject isEqualTo objNull)) then {
            [_targetObject] call BIS_fnc_EGSpectatorCameraSetTarget;
        };
    };
};

GVAR(oldSpectatorCamera) = nil;
